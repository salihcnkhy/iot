import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:iot102/FireBaseConn.dart';
import 'package:iot102/splashScreen.dart';

import 'Home Screen/HomePage.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 static FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message)async {print(message);},
      onResume: (Map<String, dynamic> message)async {print(message);},
      onLaunch: (Map<String,dynamic> message)async{print(message);},
    );
    FireBaseConn().saveDeviceToken(_firebaseMessaging);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen(),);
  }
}
/* */
