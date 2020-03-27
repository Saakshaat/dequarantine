const isEmpty = (string) => {
    if(string === undefined || string.trim() === ``) return true;
    else return false;
}

const isEmail = (email) => {
    const regEx = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return email.match(regEx);
}

exports.validateSignUpData = (data) => {
    let errors = {};

    if(isEmpty(data.email)) errors.email = 'Must not be empty';
    else if(!isEmail(data.email)) errors.email = 'Must be valid';

    if(isEmpty(data.password)) errors.password = 'Must not be empty';
    // if(!isPassword(data.password)) errors.password = 'Password must be 8 characters long and must contain atleast one number'
    if(data.password !== data.confirmPassword) errors.confirmPassword = 'Passwords must match';
    if(isEmpty(data.userName)) errors.userName = 'Must not be empty';

    return {
        errors,
        valid: Object.keys(errors).length === 0 ? true : false
    }
}

exports.validateLoginData = (data) => {
    let errors = {};
    
    if(isEmpty(data.email)) errors.email = 'Must not be empty';
    if(!isEmail(data.email)) errors.email = 'Must be valid';
    if(isEmpty(data.password)) errors.password = 'Must not be empty';

    return {
        errors,
        valid: Object.keys(errors).length === 0 ? true : false
    }
}

exports.reduceUserDetails = (data) => {
    let userDetails = {};
    
    if(!isEmpty(data.bio.trim())) userDetails.bio = data.bio;
    if(!isEmpty(data.location.trim())) userDetails.location = data.location;  
    
    return userDetails;
};