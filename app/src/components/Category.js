import React, { Component } from 'react'
import Button from '@material-ui/core/Button';
import EventCard from './EventCard'
import '../style/Category.scss'

class Category extends Component {
  constructor () {
    super()
    this.state = {
      filters: ['Entertainment', 'Education', 'Music', 'Sport', 'Movie'],
      events: []
    }
  }

  componentDidMount() {
    const event = {
      img: 'https://i.picsum.photos/id/334/300/300.jpg', 
      title: 'Play Guitar Online', 
      description: 'join the online zoom join the online zoom join the online zoomjoin the online zoom join the online zoomjoin the online zoomjoin the online zoomjoin the online zoomjoin the online zoomjoin the online zoom'
    }
    var events = []
    for (let i = 0; i < 20; i++) {
      events.push(event)
    }
    this.setState({events: events})
  }

  render () {
    return (
      <div className='category'>
        <div className='filter'>
          {this.state.filters.map(filter => {
            return <Button className='filter-btn' variant="contained">{filter}</Button>
          })}
        </div>
        <div className='event-list'>
          {this.state.events.map(event => {
            return <EventCard event={event}/>
          })}
        </div>
      </div>
    )
  }
}

export default Category
