import React, {createContext, useState, useEffect} from 'react';
import app from './base'

export const AuthContext = createContext()

const AuthProvider = ({children}) => {
    const [currentUser, setUser] = useState('');
    // useEffect(()=>{
    //     app.auth().onAuthStateChanged((user)=>{
    //         setUser(user)
    //     })
    // },[])

    return (
        <AuthContext.Provider value={{currentUser, setUser}}>
            {children}
        </AuthContext.Provider>
    )
}

export default AuthProvider
