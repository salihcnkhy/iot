import 'package:flutter/material.dart';

class DeviceField extends StatelessWidget {

  final TextEditingController emailFieldController;
  final String hintTitle;

  DeviceField({@required this.emailFieldController,@required this.hintTitle});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
      child: _textField(context),
    );
  }

  Widget _textField(BuildContext context) {
    return Material(
      elevation: 20.0,
      shadowColor: Colors.black,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 50,
        child: TextFormField(
          controller: emailFieldController,
           obscureText: false,
          autofocus: false,
          decoration: _decoration(),
        ),
      ),
      borderRadius: BorderRadius.circular(32.0),
    );
  }

  InputDecoration _decoration() {
    return InputDecoration(
      icon: new Icon(Icons.supervised_user_circle, color: Color(0xff224597)),
      hintText: hintTitle,
      fillColor: Colors.white,
      filled: true,
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
}
