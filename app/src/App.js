import React, { Component } from 'react'
import { BrowserRouter as Router, Route, Link, Switch } from 'react-router-dom';
import { Button, AppBar, Toolbar, Tabs, Tab, makeStyles, CssBaseline, withStyles }  from '@material-ui/core';
import { ThemeProvider } from '@material-ui/styles'
import Attending from './components/Attending'
import theme  from './style/theme'
import Nav from './components/NavBar'
import Home from './components/Home'

const App = ()=>{
    return (
      <ThemeProvider theme={theme}>
        <CssBaseline>
          <Router>
            <Nav />
            <Switch>
              <Route exact path="/events" component={Attending} />
              <Route exact path="/" component={Home} />
            </Switch>
          </Router>
        </CssBaseline>
      </ThemeProvider>
    )
}

export default App;
