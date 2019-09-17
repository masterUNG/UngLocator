import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ung_locator/screens/my_services.dart';
import 'package:ung_locator/screens/my_style.dart';
import 'package:ung_locator/screens/register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit

  // Method
  @override
  void initState() { 
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus()async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {

      MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
    }
  }


  Widget signUpButton() {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.red[800]),
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.red[800]),
        ),
        onPressed: () {
          MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(materialPageRoute);
        },
      ),
    );
  }

  Widget signInButton() {
    return Expanded(
      child: RaisedButton(
        color: Colors.red[800],
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget showButton() {
    return Container(
      width: 250.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          signInButton(),
          SizedBox(
            width: 4.0,
          ),
          signUpButton(),
        ],
      ),
    );
  }

  Widget emailText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email, color: Colors.red[800],),
          labelText: 'Email :',
        ),
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Colors.red[800],),
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
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white, MyStyle().myMainColor],radius: 1.0,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showLogo(),
                showAppName(),
                emailText(),
                passwordText(),
                SizedBox(
                  height: 16.0,
                ),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
