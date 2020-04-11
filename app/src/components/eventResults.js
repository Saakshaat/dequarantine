import React, {Component} from 'react';
import PropTypes from 'prop-types';
import GridList from '@material-ui/core/GridList';
import GridListTile from '@material-ui/core/GridListTile';
import EventCard from './Card/Card';


class eventResults extends Component {
    render() {
        let eventlist;
        
        const {events} = this.props;
       // console.log("this is the events");
        //console.alert("hi");
        //console.log(this.events);
        if (events) {
            eventlist = (
                <GridList cols = '3'>
                    {events.map( (text,index)  => (
                  <EventCard  title={this.state.EventsList[index]['Title']} description={this.state.EventsList[index]['Type']}   img={this.state.EventsList[index]['Poster']} >
                  
                  </EventCard>

              ))}
                    
                </GridList>
            )
            console.log("reached");
        } else  {
            eventlist = null;
            console.log("reached");
        }
        return(<div>
            {eventlist}
           </div>
        )
    }
}

eventResults.propTypes = {
  events : PropTypes.element.isRequired,
};



export default eventResults;