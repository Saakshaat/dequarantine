const { db } = require('../util/admin');

exports.getAllEvents = (req,res)=>{
  db
  .collection('events')
  .get()
  .then(data=>{
      let events=[];
      data.forEach(doc=>{
          events.push({
              eventId: doc.id,
              imageUrl: doc.data().imageUrl,
              name: doc.data().name,
              organizer: doc.data().organizer,
              time: doc.data().time,
              cap: doc.data().cap,
              attending: doc.data().attending,
              category: doc.data().category,
              description: doc.data().description, 
              participants: doc.data().part
       });
      });
      return res.json(events);
    })
    .catch(err=> console.error(err))
} 

exports.postEvents = (req, res) => {
  const newEvent = {
      name: req.body.name,
      cap:req.body.cap,
      attending: 0,
      category: req.body.category,
      organizer: req.body.organizer,
      description: req.body.description,
      time: new Date().toISOString(),
      imageUrl:req.body.imageUrl,
      participants: []
  };

  db
    .collection('events')
    .add(newEvent)
    .then(doc => {
        const resEvent = newEvent;
        resEvent.eventId = doc.id;
        res.json(resEvent);
    })
    .catch(err => {
        res.status(500).json({error: `something went wrong`});
        console.error(err);
    });
}

exports.deleteEvents= (req, res) => {
   const document = db.doc(`/events/${req.params.eventId}`);
    document
      .get()
      .then(doc => {
          if(!doc.exists){
            return res.status(404).json({ error: `cannot find the event` });            
          }
          if((doc.data().organizer !== req.user.userName)){
            return res.status(403).json({ error: `Unauthorized` });
          } else{
            return document.delete();
          }
      })
      .then(() => {
          res.json({ message: `event deleted successfully` });
      })
      .catch(err => {
          console.error(err);
          return res.status(500).json(err);
      });
};

exports.markAttending = (req, res) => {
  const user = db
        .collection('users')
        .where('userName', '==', req.user.userName)
        .where('eventId', '==', req.params.eventId)
        .limit(1);

    const eventDocument = db.doc(`/events/${req.params.eventId}`);

    let eventData;

    eventDocument
      .get()
      .then((doc) => {
        if (doc.exists) {
          eventData = doc.data();
          eventData.eventId = doc.id;
          return user.get();
        } else {
          return res.status(404).json({ error: 'Event not found' });
        }
      })
      .then((data) => {
        if (data.empty) {
              user.participants.push(eventData.eventId);
              eventData.participants.push(userName);
              eventData.attending++;
              return eventDocument.update({ attending: eventData.attending });
        } else {
          return res.status(400).json({ error: 'Event already attending' });
        }
      })
      .catch((err) => {
        console.error(err);
        res.status(500).json({ error: err.code });
      });
}

exports.unmarkAttending = (req, res) => {
  const attendingDocument = db
    .collection('attending')
    .where('userName', '==', req.user.userName)
    .where('eventId', '==', req.params.eventId)
    .limit(1);
    
  const eventDocument = db.doc(`/events/${req.params.eventId}`);

  let eventData;

  eventDocument
    .get()
    .then((doc) => {
      if (doc.exists) {
        eventData = doc.data();
        eventData.eventId = doc.id;
        return attendingDocument.get();
      } else {
        return res.status(404).json({ error: 'Event not found' });
      }
    })
    .then((data) => {
      if (data.empty) {
        return res.status(400).json({ error: 'Event not attending' });
      } else {
        return db
          .doc(`/attending/${data.docs[0].id}`)
          .delete()
          .then(() => {
            eventData.attending--;
            return eventDocument.update({ attending: eventData.attending });
          })
          .then(() => {
            return res.json(eventData);
          });
      }
    })
    .catch((err) => {
      console.error(err);
      res.status(500).json({ error: err.code });
    });
};
