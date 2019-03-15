import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import './login.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MySplashScreen> {
  // A splash screen widget below which loads for a while before the app runs. Displays 4CeeD logo along with message.
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 7,
      // Navigates to SignIn after loading is complete
      navigateAfterSeconds: new SignIn(),
      title: new Text('Welcome to 4CeeD',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
        color: Colors.white
      ),),
      image: new Image.asset(
      'images/atom_white.png'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }
}
