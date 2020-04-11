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
class Attending extends React.Component  {
  
  constructor(props) {
    super(props);
      this.state = {
        EventsList: [],
        Upcoming:[],
        Attended:[]
    
        
      }
    
    }
  
  render(){
    return(

      <div>
          

      
      
      
      
      
      
      
      
      </div>
    )
  };
}

export default Attending