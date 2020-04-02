import React, { Component } from 'react';
import { withRouter } from 'react-router-dom'
import StyledFirebaseAuth from 'react-firebaseui/StyledFirebaseAuth';
import firebase from 'firebase';
import '../App.scss';
import axios from 'axios';

const initialState = {
    email: '',
    password: '',
    emailError: '',
    passwordError: '',
    messageError: '',
}

const config = {
    apiKey: 'AIzaSyBd1r9PD9IRGs7-gdWoig-vjsvIZ2zpU5E',
    authDomain: 'dequarantine-aae5f.firebaseapp.com',
}


firebase.initializeApp(config)

class Login extends Component {
    state = initialState

    // componentDidMount(){
    //     firebase.auth().onAuthStateChanged(user=>{

    //     })
    // }

    googlePopUp = () =>{
        const provider = new firebase.auth.GoogleAuthProvider();
        firebase.auth().signInWithPopup(provider).then(function(result) {
            // This gives you a Google Access Token. You can use it to access the Google API.
            console.log(result)
            console.log(result.user, result.user.displayName, result.user.email)
            const token = result.credential.accessToken;
            axios.post("https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/g/signin",{"access_token" :token}).then(res=>{
                console.log(res)
            }).catch(err=>{
                console.log(err)
            })

            // ...
          }).catch(function(error) {
            // Handle Errors here.
            var errorCode = error.code;
            var errorMessage = error.message;
            // The email of the user's account used.
            var email = error.email;
            // The firebase.auth.AuthCredential type that was used.
            var credential = error.credential;
            // ...
          });
    }
    formValidation = () => {
        const { email, password } = this.state
        let emailError = ''
        let passwordError = ''

        if (email === '') {
            emailError = `Please input your Email`
        } else if (email !== '' && !email.includes('@')) {
            emailError = `Email must includes '@'`
        }

        if (password === '') {
            passwordError = `Please input your Password`
        }

        if (emailError || passwordError) {
          this.setState({ emailError, passwordError })
          return false
        }
        return true
    }

    clearForm = () => {
        this.setState(initialState)
    }

    handleOnChange = e => {
        this.setState({ [e.target.name]: e.target.value})
    }

    handleOnSubmit = e => {
        e.preventDefault()
        const formValidation = this.formValidation()
        if (formValidation) {
            axios.post("https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/login", this.state)
            .then((res) => {
              console.log(res)
            })
            .catch((err)=>{
              console.log(err);
              console.log("checking for invalid password.....")
              this.setState({
                passwordError : "Invalid Password"
              })
            })
        }
    }

    render () {
        const { emailError, passwordError } = this.state

        return (
        <div className="modal-dialog modal-dialog-centered login-form" role="document">
            <div className="modal-content">
                <div className="modal-header">
                    <h5 className="modal-title" id="exampleModalCenterTitle">Sign In</h5>
                    <button type="button" className="close" data-dismiss="modal" aria-label="Close">
                        <span onClick={()=> {this.setState(initialState); this.props.handleModelOnClick()}}>&times;</span>
                    </button>
                </div>

                <div className="modal-body">
                    <form className="form-signin" onSubmit={ this.handleOnSubmit }>
                        <div className="form-label-group">
                            <label htmlFor="inputEmail">Email address</label>
                            <input onChange={ this.handleOnChange } type="text" name='email' id="inputEmail" className="form-control"  value={this.state.email} />
                            <div className='alert'>{emailError}</div>

                        </div>
                        <div className="form-label-group">
                            <label htmlFor="inputPassword">Password</label>
                            <input onChange={ this.handleOnChange } type="password" name='password' id="inputPassword" className="form-control" value={ this.state.password } />
                            <div className='alert'>{passwordError}</div>
                            <div className="form-btn">
                                <button className="btn btn-primary"><span><i class="fas fa-sign-in-alt"></i></span>Login</button>
                            </div>
                        </div>
                    </form>
                    <div className="login-footer">
                            <button className="google-btn" onClick={this.googlePopUp}><span><i class="fab fa-google"></i></span>Sign In with Google</button>
                    </div>
                </div>
            </div>
        </div>
        )
    }
}

export default Login
