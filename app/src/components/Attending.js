import React from 'react'
import { Paper } from '@material-ui/core'
import EventCard from './Card/Card'
import { makeStyles } from '@material-ui/core'

const useStyles = makeStyles(theme=>({
  paper : {
    display : "flex",
    flexDirection : "row",
    flexWrap: "grow",
    justifyContent : "space-evenly",
    width : "100%",
    height : "100%",
    marginTop : "10px",
    backgroundColor : "whitesmoke",
    padding : "30px",
    marginLeft : "15px"
  }
}))
const Attending = () => {
  const classes = useStyles()
  return (
    <Paper elevation={0} className={classes.paper}>
      {
        [1,3,4].map((p)=>{
          return (
            <EventCard />
          )
        })
      }
    </Paper>
  )
}

export default Attending