import React, { Component } from 'react'
import { BrowserRouter as Router, Route, Link, Switch } from 'react-router-dom';
import { ThemeProvider } from '@material-ui/styles'
import { CssBaseline, AppBar, Toolbar, Menu, MenuItem, MenuList} from '@material-ui/core'
import theme from './style/theme'
import MenuLinks from './components/Menu'


import Button from '@material-ui/core/Button';

import Login from './components/Login'
import Account from './components/Account'
import Category from './components/Category'
import Schedule from './components/Schedule'
import Attended from './components/Attended'
import Attending from './components/Attending'

import './App.scss';


class App extends Component {
  constructor () {
    super()
    this.state = {}
  }

  componentDidMount() {
    window.addEventListener('click', this.handleCloseMenu.bind(this));
  }

  handleCloseMenu(event) {
    console.log(event)
    if (!event.target.matches('.dropdown-btn')) {
      var dropdowns = document.getElementsByClassName("dropdown-content");
      var i;
      for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  }

  handleShowMenu() {
    document.getElementById("myDropdown").classList.toggle("show");
  }

  render () {
    return (
      <ThemeProvider theme={theme} >
        <CssBaseline>
        <Router>
          <div className='App'>
              <AppBar>
                <MenuLinks />
              </AppBar>

            <section>
              <Switch>
                <Route exact path="/" component={Category} />
                <Route exact path="/login" component={Login} />
                <Route exact path="/account" component={Account} />
                <Route exact path="/schedule" component={Schedule} />
                <Route exact path="/attended" component={Attended} />
                <Route exact path="/attending" component={Attending} />
              </Switch>
            </section>

          </div>
        </Router>
        </CssBaseline>
      </ThemeProvider>
    )
  }
}

export default App;
