import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class DisplayData extends StatefulWidget {
   @override
    State createState() => DisplayDataState();
}

class DisplayDataState extends State<DisplayData> {
  List data;

  Future<String> getData(String nodeType, String parentId) async {
    String username = 'vibhavk2@illinois.edu';
    String password = 'Vibhav27\$';
    String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.get('http://127.0.0.1:9000/api/fulltree/getChildrenOfNode?nodeType='+nodeType+
      '&nodeId='+parentId,
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
    this.getData('root', '');
  }

  Icon getIconAssociatedToType(String type) {
    Icon iconToReturn;

    if(type == "space") {
      iconToReturn = Icon(Icons.home);
    } else if(type == "collection") {
      iconToReturn =  Icon(Icons.book);
    } else if(type == "dataset") {
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
              leading: getIconAssociatedToType(data["type"]),
              title: Text(data["value"], overflow: TextOverflow.ellipsis, style: new TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(data["type"].toString().toUpperCase(), overflow: TextOverflow.ellipsis),
            ),
            new ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: Text('EXPLORE', style: new TextStyle(color: Colors.redAccent)),
                    onPressed: () {this.getData(data["type"], data["id"]);},
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
    return new Container(
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
    );
  }

}