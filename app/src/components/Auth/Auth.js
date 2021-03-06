import React, { useEffect, useState, createContext } from "react";
import app from "./base.js";

export const AuthContext = createContext()

export const AuthProvider = ({ children }) => {
  const [currentUser, setCurrentUser] = useState(null || localStorage.getItem('user'));
  const [pending, setPending] = useState(true);
  return (
    <AuthContext.Provider
      value={
          {currentUser, setCurrentUser}
      }
    >
      {children}
    </AuthContext.Provider>
  );
};