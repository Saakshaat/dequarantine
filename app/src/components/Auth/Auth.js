import React, { useEffect, useState, createContext } from "react";
import app from "./base.js";

export const AuthContext = createContext()

export const AuthProvider = ({ children }) => {
  const [currentUser, setCurrentUser] = useState("");
  const [pending, setPending] = useState(true);

//   useEffect(() => {
//     app.auth().onAuthStateChanged((user) => {
//       setCurrentUser(user)
//       setPending(false)
//     });
//   }, []);

  if(!pending){
    return <>Loading...</>
  }

  return (
    <AuthContext.Provider
      value={()=>{
          return ({currentUser, setCurrentUser})
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};