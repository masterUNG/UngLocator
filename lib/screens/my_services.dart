import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ung_locator/screens/home.dart';
import 'package:ung_locator/screens/information.dart';
import 'package:ung_locator/screens/my_style.dart';
import 'package:ung_locator/screens/show_list_food.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String loginString = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Widget currentWidget = ShowListFood();

  // Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      loginString = firebaseUser.displayName;
    });
  }

  Widget processSignOut() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        color: Colors.orange,
      ),
      title: Text("Sign Out"),
      subtitle: Text('Sign Out and Move to Authen Page'),
      onTap: () {
        mySignOut();
      },
    );
  }

  Future<void> mySignOut() async {
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget menuInformation() {
    return ListTile(
      leading: Icon(
        Icons.info,
        color: Colors.blue,
      ),
      title: Text('Information'),
      subtitle: Text('Information of User Login'),onTap: (){
        setState(() {
          currentWidget = Information();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuShowListFood() {
    return ListTile(
      leading: Icon(
        Icons.fastfood,
        color: Colors.red,
      ),
      title: Text('Show List Food'),
      subtitle: Text('Show All Food in Ung Locator'),
      onTap: () {
        setState(() {
          currentWidget = ShowListFood();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget showLogin() {
    return Text(
      'Login by $loginString',
      style: TextStyle(
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung Logator',
      style: TextStyle(
        fontSize: MyStyle().h1,
        color: MyStyle().myTextColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget showImage() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget myHeadDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, MyStyle().myMainColor],
          radius: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          showImage(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget myDrawerMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myHeadDrawer(),
          menuShowListFood(),
          menuInformation(),
          processSignOut(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().myMainColor,
        title: Text('My Service'),
      ),
      body: currentWidget,
      drawer: myDrawerMenu(),
    );
  }
}
