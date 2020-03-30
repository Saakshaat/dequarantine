import 'package:dequarantine/constants.dart';
import 'package:dequarantine/models/email_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  bool obscurePassword = true;

  String _email;
  String _password;

  TextEditingController _emailController;
  TextEditingController _passwordController;

  final passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }


  void _signIn() async {
    Fluttertoast.showToast(msg: "Signing you in");
    _email = _emailController.text;
    _password = _passwordController.text;
    currentUser = EmailUser({
      "email": _email,
      "password": _password,
      "token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjgzYTczOGUyMWI5MWNlMjRmNDM0ODBmZTZmZWU0MjU4Yzg0ZGI0YzUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZGVxdWFyYW50aW5lLWFhZTVmIiwiYXVkIjoiZGVxdWFyYW50aW5lLWFhZTVmIiwiYXV0aF90aW1lIjoxNTg1NTE4NTEyLCJ1c2VyX2lkIjoiaVRvNjFEUERIR2RKbjNHaVMzOUdJaHZhTTBvMSIsInN1YiI6ImlUbzYxRFBESEdkSm4zR2lTMzlHSWh2YU0wbzEiLCJpYXQiOjE1ODU1MTg1MTIsImV4cCI6MTU4NTUyMjExMiwiZW1haWwiOiJnZXJtYWluLmxlaWduZWxAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImdlcm1haW4ubGVpZ25lbEBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.CpWVXi98tDKk5YCA5SLJIt_FukkcqUPVsNs16F6g3qlFp4h0NYNJltKHR01RQayCDKZOfNjPVuh9Szf_MPSFz7dSCCxsDc39hff9az0tmnPprtOJAJf_piu0FkOGJ36F80SGkjYpXYhHJVLy1lhRxjOrXojM2QcuXhVlkiy5e3u4WjI2mzS7nvkavVGsRUJqWlSCeeQWEGol5c29MDlIuFr60uFJIGSAGWmYFdTsNr2_udXdwx8ToFXbdnvmP2yhi4r7tno55Zw6SYi4tVFVHv8M7fXjBgJ_WntVHoNvzhr8fAj9cicHgPfSDIzA3FPc-7nAIje8fPRKB_bbVTnXpw",
    });

    currentUser.printData();

    bool response = await login.signInEmailToApi();

    if (response) {
      Fluttertoast.showToast(msg: "Redirecting");
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Fluttertoast.showToast(msg: "Sign in unsuccessful");
    }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              // hintText: "How do people reach you?",
              labelText: "Email",
            ),
            autofocus: true,
            controller: _emailController,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordFocus);
            },
          ),
          TextFormField(
            focusNode: passwordFocus,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              // hintText: "??",
              labelText: "Password",
            ),
            controller: _passwordController,
            obscureText: obscurePassword,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              _signIn();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("No account?"),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/signup");
                },
                child: Text("Create an account here"),
              )
            ],
          )
        ],
      ),
    );
  }
}