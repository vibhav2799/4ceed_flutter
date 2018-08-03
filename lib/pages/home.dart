import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:path/path.dart';

import './login.dart';
import '../utils/data.dart';
import '../utils/drawer.dart';

//String selectedUrl = 'http://127.0.0.1:9000';

class HomePage extends StatefulWidget {
    @override
    State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(title: new Text('4CeeD Home'), backgroundColor: Colors.redAccent),
        drawer: new MyDrawer(),
        body: new DisplayData()
      );
    }
}