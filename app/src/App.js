import React, { Component } from 'react'
import { BrowserRouter as Router, Route, Link, Switch } from 'react-router-dom';

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
      <Router>
        <div className='App'>
          <header>
            <div className='title'>Dequarantine</div>
            <nav class="dropdown">
              <button
                className="dropdown-btn" 
                onClick={this.handleShowMenu.bind(this)} 
                variant="contained" 
                color="primary"
              >
                MENU
              </button>
              <div id="myDropdown" class="dropdown-content">
                <Link to="/">Home</Link>
                <Link to="/login">Login</Link>
                <Link to="/account">Account</Link>
                <Link to="/schedule">Schedule</Link>
                <Link to="/attended">Attended</Link>
                <Link to="/attending">Attending</Link>
              </div>
            </nav>
          </header>

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
    )
  }
}

export default App;
