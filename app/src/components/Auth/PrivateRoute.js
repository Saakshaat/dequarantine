import React, { useState, useEffect, useContext} from 'react'

import {Route, Redirect } from 'react-router-dom'
import AuthContext from './base'

const PrivateRoute = ({component : RouteComponent, ...rest}) => {
    const currentUser   = localStorage.getItem('user')

    return (
        <Route
        {...rest}
        render={routeProps =>
          currentUser ? (
            <RouteComponent {...routeProps} />
          ) : (
            <Redirect to={"/login"} />
          )
        }
      />
    )
}

export default PrivateRoute
