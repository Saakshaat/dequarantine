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

exports.authGoogleCal = (req, res) => { //OAuth Redirect Uri leads here.
    console.debug('REQ QUERY', req.query);

    const state = JSON.parse(req.query.state);
    console.debug('STATE USERID', state.userId);
    let userDoc = db.doc(`/users/${ state.userId }`);
    
    //userDoc.
    gcal.authorize(req.headers, state, req.query.code )
    .then(result => {
        const { oauth2client } = result;
        eventDoc = db.doc(`/events/${state.eventId}`)
        .get()
        .then(doc => {
            gcal.addToCalendar( doc.data(), oauth2client )
            .then(result => {
                return res.send("You can close this page now.");
            })
            .catch(err => res.status(400).send(`ERROR: ${ err }`));
        })
        .catch(err => {
            console.error('ERROR\n--------------------------------\n', err);
            return res.send('ERROR');
        });
    })
    .catch(err => {
        console.error('ERROR\n--------------------------------\n', err);
        return res.send('ERROR');
    });
};

exports.markAttended = (req, res) => {
//  let eventDoc = db.doc(`/events/${req.params.eventId}`);
//  let userDoc= db.doc(`/users/${req.user.userName}`);

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

        eventUpdated = true;
        let orgParticipants = doc.data().participants;
        orgParticipants.push(req.user.userName);
        participants = orgParticipants;
        attendCount = doc.data().attending + 1;

        const eventData = doc.data();

        return userDoc
          .get()
          .then(doc => {
            //GOOGLE CALENDAR INTEGRATION
            let url;
            if( doc.data().gcalAccessToken || doc.data().gcalRefreshToken ) {
                gcal.authorize(req.headers, { userId: req.user.userName} , null, {refresh_token: doc.data().gcalRefreshToken, access_token: doc.data().gcalRefreshToken} )
                .then(result => {
                    const { oauth2client } = result;

                    return gcal.addToCalendar( eventData, oauth2client )
                    .catch(err => { throw err } );
                })
                .catch(err => {
                    console.error('ERROR: Google Calendar Action.\n--------------------------------\n', err);
                });
            } else {
              url = gcal.authorize( req.headers, {userId: req.user.userName,  eventId: req.params.eventId }, null );
            }
            //if(gcalAuthResponse !== undefined && gcalAuthResponse !== ) url = gcalAuthResponse.url;
            //END GOOGLE CAL INTEGRATION

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
            console.debug(err);
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
