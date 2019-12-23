import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot102/FireBaseConn.dart';
import 'package:iot102/Home%20Screen/HomePage.dart';
import 'package:iot102/Login%20Screen/loginPageController.dart';
import 'package:iot102/User.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  void navigationPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new LoginPage();
    }));
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _waitPhoto() {
    return Scaffold(
      body: new Center(
        child: new Image.asset('assets/pet.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireBaseConn().checkUser(),
      builder: (context, response) {
        if (response.connectionState == ConnectionState.waiting) {
        print(response.connectionState);
          return _waitPhoto();
        } else if (response.connectionState == ConnectionState.done &&
            response.data != null) {
          var _currentUser = response.data as FirebaseUser;
          return FutureBuilder(
            future: FireBaseConn().getDocumentsFrom(
                collectionName: "Users", documentName: _currentUser.uid),
            builder: (context, res) {
              if (res.data != null &&
                  res.connectionState == ConnectionState.done) {
                user = new User(
                    containerCapacity: res.data["containerCapacity"],
                    currentContainerCapacity:
                        res.data["currentContainerCapacity"],
                    currentStorageCapacity: res.data["currentStorageCapacity"],
                    storageCapacity: res.data["storageCapacity"],
                    lastSevenDays: List.from(res.data["days"]));
                return HomePage();
              } else if (response.connectionState == ConnectionState.done &&
                  res.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.cyan,
                    strokeWidth: 5,
                  )),
                );
              } else {
                return Container(
                  color: Colors.red,
                );
              }
            },
          );
        } else if (response.connectionState == ConnectionState.done &&
            response.data == null) {
          return LoginPage();
        } else {
          return Container(color: Colors.red);
        }
      },
    );
  }
}
