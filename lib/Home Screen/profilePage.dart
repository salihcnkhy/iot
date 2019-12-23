import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iot102/ScreenSize.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black38)),
            ),
            width: ScreenSize().screenWidth(context),
            height: 170,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(width: 3, color: Colors.black38),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://pbs.twimg.com/profile_images/507815471102447616/7WyKeVRa_400x400.jpeg"),
                          fit: BoxFit.contain)),
                  width: 150,
                  height: 150,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: _textField(context, "E-Mail")),
                //TODO email bölümü eklenecek
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: _textField(context, "Cihaz No")),
                //TODO email bölümü eklenecek
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: _textField(context, "Site")),
                //TODO email bölümü eklenecek
              ],
            ),
          ),
          Container(height: 200, color: Colors.red),
        ],
      ),
    );
  }
}

InputDecoration _decoration(String hint) {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    labelText: hint,
    contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
        borderSide: BorderSide(color: Colors.white, width: 20.0)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    ),
  );
}

Widget _textField(BuildContext context, String hint) {
  return Material(
    elevation: 10.0,
    shadowColor: Colors.black,
    
    child: Container(
      width: ScreenSize().screenWidth(context) * 0.9,
      height: 40,
      child: TextFormField(
        
        obscureText: false,
        autofocus: false,
        decoration: _decoration(hint),
      ),
    ),
    borderRadius: BorderRadius.circular(32.0),
  );
}
