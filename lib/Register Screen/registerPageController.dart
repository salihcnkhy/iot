import 'package:flutter/material.dart';
import 'package:iot102/FireBaseConn.dart';
import 'package:iot102/Home%20Screen/HomePage.dart';
import 'package:iot102/Register%20Screen/deviceFiled.dart';
import 'registerButton.dart';
import './emailFields.dart';
import './passwordFields.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController emailConfirm = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirm = TextEditingController();
  final TextEditingController device = TextEditingController();

  void _register(BuildContext context) {
    var _email = email.text;
    var _emailCon = emailConfirm.text;
    var _password = password.text;
    var _passwordCon = passwordConfirm.text;
    var _device = device.text;

    if (_email != _emailCon) {
      _showDialog("Email Adresleri Uyuşmuyor", context);
      return;
    }
    if (_password != _passwordCon) {
      _showDialog("Şifreler Uyuşmuyor.", context);

      return;
    }

    print(_email);
    print(_password);
     FireBaseConn().register(_email, _password).then(
        (err) => {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return new HomePage();
                },
              ), (_) => false)
            },
        onError: (err) => print(err.toString()));

  }

  void _showDialog(String text, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(text),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.appBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DeviceField(emailFieldController: device,hintTitle: "Device No",),
            EmailFields(
              emailFieldController: email,
              hintTitle: "E-Mail",
            ),
            EmailFields(
              emailFieldController: emailConfirm,
              hintTitle: "E-Mail Confirm",
            ),
            PasswordFields(
              passwordFieldConroller: password,
              hintTitle: "Password",
            ),
            PasswordFields(
              passwordFieldConroller: passwordConfirm,
              hintTitle: "Password Confirm",
            ),
            RegisterButton(
              onPress: () => _register(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.blue, size: 20, opacity: 1),
      backgroundColor: Colors.transparent,
      title: Text(
        "Register",
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}
