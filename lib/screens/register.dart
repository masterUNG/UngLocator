import 'package:flutter/material.dart';
import 'package:ung_locator/screens/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit

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
    );
  }

  Widget emailText() {
    return TextFormField(keyboardType: TextInputType.emailAddress,
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
    );
  }

  Widget content() {
    return ListView(
      padding: EdgeInsets.all(50.0),
      children: <Widget>[
        nameText(),emailText(), passwordText(),
      ],
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {},
    );
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
