import React, { useContext } from 'react'
import Button from '@material-ui/core/Button';
import '../style/EventCard.scss'
import { Paper, Container, Typography, makeStyles } from '@material-ui/core';
import Axios from 'axios';
import { AuthContext } from './Auth/Auth'

const useStyles = makeStyles(theme=>({
  event : {
    backgroundColor: "white",
    borderRadius : "10px",
    margin: "10px",
    padding: "10px",
    width : "240px",
    [theme.breakpoints.up('md')] : {
      width : "30%"
    }
  },
  container : {
    [theme.breakpoints.up('md')]: {
      width : "300px"
    },
    margin: "auto",
    display : "flex",
    flexDirection : "row",
    justifyContent : "space-between"
  },
  media : {
    textAlign: "center",
    width : "100px",
    height : "100px"
  },
  img : {
    width : "100px",
    height : "100px"
  },
  button : {
    fontWeight: "bold",
    margin : "5px",
        "&:hover" : {
          backgroundColor: "yellow",
        },
        width : "75%",
  },
  attendingDetails : {
    display : "flex",
    flexDirection : "row",
    width : "90%",
    justifyContent : "space-between"
  },
  action : {
    width : "50%"
  }

}))
function EventCard(props) {
  const classes = useStyles()
  const { currentUser } = useContext(AuthContext)
  const joinEvent = (e) =>{
    e.preventDefault();
    const options = {
      header : {
        Authorization : `Bearer ${localStorage.getItem('user')}`
      }
    }
    console.log( currentUser )
    // Axios.post(`https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/events/markAttended/${props.event.eventId}`,)
  }
  return (
    <Paper className={classes.event} key={props.event.eventId}>
      <Container className={classes.container}>
        <div>
          <div className={classes.media}>
            <img className={classes.img} src={props.event.imageUrl}/>
            </div>
          <div className='content'>
            <div className='title'>{props.event.name}</div>
          </div>
        </div>
        <div className={classes.action}>
          <Button variant="outlined" className={classes.button} color="primary" onClick={ joinEvent }>Join</Button>
          <Button variant="outlined" className={classes.button} color="primary">Details</Button>
        </div>
      </Container>
    </Paper>
  )
}

export default EventCard
