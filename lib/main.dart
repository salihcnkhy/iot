import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:iot102/FireBaseConn.dart';
import 'package:iot102/Home%20Screen/homeScreenControl.dart';
import 'package:iot102/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 static FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message)async {print(message);},
      onResume: (Map<String, dynamic> message)async {print(message);},
      onLaunch: (Map<String,dynamic> message)async{print(message);},
    );
    _firebaseMessaging.getToken().then((token){
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireBaseConn().checkUser(),
      builder: (context, res) {
        if (res.data != null) {
          return MaterialApp(home: HomePage());
        } else {
          return MaterialApp(home: SplashScreen());
        }
      },
    );
  }
}
/* */
