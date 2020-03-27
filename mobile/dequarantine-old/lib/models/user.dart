import 'package:cloud_firestore/cloud_firestore.dart';


class User {
  final String name;
  final String id;

  User({this.name, this.id});

  factory User.fromFireStore(DocumentSnapshot user) {
    Map attributes = user.data;

    return User(
      id: user.documentID,
      name: attributes['name'],
    );
  }
}