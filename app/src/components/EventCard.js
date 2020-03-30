import React from 'react'
import Button from '@material-ui/core/Button';
import '../style/EventCard.scss'

function EventCard(props) {
  return (
    <div className='event'>
      <div className='container'>
        <div className='media'><img src={props.event.img}/></div>
        <div className='content'>
          <div className='title'>{props.event.title}</div>
          <p className='description'>{props.event.description}</p>
        </div>
        <div className='action'>
          <Button variant="outlined" color="secondary">Decline</Button>
          <Button variant="outlined" color="primary">Join</Button>
        </div>
      </div>
    </div>
  )
}

export default EventCard
