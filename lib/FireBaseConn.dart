import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'Login Screen/loginPageController.dart';
import 'User.dart';

class FireBaseConn {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _fireStore = Firestore.instance;

  saveDeviceToken(FirebaseMessaging _fcm) async {
    // Get the current user
    String uid = 'user1';
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _fireStore
          .collection('Users')
          .document(uid)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
      });
    }
  }

  Future<AuthResult> register(String email, String pw) async {
    return _auth.createUserWithEmailAndPassword(email: email, password: pw);
  }

  Future<AuthResult> login(String email, String pw) async {
    return _auth.signInWithEmailAndPassword(email: email, password: pw);
  }

  Future<DocumentSnapshot> getDocumentsFrom(
      {@required String collectionName, @required String documentName}) async {
    return await _fireStore
        .collection(collectionName)
        .document(documentName)
        .get();
  }



  Future<FirebaseUser> checkUser() {
    return _auth.currentUser();
  }

  logOut() async {
    _auth.signOut();
  }
}
