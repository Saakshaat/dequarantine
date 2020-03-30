const functions = require('firebase-functions');
const app = require("express")();
const FBAuth = require("./util/FBAuth.js");
const { db } = require("./util/admin");

const cors = require('cors');
app.use(cors());

const {
    signup,
    login,
    forgotPassword,
    googleSignin,
    uploadImage,
    addUserDetails,
    getAuthenticatedUser,
    getUserDetails,
    markNotificationsRead,
} = require("./handlers/users"); 

const {
    getAllEvents,
    getOneEvent,
    postEvents,
    deleteEvents,
    markAttended,
    unmarkAttending
} = require("./handlers/events");

//users routes
app.post("/signup", signup);
app.post("/login", login);
app.post("/user/password", forgotPassword);
app.post("/g/signin", googleSignin);
app.post("/user", FBAuth, addUserDetails);
app.post("/user/image", FBAuth, uploadImage);
app.get("/user", FBAuth, getAuthenticatedUser);

//events routes
app.get("/events",getAllEvents);
//app.get("/events",getOneEvent)

app.post("/events", FBAuth, postEvents);
app.delete("/events/:eventId", FBAuth, deleteEvents);
app.get("/events/markAttended/:eventId",FBAuth,markAttended)

/**
 * TODO: write all the user methods for basic user functionality
app.post("/user/image", FBAuth, uploadImage);
app.get("user/:handle", getUserDetails);
app.post("/notifications", FBAuth, markNotificationsRead);
 */

exports.baseapi = functions.https.onRequest(app);
