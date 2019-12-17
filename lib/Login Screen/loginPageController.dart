import 'package:flutter/material.dart';
import 'package:iot102/FireBaseConn.dart';
import '../Register Screen/registerPageController.dart';
import '../Home Screen/homeScreenControl.dart';
import '../User.dart';
import './emailField.dart';
import './passwordField.dart';
import './loginButton.dart';
import './imageField.dart';
import './registerButton.dart';

User user;

class LoginPage extends StatelessWidget {
  final emailFieldController = TextEditingController();
  final passwordFieldConroller = TextEditingController();

  void _login(BuildContext context) {
    print(emailFieldController.text);
    print(passwordFieldConroller.text);
    var _email = emailFieldController.text;
    var _password = passwordFieldConroller.text;

    FireBaseConn().login(_email, _password).then(
        (res) => {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return new HomePage();
                },
              ), (_) => false)
            },
        onError: (err) => print(err.toString()+" Burdaaa"));
  }

  void _register(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return new RegisterPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImageField(),
                EmailField(emailFieldController),
                PasswordField(passwordFieldConroller),
                LoginButton(
                  onPress: () => _login(context),
                ),
                Text(
                  "OR",
                  style: new TextStyle(
                    fontFamily: "Arial",
                    fontSize: 20,
                    color: Colors.black45,
                  ),
                ),
                RegisterButton(
                  onPress: () => _register(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
