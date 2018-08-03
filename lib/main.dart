import 'package:flutter/material.dart';

import './pages/splash_screen.dart';
import './pages/home.dart';
import './utils/specific_data.dart';

void main() {
  runApp(
    new App()
  );
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MySplashScreen(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new HomePage(),
        '/specific-data-spaces': (BuildContext context) => new SpecificData('spaces'),
        '/specific-data-collections': (BuildContext context) => new SpecificData('collections'),
        '/specific-data-datasets': (BuildContext context) => new SpecificData('datasets'),
      }
    );
  }
}