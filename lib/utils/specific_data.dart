import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
    String username = 'vibhavk2@illinois.edu';
    String password = 'Vibhav27\$';
    String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.get('http://127.0.0.1:9000/api/'+type,
    headers: {
      "Authorization": basicAuth,
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

    if(type == "spaces") {
      iconToReturn = Icon(Icons.home);
    } else if(type == "collections") {
      iconToReturn =  Icon(Icons.book);
    } else if(type == "datasets") {
      iconToReturn = Icon(Icons.folder);
    } else {
      iconToReturn = Icon(Icons.file_download);
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
            ),
            new ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: Text('EXPLORE', style: new TextStyle(color: Colors.redAccent)),
                    onPressed: () {
                      Navigator.push(
                      context, 
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new DisplayData(type.substring(0, type.length - 1).toString(), data["id"])
                        ));
                      },
                  ),
                ],
              ),
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
            childAspectRatio: 1.3,
            children: List.generate(data == null ? 0 : data.length, (index) {
              return buildCard(data[index]);
            }),
        )
      )
    );
  }

}