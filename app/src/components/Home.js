import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import {Paper, Container, Button }from '@material-ui/core';
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
  list : {
    display : "flex",
    flexDirection : "row",
    justifyContent : "space-evenly"
  },
  listContainer: {
    width: "100%",
    height : "90%",
    boxShadow : theme.shadows[4]
  }
}));

export default function Home() {
  const classes = useStyles();

  return (
      <Container elevation={3} className={classes.container}>
          <div className={classes.toolbar} />
            <Divider />
            <List className={classes.list}>
              {['Category #1', 'Category #2', 'Category #4', 'Category #5'].map((text, index) => (
                  <Button>
                  <ListItemIcon>{index % 2 === 0 ? <InboxIcon /> : <MailIcon />}</ListItemIcon>
                  <ListItemText primary={text} />
                  </Button>
              ))}
            </List>
            <Divider />
        <Container className={classes.listContainer}>
          <Attending />
        </Container>
      </Container>
  );
}