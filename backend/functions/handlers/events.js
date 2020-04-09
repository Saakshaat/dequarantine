const { db } = require("../util/admin");
const gcal = require("../util/googlecal.js");


exports.getAllEvents = (req, res) => {
  db.collection("events")
    .get()
    .then(doc => {
      let events = [];
      doc.forEach(data => {
        events.push({
          eventId: data.id,
          imageUrl: data.data().imageUrl,
          name: data.data().name,
          organizer: data.data().organizer,
          startTime: data.data().startTime,
          endTime: data.data().endTime,
          cap: data.data().cap,
          link: data.data().link,
          attending: data.data().attending,
          category: data.data().category,
          description: data.data().description,
          participants: data.data().participants
        });
      });
      return res.json(events);
    })
    .catch(err => console.error(err));
};

//Getting one event when the event ID is given
exports.getOneEvent = (req, res) => {
  db.doc(`/events/${req.params.eventId}`)
    .get()
    .then(doc => {
      if (!doc.exists) {
        return res.status(404).json({ error: `Event not found` });
      }
      eventData = doc.data();
      eventData.screamId = doc.id;
      return res.json(eventData);
    })
    .catch(err => {
      res.status(500).json({ error: err });
    });
};

exports.postEvents = (req, res) => {
  participants = [];
  let organizer = req.user.userName;
  const newEvent = {
    name: req.body.name,
    cap: req.body.cap,
    category: req.body.category,
    description: req.body.description,
    startTime: req.body.startTime,
    endTime: req.body.endTime,
    link: req.body.link,
    imageUrl: req.body.imageUrl,
    attending: 0,
    participants,
    organizer: organizer ? organizer : "someone"
  };
  db.collection("events")
    .add(newEvent)
    .then(doc => {
      const resEvent = newEvent;
      resEvent.eventId = doc.id;
      res.json(resEvent);
    })
    .catch(err => {
      console.error(err);
      return res.status(500).json({ error: `something went wrong` });
    });
};

exports.deleteEvents = (req, res) => {
  const document = db.doc(`/events/${req.params.eventId}`);
  document
    .get()
    .then(doc => {
      if (!doc.exists) {
        return res.status(404).json({ error: `cannot find the event` });
      }
      if (doc.data().organizer !== req.user.userName) {
        return res.status(403).json({ error: `Unauthorized` });
      } else {
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

exports.markAttended = (req, res) => {
  let batch = db.batch();
  let eventDoc = db.doc(`/events/${req.params.eventId}`);
  let userDoc = db.doc(`/users/${req.user.userName}`);
  let attending = [];
  let attendCount = 0;
  let participants = [];

  eventDoc
    .get()
    .then(doc => {
      if (doc.empty) {
        return res.status(404).json({ general: `Event does not exist` });
      } else {
        if (doc.data().attending === doc.data().cap) {
          return res
            .status(409)
            .json({ general: `Event Full. It has a cap of ${eventDoc.cap}` });
        }

        //GOOGLE CALENDAR INTEGRATION
        let url;
        if (req.headers.refreshtoken) {
          gcal
            .addToCalendar(doc.data(), {
              client_secret: req.headers.clientsecret,
              client_id: req.headers.clientid,
              redirect_uri: req.headers.redirecturi,
              refresh_token: req.headers.refreshtoken
            })
            .catch(err =>
              console.log("ERROR ADDING EVENT TO USER'S GOOGLE CALENDAR\n", err)
            );
        } else {
          url = gcal.authorize({
            client_secret: req.headers.clientsecret,
            client_id: req.headers.clientid,
            redirect_uri: req.headers.redirecturi
          });
          console.log("URL", url);
        }
        //END GOOGLE CAL INTEGRATION

        eventUpdated = true;
        let orgParticipants = doc.data().participants;
        orgParticipants.push(req.user.userName);
        participants = orgParticipants;
        attendCount = doc.data().attending + 1;
        return userDoc
          .get()
          .then(doc => {
            if (doc.data().attending.includes(req.params.eventId)) {
              return res
                .status(409)
                .json({
                  general: `Already attending this event`,
                  ...(url && { url })
                });
            }

            let orgAttending = doc.data().attending;
            orgAttending.push(req.params.eventId);
            attending = orgAttending;

            batch.update(userDoc, { attending: attending });
            batch.update(eventDoc, { participants: participants });
            batch.update(eventDoc, { attending: attendCount });

            return batch
              .commit()
              .then(() => {
                return res.status(200).json({ url: url });
              })
              .catch(err => {
                return res.status(500).json({ error: err });
              });
          })
          .catch(err => {
            return res
              .status(500)
              .json({ error: `Error getting User. ${err}` });
          });
      }
    })
    .catch(err => {
      return res.status(500).json({ error: `Error getting Event: ${err}` });
    });
};

exports.unmarkAttended = (req, res) => {
  let batch = db.batch();
  let eventDoc = db.doc(`/events/${req.params.eventId}`);
  let userDoc = db.doc(`/users/${req.user.userName}`);
  let attending = [];
  let attendCount = 0;
  let participants = [];

  eventDoc
    .get()
    .then(doc => {
      if (doc.empty) {
        return res.status(404).json({ general: `Event does not exist` });
      } else {
        if (doc.data().attending === 0) {
          return res.status(409).json({ general: `Can't unattend. Sorry` });
        }
        eventUpdated = true;
        let orgParticipants = doc.data().participants;
        let index = orgParticipants.indexOf(req.user.userName);
        if (index < 0) {
          return res.status(409).json({ general: `Not attending this event ` });
        }

        orgParticipants.splice(index, 1);
        participants = orgParticipants;
        attendCount = doc.data().attending - 1;
        return userDoc
          .get()
          .then(doc => {
            if (!doc.data().attending.includes(req.params.eventId)) {
              return res
                .status(409)
                .json({ general: `Not attending this event` });
            }

            let orgAttending = doc.data().attending;
            let index = orgAttending.indexOf(req.params.eventId);
            orgAttending.splice(index, 1);
            attending = orgAttending;

            batch.update(userDoc, { attending: attending });
            batch.update(eventDoc, { participants: participants });
            batch.update(eventDoc, { attending: attendCount });

            return batch
              .commit()
              .then(() => {
                return res.status(200);
              })
              .catch(err => {
                return res.status(500).json({ error: err });
              });
          })
          .catch(err => {
            return res
              .status(500)
              .json({ error: `Error getting User. ${err}` });
          });
      }
    })
    .catch(err => {
      return res.status(500).json({ error: `Error getting Event: ${err}` });
    });
};

//Getting the names of all participants
exports.getParticipants = (req, res) => {
  db.doc(`/events/${req.params.eventId}`)
    .get()
    .then(doc => {
      if (doc.exists) {
        let users = [];
        doc.get("participants").forEach(data => {
          users.push(data);
        });
        return res.json(users);
      } else {
        return res.status(400).json({ error: `Event does not exist` });
      }
    })
    .catch(err => {
      return res.status(500).json({ error: `${err}` });
    });
};

//Getting all the events from a certain category
exports.getCategoryEvents = (req, res) => {
  db.collection("events")
    .where("category", "==", req.params.categoryName)
    .get()
    .then(doc => {
      if (!doc.empty) {
        let events = [];
        doc.forEach(data => {
          events.push({
            eventId: data.id,
            imageUrl: data.data().imageUrl,
            name: data.data().name,
            organizer: data.data().organizer,
            startTime: data.data().startTime,
            endTime: data.data().endTime,
            cap: data.data().cap,
            link: data.data().link,
            attending: data.data().attending,
            category: data.data().category,
            description: data.data().description,
            participants: data.data().participants
          });
        });
        return res.json(events);
      } else {
        return res.status(404).json({ general: `No Events Found` });
      }
    })
    .catch(err => console.error(err));
};
