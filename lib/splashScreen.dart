import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iot102/Login%20Screen/loginPageController.dart';

import 'Home Screen/homeScreenControl.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
 
}

 
class _SplashScreenState extends State<SplashScreen> {


  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
  Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return new LoginPage();
      }));
}

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('assets/pet.png'),
      ),
    );
  }
}