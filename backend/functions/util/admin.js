var serviceAccount = require("./permission.json");
const admin = require('firebase-admin');
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://fir-api-9a206..firebaseio.com"
});
const db = admin.firestore();
module.exports = { admin, db };