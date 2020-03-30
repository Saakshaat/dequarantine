class EmailUser {
  String _uid;
  String _email;
  String _username;
  String _token;
  String _password;

  EmailUser(user) {
    _init(user);
  }

  void _init(user){
    this._email = user["email"];
    this._password = user["password"];
    this._token = user["token"];
  }

  get (){
    Map attributes = {
      "uid": _uid,
      "email": _email,
      "password": _password
    };

    return attributes;
  }

  void setToken(token) {
    _token = token;
  }

  void printData() {
    print("===================");
    print(_username);
    print(_email);
    print(_password);
    print("===================");
  }

  void signOut() {
    this._uid = null;
    this._uid = null;
    this._email = null;
    this._username = null;
    this._token = null;
    this._password = null;
  }

  String getToken() {
    return _token;
  }
}