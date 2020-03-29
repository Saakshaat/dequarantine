import React, { Component } from 'react';
import { withRouter } from 'react-router-dom'
import axios from 'axios';

const initialState = {
    email: '',
    password: '',
    emailError: '',
    passwordError: '',
    messageError: '',
}

class Login extends Component {
    state = initialState

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
              this.setState({
                passwordError : "Invalid Password"
              })
            })
        }
    }

    render () {
        const { emailError, passwordError } = this.state

        return (
        <div className="modal-dialog modal-dialog-centered" role="document">
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

                        </div>
                        <div className="modal-footer">
                            <button type="submit" className="btn btn-primary">Log in</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        )
    }
}

export default withRouter(Login)
