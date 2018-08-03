import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import './login.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 7,
      navigateAfterSeconds: new SignIn(),
      title: new Text('Welcome to 4CeeD',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
        color: Colors.white
      ),),
      imageNetwork: 'https://4ceed.illinois.edu/assets/images/atom_white.png',
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }
}
