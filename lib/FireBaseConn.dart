import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireBaseConn {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _fireStore = Firestore.instance;
  Future<AuthResult> register(String email, String pw) async {
    return _auth.createUserWithEmailAndPassword(email: email, password: pw);
  }



  Future<AuthResult> login(String email, String pw) async {
    return _auth.signInWithEmailAndPassword(email: email, password: pw);
  }

  Future<DocumentSnapshot> getDocumentsFrom({@required String collectionName,@required String documentName}) async {
    return await _fireStore.collection(collectionName).document(documentName).get();
  }

  Future<FirebaseUser> checkUser() async {
    FirebaseUser user1 = await _auth.currentUser();
    return user1;
   
  }

  logOut() async{

    _auth.signOut();

  }
  
}
