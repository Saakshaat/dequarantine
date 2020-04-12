const { db } = require("../util/admin");
const { google } = require("googleapis");
const OAuth2 = google.auth.OAuth2;
const functions = require('firebase-functions');

//Function authorize will return the Google OAuth2Client that will be used by the addToCalendar function.

exports.authorize = ( headers, payload = null, authcode = null, tokens = null ) => {
      let redirecturi;
      if(headers.host == 'localhost:5001')
          redirecturi = 'http://localhost:5001/dequarantine-aae5f/us-central1/baseapi/googlecal/oauth';
      else redirecturi = 'https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/googlecal/oauth';
      
    console.debug('HEADERS', headers);
    
    
    //Check if User doc has Google Calendar auth and refresh tokens
    if(tokens) {
        const { userId } = payload;
        const { clientsecret, clientid  } = headers;

        const OAuth2Client = new google.auth.OAuth2(
            clientid, clientsecret, redirecturi
         );
        console.debug('TOKEN OBJ', tokens);
        const {refresh_token, access_token} = tokens;

        OAuth2Client.setCredentials({ refresh_token, access_token });

        let userDoc = db.doc(`/users/${ userId }`);
        return userDoc.update({
            gcalRefreshToken: refresh_token, 
            gcalAccessToken: access_token
        })
        .then(res => {
            return { oauth2client: OAuth2Client }
        });

    } else if(authcode) { //Check if auth code has been sent from Google Permission Screen. This happens when authGoogleCalendar from events.js is called. 
        const {userId, eventId} = payload;

        const { clientsecret, clientid  } = payload;
        const OAuth2Client = new google.auth.OAuth2(
            clientid, clientsecret,
            redirecturi
        );

        return OAuth2Client.getToken(authcode)
        .then(result => {
            const { tokens } = result;
            const { access_token, refresh_token } = tokens;
            OAuth2Client.setCredentials({ refresh_token, access_token });

            let userDoc = db.doc(`/users/${ userId }`);
            return userDoc.update({
                gcalRefreshToken: refresh_token, 
                gcalAccessToken: access_token
            })
            .then(res => {
                return { oauth2client: OAuth2Client }
            });
            //OAuth2.setCredentials(tokens);
        })
        .catch(err => { 
            console.error('ERR', err);
            throw "Error";
        });
    } else { //We don't have the RefreshToken or AccessToken for the user's Google Calendar
      const {userId, eventId} = payload;

      const { clientsecret, clientid  } = headers;

      const OAuth2Client = new google.auth.OAuth2(
        clientid,
        clientsecret,
        redirecturi
      );

      const SCOPES = ["https://www.googleapis.com/auth/calendar.events"];
      const state = JSON.stringify({
          userId: userId, eventId: eventId,
          clientid: clientid, clientsecret: clientsecret
      });
      console.debug('STATE', state);

      let url = OAuth2Client.generateAuthUrl({
        access_type: "offline",
        scope: SCOPES,
        state
      });
      return url;
    }
};


exports.addToCalendar = (eventData, OAuth2Client) => {
  const calendar = google.calendar({ version: "v3", auth: OAuth2Client });
  return calendar.events
    .insert({
      OAuth2Client,
      calendarId: "primary",
      resource: {
        summary: eventData.name,
        description: eventData.description,
        start: {
          dateTime: eventData.startTime
        },
        end: {
          dateTime: eventData.endTime
        }
      }
    })
    .then(result => {
      console.debug("RESULT", result);
      return "Successful";
    })
    .catch(err => {
      console.error('ERROR Function addToCalendar: \n-----------------------------------------------------\n',err);
      if(err.errors) {
        switch(err.errors[0].reason) {
            case 'timeRangeEmpty':
                throw "The event start time is later than its end time. Please contact the creator of the event.";
            default: 
                throw "General Error";
        }
      }
      else throw err; // new Error("Error adding event to user's calendar");
    });
};
