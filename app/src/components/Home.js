import React, {useState, useEffect} from 'react';
import { makeStyles } from '@material-ui/core/styles';
import {Paper, Container, Button, Grid }from '@material-ui/core';
import PropTypes from 'prop-types';
import AppBar from '@material-ui/core/AppBar';
import CssBaseline from '@material-ui/core/CssBaseline';
import Divider from '@material-ui/core/Divider';
import Hidden from '@material-ui/core/Hidden';
import IconButton from '@material-ui/core/IconButton';
import InboxIcon from '@material-ui/icons/MoveToInbox';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemIcon from '@material-ui/core/ListItemIcon';
import ListItemText from '@material-ui/core/ListItemText';
import MailIcon from '@material-ui/icons/Mail';
import MenuIcon from '@material-ui/icons/Menu';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import { useTheme } from '@material-ui/core/styles';
import Attending from './Attending';
import axios from 'axios';
import EventCard from './EventCard';

const useStyles = makeStyles((theme) => ({
  root: {
    display: 'flex',
    flexDirection : "row",
    width: "2400px",
    height : "90vh",
  },
  container : {
      width : "100%",
      height : "85vh",
      boxShadow : theme.shadows[7]
  },
  Divider: 
  {
    paddingTop: "10px"
  },
  list : {
    display : "flex",
    flexDirection : "row",
    justifyContent : "space-evenly"
  },
  listContainer: {
    width: "100vw",
    height : "90%",
  },
  events : {
    display : "flex",
    flexDirection : "row",
    flexWrap : "wrap"
  }
}));







export default function Home() {
  const [category, setCategory] = useState(undefined)
  const classes = useStyles();
  // When new categories are created then we will need a new function that will make api calls to those specific endpoints. 

  useEffect(()=>{
    axios.get(`https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/events`)
      .then(res => {
        console.log(res.data)
        setCategory(res.data)
      }).catch(err => {
        console.log(err)
      });
  },[])
  return (

   
      <Container elevation={3} className={classes.container}>
          
          
          <div className={classes.toolbar} />
          <List className={classes.list}>
              {['Sports', 'Entartainment', 'Gaming', 'Movies'].map((text, index) => (
                  <Button onClick={() => {console.log(text)}} color= "primary">

                  <ListItemText primary={text}  />
                  
                  </Button>
              ))}
            </List>
            <Container className={classes.events}>
              {
                category ? category.map(c => {
                  return <EventCard event={c} />
                }): <p>no data</p>
              }
            </Container>
      </Container>
     
  );
}