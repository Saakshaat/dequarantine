import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import {Paper, Container, Button, Grid }from '@material-ui/core';
import PropTypes from 'prop-types';
import AppBar from '@material-ui/core/AppBar';
import CssBaseline from '@material-ui/core/CssBaseline';
import Divider from '@material-ui/core/Divider';
import Drawer from '@material-ui/core/Drawer';
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
  }
}));




var ListItem = {};



function calltoCheck(CategoryArguemenat) {
  //alert("Buttton clicked");
  
  
  axios.get("gs://dequarantine-aae5f.appspot.com`/events/category/".concat(CategoryArguemenat) )
      .then(res => {
        alert(res.data);
        List_to = res.data;
      })
      alert(CategoryArguemenat);
      ListItem = List_to;
      return List_to;

  
}




export default function Home() {
  const classes = useStyles();
  var List_to;
  return (
<<<<<<< HEAD
    <div>
      <Attending />
    </div>

=======

   
      <Container elevation={3} className={classes.container}>
          
          
          <div className={classes.toolbar} />
          <List className={classes.list}>
              {['Sports', 'Entartainment', 'Gaming', 'Movies'].map((text, index) => (
                  <Button onClick={() => {ListItem =calltoCheck(text)}} color= "primary">

                  <ListItemText primary={text}  />
                  
                  </Button>
              ))}
              
            </List>
          
            <Grid
              container
              direction="row"
              justify="center"
              alignItems="center"
                >

              <List className={classes.list}>
              {ListItem.map((  ) => (
                  <EventCard>
                    

                 </EventCard>
              ))}
              
            </List>


          </Grid>
         
      
      </Container>
     
>>>>>>> 8efd8b22bacddec918b3069227e43bc6a1ce99a3
  );
}