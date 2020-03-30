const { admin, db } = require("../util/admin");
const config = require("../util/config");

const firebase = require('firebase');
firebase.initializeApp(config);

const provider = new firebase.auth.GoogleAuthProvider();

const {
    validateSignUpData,
    validateLoginData,
    reduceUserDetails
} = require("../util/validators");

//User Signup [New Account Creation]
exports.signup = (req, res) => {
    const newUser = {
        email: req.body.email,
        password: req.body.password,
        confirmPassword: req.body.confirmPassword,
        userName: req.body.userName
      };
    
    const { valid, errors } = validateSignUpData(newUser);
    if (!valid) return res.status(400).json(errors);
    const noImg = `no-img.png`;

    let token, userId;
    db.doc(`/users/${newUser.userName}`)
    .get()
    .then(doc => {
      if (doc.exists) {
        return res.status(400).json({ userName: `this User Name is already taken` });
      } else {
        return firebase
          .auth()
          .createUserWithEmailAndPassword(newUser.email, newUser.password);
      }
    })
    .then(data => {
      userId = data.user.uid;
      return data.user.getIdToken();
    })
    .then(idToken => {
      token = idToken;
      attending = [];
      const userCredentials = {
        userName: newUser.userName,
        email: newUser.email,
        imageUrl: `https://firebasestorage.googleapis.com/v0/b/${config.storageBucket}/o/${noImg}?alt=media`,
        createdAt: new Date().toISOString(),
        userId,
        attending
      };
      db.doc(`/users/${newUser.userName}`).set(userCredentials);
    })
    .then(() => {
      return res.status(201).json({ token });
    })
    .catch(err => {
      console.error(err);
      if (err.code == "auth/email-already-in-use") {
        return res.status(400).json({ email: `Account already in use` });
      } else {
        return res
          .status(500)
          .json({ general: `Something went wrong :( Please try again later` });
      }
    });
};

//Manual Login using email and password
exports.login = (req, res) => {
    const user = {
        email: req.body.email,
        password: req.body.password
    };

    const { valid, errors } = validateLoginData(user);
    if (!valid) return res.status(400).json(errors);

    firebase
        .auth()
        .signInWithEmailAndPassword(user.email, user.password)
        .then(data => {
        return data.user.getIdToken();
        })
        .then(token => {
        return res.json({ token });
        })
        .catch(err => {
        console.error(err);
        return res
            .status(403)
            .json({ general: `Wrong credentials, please try again` });
        });
};


//Password Forget Request | User gets an email from a support account with Password Reset Link
exports.forgotPassword = (req, res) => {
    firebase
      .auth()
      .sendPasswordResetEmail(req.body.email)
      .then(data => {
        console.log("Password reset link sent");
      })
      .catch(err => {
        return res
          .status(400)
          .json({
            general: `Couldn't send reset link. Try to remember password`
          });
      });
  };

//Google Signin with a Pop-Up
/**
 * TODO: Make working Google Signin which
 * - Creates a new object in the user collection if
 *  * no user object exists with the returned email
 *  
 * - If there is a user account with the same email as returned by the Google API, then
 *  * Sign them in
 *  * Get the generated token
 *  * Use the token to authorize access person and keep them signed in
 */
exports.googleSignin = (req, res) => {
    firebase
    .auth().signInWithPopup(provider)
    .then((result) => {
        // This gives you a Google Access Token. You can use it to access the Google API.
        var token = result.credential.accessToken;
        // The signed-in user info.
        var user = result.user;
        attending = [];
        console.log(user);
        const userCredentials = {
          userName: user.displayName,
          email: user.email,
          imageUrl: user.photoUrl,
          createdAt: new Date().toISOString(),
          userId: user.uid,
          attending
        };
        db.doc(`/users/${user.userName}`).set(userCredentials);
        return res.json({ token });
    })
    .catch(err => {
      console.error(err);
      return res.status(500).json({ general: `Internal Server Error ${err}` });
    })
};


//Adding user details
exports.addUserDetails = (req, res) => {
  let userDetails = reduceUserDetails(req.body);
  db.doc(`/users/${req.user.userName}`)
    .update(userDetails)
    .then(() => {
      return res.json({ message: `Details added successfully` });
    })
    .catch(err => {
      console.error(err);
      return res.status(500).json({ error: err.code });
    });
};

/**
 * Get User Account Data
 * - Image
 * - Email
 * - Name
 * - Upcoming Events
 */
exports.getAuthenticatedUser = (req, res) => {
  let userData = {};
  db.doc(`/users/${req.user.userName}`)
    .get()
    .then(doc => {
      if (doc.exists) {
        userData.credentials = doc.data();
        return db
          .collection("events")
          .where("participants", "array-contains", req.user.userName)
          .get();
      }
    })
    .then(data => {
      userData.attending = [];
      data.forEach(doc => {
        userData.attending.push(doc.data());
      });
      return res.json(userData);
    })
    .catch(err => {
      console.error(err);
      return res.status(500).json({ error: err.code });
    });
};

exports.uploadImage = (req, res) => {
  const BusBoy = require("busboy");
  const path = require("path");
  const os = require("os");
  const fs = require("fs");

  const busboy = new BusBoy({ headers: req.headers });

  let imageFileName;
  let imageToBeUploaded = {};

  busboy.on("file", (fieldname, file, filename, encoding, mimetype) => {
    console.log(fieldname, file, filename, encoding, mimetype);
    if (mimetype !== "image/jpeg" && mimetype !== "image/png") {
      return res.status(400).json({ error: "Wrong file type submitted" });
    }
    const imageExtension = filename.split(".")[filename.split(".").length - 1];

    imageFileName = `${Math.round(
      Math.random() * 1000000000000
    ).toString()}.${imageExtension}`;
    const filepath = path.join(os.tmpdir(), imageFileName);
    imageToBeUploaded = { filepath, mimetype };
    file.pipe(fs.createWriteStream(filepath));
  });
  busboy.on("finish", () => {
    admin
      .storage()
      .bucket()
      .upload(imageToBeUploaded.filepath, {
        resumable: false,
        metadata: {
          metadata: {
            contentType: imageToBeUploaded.mimetype
          }
        }
      })
      .then(() => {
        const imageUrl = `https://firebasestorage.googleapis.com/v0/b/${config.storageBucket}/o/${imageFileName}?alt=media`;
        return db.doc(`/users/${req.user.userName}`).update({ imageUrl });
      })
      .then(() => {
        return res.json({ message: "image uploaded successfully" });
      })
      .catch(err => {
        console.error(err);
        return res.status(500).json({ error: "something went wrong" });
      });
  });
  busboy.end(req.rawBody);
}