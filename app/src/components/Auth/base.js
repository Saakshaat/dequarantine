import * as firebase from "firebase/app";
import "firebase/auth";

const app = firebase.initializeApp({
  apiKey: "AIzaSyBd1r9PD9IRGs7-gdWoig-vjsvIZ2zpU5E",
  authDomain: "dequarantine-aae5f.firebaseapp.com",
  databaseURL: "https://dequarantine-aae5f.firebaseio.com",
  projectId: "dequarantine-aae5f",
  storageBucket: "dequarantine-aae5f.appspot.com",
  messagingSenderId: "828379572147",
  appId: "1:828379572147:web:f653c186b0fad986284dc6",
  measurementId: "G-BMVNRLZBWH"
});

export default app;