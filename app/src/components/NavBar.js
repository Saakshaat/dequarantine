import React, { useState, useEffect, useContext } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';
import IconButton from '@material-ui/core/IconButton';
import { Tabs, Tab } from '@material-ui/core'
import {Link , Redirect, withRouter} from 'react-router-dom'
import { AuthContext } from './Auth/Auth'



const useStyles = makeStyles(theme => ({
  root: {
    flexGrow: 1,
    background : theme.palette.primary
  },
  title: {
    flexGrow: 1,
    color : "#ffffff"
  },
  tabsContainer : {
      marginLeft : "auto"
  },
  tab : {
      fontSize : "1rem",
      textTransform : "none",
      fontWeight : "700",
      minWidth : "10",
      color : "#ffffff"
  },
  img : {
    borderRadius : "100px",
    height : "60px",
    width : "60px",
    padding: "5px"
  }
}));

const ButtonAppBar = function({ history }) {
  const user = localStorage.getItem('user');

  const [navigate, setNavigate] = useState(false)
  const { currentUser, setCurrentUser } = useContext(AuthContext)
  const classes = useStyles();

  const signOutHandler = (e) =>{
    console.log("clearing local storage")
    localStorage.clear('user');
    console.log('logging out')
    window.location.pathname='/login'

  }

  const redirectHandler =()=>{
    return(<Redirect to='/login' />)

  }

  const [value, setValue] = React.useState(0);
  const handleChange = (event, newValue) => {
    setValue(newValue);
  };

  useEffect(()=>{
      if(window.location.pathname === "/" && value !== 0){
          setValue(0)
      }
      if(window.location.pathname === "/projects" && value !== 1){
          setValue(1)
      }
  })


  return (
    <div className={classes.root}>
      <AppBar position="static" color="secondary">
        <Toolbar>
          <img src="" className={classes.img} />
            <Tabs value={value} className={classes.tabsContainer} onChange={handleChange}>
                <Tab value={0} className={classes.tab} label={<i class="fas fa-home">  Home</i>} component={Link} to="/" />
                <Tab  value={1} className={classes.tab} label={<i class="fas fa-tasks">My Profile</i>} component={Link} to="/projects" />
                {currentUser ? <Button onClick={signOutHandler}>Sign Out</Button> : <Redirect to="/login"  push={true} /> }
            </Tabs>
        </Toolbar>
      </AppBar>
    </div>
  );
}
export default withRouter(ButtonAppBar)