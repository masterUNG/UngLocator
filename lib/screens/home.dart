import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit

  // Method
  Widget emailText() {
    return Container(
      width: 250.0,
      child: TextFormField(keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          labelText: 'Email :',
        ),
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 250.0,
      child: TextFormField(obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          labelText: 'Password :',
        ),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung Locator',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.red[800],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              showLogo(),
              showAppName(),
              emailText(),
              passwordText(),
            ],
          ),
        ),
      ),
    );
  }
}
