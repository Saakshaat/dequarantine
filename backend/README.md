# Firebase Functions

All routes are established in [index.js](https://github.com/Saakshaat/dequarantine/blob/saakshaat-login-signup/backend/functions/index.js).

All user and event functions are written in seperate files and interfaced through a baseapi that is hosted on our Firebase instance.

CORS middleware has also been imported in [index.js](https://github.com/Saakshaat/dequarantine/blob/saakshaat-login-signup/backend/functions/index.js).

User authentication is done through [FBAuth](https://github.com/Saakshaat/dequarantine/blob/saakshaat-login-signup/backend/functions/util/FBAuth.js). This is used to verify a passed token and allow the user to perform functions while they are signed in.

#### Directories
- [handlers](#handlers)
- [utils](#utils)

## Handlers

This directory maintains the [user](https://github.com/Saakshaat/dequarantine/blob/saakshaat-login-signup/backend/functions/handlers/users.js) and [events](https://github.com/Saakshaat/dequarantine/blob/saakshaat-login-signup/backend/functions/handlers/events.js) operations.


### Users
 
This file has the firebase methods for:
-   Signin using email
-   Login using existing account
-   Signin using Google Account
-   Resetting Forgotten Password through a reset link

Except for the Google sign-in all the other methods use [validators](https://github.com/Saakshaat/dequarantine/blob/saakshaat-login-signup/backend/functions/util/validators.js) for verifying the user input.

Upon signin or login, a token is generated and stored in the browser's local storage to keep the user signed in.

#### User Routes

-   Signup: /signup
-   Login: /login
-   Forgot Password: /user/password
-   Google Sign In: /g/signin

### Events


## Utils
This directory maintains all the utility functions and configuration files, used by the rest of the API functions. 

### Admin

[This](https://github.com/Saakshaat/dequarantine/blob/saakshaat-login-signup/backend/functions/util/admin.js) initializes the Firebase application and interfaces access with the Firestore Database.

### Validators

This file has all the functions that are used to validate input data against some conditions. This helps throw exceptions.


### FBAuth

This file facilitates user authentication. 

When the user signs up or logs in, Firebase returns a token which is stored in the browser's local storage. Whenever the user makes a request which requires user authentication, FBAuth is included as a request parameter and the token is sent as a request header.

The token is sent through the header in the request in the following format:

Bearer <token>

Whenever a function needs to facilitate user authentication, the request parameter only need to include FBAuth. 

For example <app.post("/user", FBAuth, addUserDetails);>