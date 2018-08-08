import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../utils/drawer.dart';
import './user_info.dart';
import '../pages/file_preview.dart';


class DisplayData extends StatefulWidget {
  final String givenType, givenId;

  DisplayData(this.givenType, this.givenId);

   @override
    State createState() => DisplayDataState(givenType, givenId);
}

class DisplayDataState extends State<DisplayData> {
  String givenType, givenId;
  List data;
  DisplayDataState(this.givenType, this.givenId);

  Future<String> getData(String nodeType, String parentId) async {
    http.Response response = await http.get(serverAddress+'/api/fulltree/getChildrenOfNode?nodeType='+nodeType+
      '&nodeId='+parentId,
    headers: {
      "Authorization": auth,
      "Content-Type": "application/json",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Methods": "*",
      "Content-Encoding": "gzip",
      "Access-Control-Allow-Origin": "*"
    }
    );

    print(response.body);
    this.setState( () {
      if(response.body == "not implemented") {
        data = ["400"];
      } else {
        data = jsonDecode(response.body);
      }
    });

    return "Success";
  }

  @override
  void initState() {
    if (givenId == '' && givenType == '') {
      this.getData('root', '');
    } else {
      this.getData(givenType, givenId);
    } 
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
              subtitle: Text(
                data["type"].toString().toUpperCase(), 
                style : new TextStyle(fontSize: 12.0),
                overflow: TextOverflow.ellipsis),
            ),
            new ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: Text('EXPLORE', style: new TextStyle(color: Colors.redAccent)),
                    onPressed: () {
                      if(data["type"] != "file") {
                        this.getData(data["type"], data["id"]);
                      } else {
                        Navigator.of(context).pushNamed('/preview');
                      }
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
          title: new Text('4CeeD Home'), 
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
              childAspectRatio: 1.2,
              children: List.generate(data == null ? 0 : data.length, (index) {
                return buildCard(data[index]);
              }),

      )
    )
    );
  }

}