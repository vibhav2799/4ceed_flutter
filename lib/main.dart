import 'package:flutter/material.dart';

import './pages/splash_screen.dart';
import './utils/home_data.dart';
import './utils/specific_data.dart';
import './pages/empty.dart';

// Main controller to run 4ceed_app
void main() {
  runApp(
    new App()
  );
}

// A stateless widget to control routes in the application
class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MySplashScreen(),
      routes: <String, WidgetBuilder> {
        // Declared all application routes below
        '/home': (BuildContext context) => new DisplayData('', ''),
        '/specific-data-spaces': (BuildContext context) => new SpecificData('spaces'),
        '/specific-data-collections': (BuildContext context) => new SpecificData('collections'),
        '/specific-data-datasets': (BuildContext context) => new SpecificData('datasets'),
        '/data-not-found': (BuildContext context) => new EmptyData()
      }
    );
  }
}
