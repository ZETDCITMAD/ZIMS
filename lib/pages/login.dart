import 'package:flutter/material.dart';
import 'package:oms_mobile/ui/login_form.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(30.0),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 20.0),
            child: Image.asset(
              'android/assets/landingImg.png',
              width: 200,
              height: 200,
            ),
          ),
          Text("KUDA's-MOBILE",
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          LoginForm(),
        ],
      ),
    ));
  }
}
