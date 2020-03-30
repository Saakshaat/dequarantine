# dequarantine - mobile

Mobile app of the dequaratine project  

## How the app works

### Log in :

- Login screen shows up 
- User has a choice of email, google, not signing in 
- Log in stuff happens, receives token from API 
- App requests user data, stores it in User object,


### Discover screen:

- code requests all events through API using equivalent to promise 
- once received all evnts are displayed in a list (planning on a grid view - had some issues getting that working) 
- Users can tap on events or dismiss left/right, if tapped a bottom sheet shows up with more info


### Account screen:

- Asks the user to log in if not already done so
- Displays temporary data (work in progress)

### Create event screen:

- Fields required dislpayed
- sends to API when "make it live!" is pressed

### Liked/Saved events screen:

- Haven't started :)


#### For non flutter devs, the app code is in the lib/ folder
