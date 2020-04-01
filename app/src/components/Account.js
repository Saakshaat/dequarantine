import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import { Paper, Typography, Container } from '@material-ui/core';


const useStyles = makeStyles((theme) => ({
  root: {
    display: 'flex',
    width: "90vw",
    height : "90vh",
    '& > *': {
      margin: theme.spacing(1),
      width: theme.spacing(16),
      height: theme.spacing(16),
    },
  },
  paper : {
    width : "90vw",
    height : "80vh",
    display : "flex",
    flexDirection : "row",
    justifyContent : "space-evenly",
    alignItems : "center"
  },
  personDetails : {
    height : "90%",
    minWidth : "300px",
  },
  container : {
    width : "80%",
    background : theme.palette.primary.main
  },
  paper2 : {
    width : "1000px",
    height : "!00%"
  }
}));

export default function Variants() {
  const classes = useStyles();

  return (
    <div className={classes.root}>
      <Paper elevation={7} className={classes.paper}>
        <Paper className={classes.personDetails}>
          <Typography variant="h2">
            HELLO
          </Typography>
        </Paper>
        <Paper>
          <Container className={classes.container}>
          </Container>
        </Paper>
      </Paper>
    </div>
  );
}