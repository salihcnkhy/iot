import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {

  final Function onPress;

  LoginButton({this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width * 0.85,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: onPress,
          child: Text("Login",
              textAlign: TextAlign.center,
              style: TextStyle().copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "Roboto")),
        ),
      ),
    );
  }
}
