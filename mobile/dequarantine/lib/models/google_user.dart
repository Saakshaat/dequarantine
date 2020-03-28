class GoogleUser{
  String _uid;
  String _name;
  String _imageUrl;
  String _email;

  String _accessToken;
  String _idToken;

  GoogleUser(user) {
    _init(user);
  }

  void _init(Map user){
    this._uid = user["uid"];
    this._name = user["displayName"];
    this._imageUrl = user["photoUrl"];
    this._email = user["email"];
    this._accessToken = user["accessToken"];
    this._idToken = user["idToken"];
  }

  void printData() {
    print("===================");
    print(_name);
    print(_uid);
    print(_imageUrl);
    print(_email);
    print(_accessToken);
    print(_idToken);
    print("===================");
  }

  get (){
    List attributes = [
      _uid,
      _name,
      _imageUrl,
      _email,
      _accessToken,
      _idToken,
    ];

    return attributes;
  }

  void clean() {
    this._uid = null;
    this._name = null;
    this._imageUrl = null;
    this._email = null;
    this._accessToken = null;
    this._idToken = null;

    printData();
  }
}