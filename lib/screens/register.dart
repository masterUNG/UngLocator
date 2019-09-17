import 'package:flutter/material.dart';
import 'package:ung_locator/screens/my_services.dart';
import 'package:ung_locator/screens/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString = '', emailString = '', passwordString = '';

  // Method
  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          size: 48.0,
          color: Colors.pink,
        ),
        labelText: 'Display Name :',
        labelStyle: TextStyle(color: Colors.pink),
        helperText: 'Type Your Name',
        helperStyle: TextStyle(color: Colors.pink),
      ),
      onSaved: (String value) {
        nameString = value.trim();
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          size: 48.0,
          color: Colors.greenAccent[700],
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: Colors.greenAccent[700]),
        helperText: 'Type Your Email',
        helperStyle: TextStyle(color: Colors.greenAccent[700]),
      ),
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          size: 48.0,
          color: Colors.purple,
        ),
        labelText: 'Password :',
        labelStyle: TextStyle(color: Colors.purple),
        helperText: 'Type Password',
        helperStyle: TextStyle(color: Colors.purple),
      ),
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  Widget content() {
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.all(50.0),
        children: <Widget>[
          nameText(),
          emailText(),
          passwordText(),
        ],
      ),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        formKey.currentState.save();
        print(
            'name = $nameString, email = $emailString, password = $passwordString');
        registerThread();
      },
    );
  }

  Future<void> registerThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Success');
      setupDisplayName();
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      print('title = $title, message = $message');
      myAlert(title, message);
    });
  }

  void myAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              Icons.add_alert,
              color: Colors.red,size: 36.0,
            ),
            title: Text(title),
          ),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> setupDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = nameString;
    firebaseUser.updateProfile(userUpdateInfo);

    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().myMainColor,
        title: Text('Register'),
        actions: <Widget>[registerButton()],
      ),
      body: content(),
    );
  }
}
