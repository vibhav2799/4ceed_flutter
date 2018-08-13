import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import './user_info.dart';
import '../utils/drawer.dart';
import './home_data.dart';

class SpecificData extends StatefulWidget {
  final String type;
  SpecificData(this.type);

   @override
    State createState() => SpecificDataState(type);
}

class SpecificDataState extends State<SpecificData> {
  String type;
  List data;

  SpecificDataState(this.type);


  Future<String> getData() async {

    http.Response response = await http.get(serverAddress+'/api/'+type,
    headers: {
      "Authorization": auth,
      "Content-Type": "application/json",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Methods": "*",
      "Content-Encoding": "gzip",
      "Access-Control-Allow-Origin": "*"
    }
    );

    this.setState( () {
      data = jsonDecode(response.body);
    });

    return "Success";
  }

  @override
  void initState() {
    this.getData();
  }

  Icon getIconAssociatedToType() {
    Icon iconToReturn;

    if (type == "spaces") {
      iconToReturn = Icon(Icons.home, color: Colors.indigoAccent,);
    } else if (type == "collections") {
      iconToReturn = Icon(Icons.book, color: Colors.black);
    } else if (type == "datasets") {
      iconToReturn = Icon(Icons.folder, color: Colors.blueGrey);
    } else {
      iconToReturn = Icon(Icons.file_download, color: Colors.tealAccent,);
    }

    return iconToReturn;
  }

  Card buildCard(var data) {
    var customCard = new Card(
      elevation: 5.0,
      margin: EdgeInsets.all(2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: getIconAssociatedToType(),
              title: Text(
                data[type=="collections" ? "collectionname" : "name"], 
                style: new TextStyle(fontWeight: FontWeight.bold), 
                overflow: TextOverflow.ellipsis
              ),
              subtitle: Text(
                type.substring(0, type.length - 1).toString().toUpperCase(),
                style: new TextStyle(fontSize: 12.0)
              ),
              onTap: () {
                Navigator.push(
                      context, 
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new DisplayData(type.substring(0, type.length - 1).toString(), data["id"])
                        ));

              }
            ),
          ],
        ),
    );
    return customCard;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          type.toString().toUpperCase()), 
          backgroundColor: Colors.redAccent,
        ),
      drawer: new MyDrawer(),
      body: new Container(
        padding: EdgeInsets.only(top: 20.0),
        color: Colors.white10,
        child: new GridView.count(
            primary: true,
            padding: EdgeInsets.all(15.0),
            crossAxisCount: 2,
            childAspectRatio: 2.0,
            children: List.generate(data == null ? 0 : data.length, (index) {
              return buildCard(data[index]);
            }),
        )
      )
    );
  }

}