import React from 'react'
import { Paper } from '@material-ui/core'
import Card from './Card/Attending'
import { makeStyles } from '@material-ui/core'

const useStyles = makeStyles(theme=>({
  paper : {
    display : "flex",
    flexDirection : "row",
    justifyContent : "space-evenly",
    width : "90vw",
    height : "80vh",
    marginTop : "10px",
    backgroundColor : "whitesmoke",
    padding : "30px",
    marginLeft : "15px"
  }
}))
const Attending = () => {
  const classes = useStyles()
  return (
    <Paper elevation={8} className={classes.paper}>
      {
        [1,3,4].map((p)=>{
          return (
            <Card />
          )
        })
      }
    </Paper>
  )
}

export default Attending
