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
    getAttending
} = require("./handlers/users"); 

const {
    getAllEvents,
    getOneEvent,
    postEvents,
    deleteEvents,
    markAttended,
    unmarkAttending,
    getParticipants,
    getCategoryEvents
} = require("./handlers/events");

//users routes
app.post("/signup", signup);
app.post("/login", login);
app.post("/user/password", forgotPassword);
app.post("/g/signin", googleSignin);
app.post("/user", FBAuth, addUserDetails);
app.post("/user/image", FBAuth, uploadImage);
app.get("/user", FBAuth, getAuthenticatedUser);
app.get("/user/attending", FBAuth, getAttending);

//events routes
app.get("/events",getAllEvents);
app.get("/event/:eventId",getOneEvent)
app.post("/events", FBAuth, postEvents);
app.delete("/events/:eventId", FBAuth, deleteEvents);
app.get("/events/markAttended/:eventId",FBAuth,markAttended);
//app.get("/events/unmarkAttended/:eventId",FBAuth,unmarkAttended);
app.get("/event/:eventId/participants", FBAuth, getParticipants);
app.get("/events/category/:categoryName", getCategoryEvents);

/**
 * TODO: write all the user methods for basic user functionality
app.get("user/:handle", getUserDetails);
app.post("/notifications", FBAuth, markNotificationsRead);
 */

exports.baseapi = functions.https.onRequest(app);
