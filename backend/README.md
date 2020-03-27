# Firebase Functions

All routes are established in [index.js](https://github.com/Saakshaat/dequarantine/saakshaat-login-signup/backend/functions/index.js).

All user and event functions are written in seperate files and interfaced through a baseapi that is hosted on our Firebase instance.

CORS middleware has also been imported in [index.js](https://github.com/Saakshaat/dequarantine/saakshaat-login-signup/backend/functions/index.js).

User authentication is done through [FBAuth](https://github.com/Saakshaat/dequarantine/saakshaat-login-signup/backend/functions/util/FBAuth.js). This is used to verify a passed token and allow the user to perform functions while they are signed in.

#### Directories
- [handlers](#handlers)
- [utils](#utils)

### Handlers

This directory maintains the [user](https://github.com/Saakshaat/dequarantine/saakshaat-login-signup/backend/functions/handlers/users.js) and [events](https://github.com/Saakshaat/dequarantine/saakshaat-login-signup/backend/functions/handlers/users.js) operations.

#### Users
 
This file has the firebase methods for:
-   Signin using email
-   Login using existing account
-   Signin using Google Account
-   Resetting Forgotten Password through a reset link

Except for the Google sign-in all the other methods use [validators](https://github.com/Saakshaat/dequarantine/saakshaat-login-signup/backend/functions/util/validators.js) for verifying the user input.

Upon signin or login, a token is generated and stored in the browser's local storage to keep the user signed in.

#### Events


### Utils
This directory maintains all the utility functions and configuration files, used by the rest of the API functions. 

#### Admin

[This](https://github.com/Saakshaat/dequarantine/saakshaat-login-signup/backend/functions/util/admin.js) initializes the Firebase application and interfaces access with the Firestore Database.

#### Validators

This file has all the functions that are used to validate input data against some conditions. This helps throw exceptions.
