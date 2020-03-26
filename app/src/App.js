import React from 'react';
import { BrowserRouter as Router, Route, Link, Switch } from 'react-router-dom';
import Login from './components/Login'
import Account from './components/Account'
import Category from './components/Category'
import Schedule from './components/Schedule'
import Attended from './components/Attended'
import Attending from './components/Attending'

import './App.scss';


function App() {
  return (
    <Router>
      <div className='App'>
        <ul>
          <li><Link to="/">Home</Link></li>
          <li><Link to="/login">Login</Link></li>
          <li><Link to="/account">Account</Link></li>
          <li><Link to="/schedule">Schedule</Link></li>
          <li><Link to="/attended">Attended</Link></li>
          <li><Link to="/attending">Attending</Link></li>
        </ul>

        <Switch>
          <Route exact path="/" component={Category} />
          <Route exact path="/login" component={Login} />
          <Route exact path="/account" component={Account} />
          <Route exact path="/schedule" component={Schedule} />
          <Route exact path="/attended" component={Attended} />
          <Route exact path="/attending" component={Attending} />
        </Switch>
      </div>
    </Router>
  );
}

export default App;
