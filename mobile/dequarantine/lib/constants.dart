import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dequarantine/models/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

UserManagement login = UserManagement();

var currentUser;

GoogleSignIn googleSignIn = GoogleSignIn();

Firestore fireStoreReference = Firestore.instance;