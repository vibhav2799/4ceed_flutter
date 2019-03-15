import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../utils/drawer.dart';
import './user_info.dart';
import '../pages/file_preview.dart';
import './action_button.dart';
import '../pages/empty.dart';

class DisplayData extends StatefulWidget {
  final String givenType, givenId;

  DisplayData(this.givenType, this.givenId);

  @override
  State createState() => DisplayDataState(givenType, givenId);
}

class DisplayDataState extends State<DisplayData> {
  String givenType, givenId;
  String currentId, currentType;
  List data;
  DisplayDataState(this.givenType, this.givenId);
  bool isOpened = false;

  Future<String> getData(String nodeType, String parentId) async {
    http.Response response = await http.get(
        serverAddress +
            '/api/fulltree/getChildrenOfNode?nodeType=' +
            nodeType +
            '&nodeId=' +
            parentId,
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json",
          "Access-Control-Allow-Credentials": "true",
          "Access-Control-Allow-Methods": "*",
          "Content-Encoding": "gzip",
          "Access-Control-Allow-Origin": "*"
        });

    this.setState(() {
      if (response.body == "not implemented") {
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

    if (type == "space") {
      iconToReturn = Icon(
        Icons.home,
        color: Colors.indigoAccent,
      );
    } else if (type == "collection") {
      iconToReturn = Icon(Icons.book, color: Colors.black);
    } else if (type == "dataset") {
      iconToReturn = Icon(Icons.folder, color: Colors.blueGrey);
    } else {
      iconToReturn = Icon(
        Icons.file_download,
        color: Colors.tealAccent,
      );
    }

    return iconToReturn;
  }

  Card buildCard(var data) {
    var customCard = new Card(
      elevation: 5.0,
      margin: EdgeInsets.all(4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: getIconAssociatedToType(data["type"]),
            title: Text(data["value"],
                overflow: TextOverflow.ellipsis,
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
            subtitle: Text(data["type"].toString().toUpperCase(),
                style: new TextStyle(fontSize: 12.0),
                overflow: TextOverflow.ellipsis),
            onTap: () {
              
              this.setState((){
                currentType = data["type"];
                currentId = data["id"];
              });

              print("test: "+currentId);

              if (data["type"] != "file") {
                this.getData(data["type"], data["id"]);
              } else {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new PreviewFile(data["id"])));
              }
            },
          ),
        ],
      ),
    );
    return customCard;
  }

  void toggle() {
    this.setState(() {
      isOpened = !isOpened;
    });
    print(isOpened);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('4CeeD Home'),
        backgroundColor: Colors.redAccent,
      ),
      drawer: new MyDrawer(),
      body: new Opacity(
          opacity: isOpened ? 0.3 : 1.0,
          child: data != null && data.length == 0
              ? new EmptyData()
              : Container(
                  padding: EdgeInsets.only(top: 20.0),
                  color: Colors.white10,
                  child: new GridView.count(
                    primary: true,
                    padding: EdgeInsets.all(15.0),
                    crossAxisCount: 2,
                    childAspectRatio: 2.0,
                    children:
                        List.generate(data == null ? 0 : data.length, (index) {
                      return buildCard(data[index]);
                    }),
                  ))),
      floatingActionButton: new MenuButton(toggle, currentType == null ? widget.givenType : currentType, currentId, context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
