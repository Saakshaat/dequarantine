import React from 'react';
import Box from '@material-ui/core/Box';
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
import AutoGrid from './grid';

const useStyles = makeStyles((theme) => ({
  root: {
    display: 'flex',
    flexDirection : "row",
    width: "100vw",
    height : "90vh",
  },
  container : {
      width : "auto",
      height : "100%",
      boxShadow : theme.shadows[7]
      
  },
  
  Divider: 
  {
    paddingTop: "10px"
  },
  Container1: {
   alignContent: 'center',
  },
  list : {
    display : "flex",
    flexDirection : "",
    justifyContent : "space-evenly"
  },
  list1 : {
   
    flexDirection : "flex-row",
    justifyContent : "space-evenly"
  },
  listContainer: {
    width: "100%",
    height : "90%",
    boxShadow : theme.shadows[4]
  }
}));








function calltoCheck(CategoryArguemenat) {
  
  var List_to = [];
  
  axios.get("http://www.omdbapi.com/?s=guardians+of+the+galaxy&apikey=thewdb" )
      .then(res => {
       
           res.data['Search'].forEach(element => {
           List_to.push(element);
           //alert(List_to.length);

         });
        
         return List_to;
      })
    
      

  

  
}

function check(args) {
    return args.length;
}



export default function Home() {
  
  var List_to = [ ];
  alert(List_to.length);
  const classes = useStyles();
  
  return (

      
      <div>
      
      <div className={classes.Jumbotron}>

       
      </div>
      <Container elevation={3} className={classes.container}>
          
          
          
          <List className={classes.list}>
              {['Sports', 'Entartainment', 'Gaming', 'Movies'].map( (text, index) => (
                  <Button varaint="outlined" onClick={() => { (List_to) = calltoCheck(text)}} color= "primary">
                   
                  <ListItemText primary={text}  />
                  
                  </Button>
              ))}
              
            </List>
          
            
      
      </Container>
      
      
      <Container className={classes.Container1}>
      <Box
        display="flex"
        flexWrap="wrap"
        justifyContent="center"
       >
              { 
                List_to.map( () => (
                <Paper elevation={3} >
                  <EventCard >
                  </EventCard>
                 </Paper>
              ))}
              
      </Box>
      </Container>

        
      
        
      
     
      
      
      
      </div>
      
      
  );
 
}