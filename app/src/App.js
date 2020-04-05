import React, { Component } from 'react'
import { BrowserRouter as Router, Route, Link, Switch } from 'react-router-dom';
import { Button, AppBar, Toolbar, Tabs, Tab, makeStyles, CssBaseline, withStyles }  from '@material-ui/core';
import { ThemeProvider } from '@material-ui/styles'
import Attending from './components/Attending'
import theme  from './style/theme'
import Nav from './components/NavBar'
import Home from './components/Home'
import { AuthProvider } from './components/Auth/Auth'
import Account from './components/Account'
import Login from './components/Login'
import PrivateRoute from './components/Auth/PrivateRoute'

const App = ()=>{

    return (
      <ThemeProvider theme={theme}>
      <AuthProvider>
          <CssBaseline>
            <Router>
              <Nav />
              <Switch>
                <Route exact path="/" component={Home} />
                <PrivateRoute exact path="/profile" component={Home} />
                <Route exact path="/login" component={Login} />
              </Switch>
            </Router>
          </CssBaseline>
         </AuthProvider>
         </ThemeProvider>
    )
}

export default App;
