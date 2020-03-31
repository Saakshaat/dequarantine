const { db } = require('../util/admin');

exports.getAllEvents = (req,res)=>{
  db
  .collection('events')
  .get()
  .then(data => {
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
  participants = [];
  const newEvent = {
      name: req.body.name,
      cap:req.body.cap,
      category:req.body.category,
      organizer: req.body.organizer,
      description:req.body.description,
      time:new Date().toISOString(),
      imageUrl:req.body.imageUrl,
      attending: 0,
      participants
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
          } 
          else{
            return document.delete();
          }
      })
      .then(() => {
          res.json({ message: `Event deleted successfully` });
      })
      .catch(err => {
          console.error(err);
          return res.status(500).json(err);
      });
};

exports.markAttended=(req,res)=>{
  const user = db.doc(`/users/${req.user.userName}`);
  const eventDocument= db.doc(`/events/${req.params.eventId}`);
  let userData
  let eventData;
 eventDocument
      .get()
      .then((doc) => {
        if (doc.exists) {
          eventData = doc.data();
          eventData.eventId = doc.id;
          eventData.participants.indexOf(req.user.userName) === -1 ? eventData.participants.push(req.user.userName) : 
          console.log("You are already attending");
              eventData.attending++;
             return (eventDocument.update({ participants: eventData.participants },{attending:eventData.attending}))
                   } else {
          return res.status(404).json({ error: 'Event not found' });
        }
      })
      user
           .get()
           .then((doc)=>{
             if(doc.exists){
            userData=doc.data();
            console.log(userData.attending)
            userData.attending.push(eventData.eventId);
            userData.attending.indexOf(eventData.eventId) === -1 ? userData.attending.push(eventData.eventId) : 
            console.log("You are  already attending");
            return(user.update({attending:userData.attending}))
           
           }})
    
      .catch((err) => {
        console.error(err);
        res.status(500).json({ error: err.code });
      });
} 