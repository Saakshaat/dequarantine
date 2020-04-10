import React, { Component } from 'react'
import Avatar from '@material-ui/core/Avatar';
import InputBase from '@material-ui/core/InputBase';
import Grid from '@material-ui/core/Grid';
import Divider from '@material-ui/core/Divider';
import {Paper, Container, Button }from '@material-ui/core';
import Attending from './Attending';
import { makeStyles } from '@material-ui/core/styles';


const useStyles = makeStyles((theme) => ({
  container: {
    margin: 'auto',
    width: '80%',
    display: 'flex',
    paddingTop: '3%',
    paddingBottom: '10px'
  },
  profileSection : {
    display: 'flex',
    flexDirection: 'column',
    width: '40%',
    padding: '3% 5%',
    alignItems: 'center',
    marginRight: '1%'
    
  },
  avatar: {
    height: '200px',
    width: '200px'
  },
  eventSection : {
    padding: '10px',
    width: 'inherit',
    marginLeft: '1%'
  },
  eventStatSection: {
    height: '190px',
    display: 'flex',
    padding: '50px'
  },
  gridColumnOrientation: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center'
  },
  gridRowOrientation: {
    flexWrap: 'inherit'
  },
  divider: {
    width: '6px',
    borderRadius:'3px'  
  }
}));

export default function Account() {
  
  const classes = useStyles();

  return (
    <div>

      <div className={classes.container}>

        <Paper className={classes.profileSection}>
          <Avatar className={classes.avatar} alt="Remy Sharp" src="/Users/jeelpb/Documents/Projects/dequarantine/app/src/logo.svg" />
          <InputBase
            //className={classes.margin}
            defaultValue="Name Here"
            inputProps={{ 'aria-label': 'naked' }}
          />
          <InputBase
            //className={classes.margin}
            defaultValue="Email Here"
            inputProps={{ 'aria-label': 'naked' }}
          />
        </Paper>

        <div className={classes.eventSection}>

          <div className={classes.eventStatSection}>
            <Grid className={classes.gridRowOrientation} container spacing={1} >

              <Grid className={classes.gridColumnOrientation} container item xs={12} spacing={3}>
                <React.Fragment>
                  <Grid item xs={4}>
                    <InputBase
                      //className={classes.margin}
                      defaultValue="6"
                      inputProps={{ 'aria-label': 'naked' }}
                    />
                  </Grid>
                  <Grid item xs={4}>
                    <InputBase
                      //className={classes.margin}
                      defaultValue="Past Events"
                      inputProps={{ 'aria-label': 'naked' }}
                    />
                  </Grid>
                </React.Fragment>
              </Grid>

              <Divider className={classes.divider} orientation="vertical" flexItem />

              <Grid className={classes.gridColumnOrientation} container item xs={12} spacing={3}>
                <React.Fragment>
                  <Grid item xs={4}>
                    <InputBase
                      //className={classes.margin}
                      defaultValue="8"
                      inputProps={{ 'aria-label': 'naked' }}
                    />
                  </Grid>
                  <Grid item xs={4}>
                    <InputBase
                      //className={classes.margin}
                      defaultValue="Upcoming Events"
                      inputProps={{ 'aria-label': 'naked' }}
                    />
                  </Grid>
                </React.Fragment>
              </Grid>

            </Grid>
          </div>

          <Container>
            <Attending />
          </Container>

        </div>

      </div>

    </div>
  )
}

