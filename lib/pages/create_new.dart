import 'package:flutter/material.dart';
import '../utils/user_info.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CreateForm extends StatelessWidget {
  final String type;
  //final String id;
  CreateForm(this.type);

  String getText(String type) {
    if (type == "space") {
      return spaceInfo;
    } else if (type == "collection") {
      return collectionInfo;
    }
    return datasetInfo;
  }

  getIconAssociatedToType(String type) {
    if (type == "space") {
      return Icons.home;
    } else if (type == "collection") {
      return Icons.book;
    } else if (type == "dataset") {
      return Icons.folder;
    } else {
      return Icons.file_download;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: Text("Create New " + type.toUpperCase()),
            ),
            body: Center(
                child: ListView(
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    children: <Widget>[
                  new Padding(padding: EdgeInsets.only(top: 30.0)),
                  new Icon(
                    getIconAssociatedToType(type),
                    size: 50.0,
                    color: Colors.blueGrey,
                  ),
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  new Text("Create New " + type.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[750],
                          fontSize: 30.0)),
                  new Padding(padding: EdgeInsets.only(top: 30.0)),
                  new Text(getText(type),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      )),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  FormBuilder(type),
                ]))));
  }
}

class FormBuilder extends StatefulWidget {
  final String type;

  FormBuilder(this.type);

  @override
  FormBuilderState createState() {
    return FormBuilderState();
  }
}

class FormBuilderState extends State<FormBuilder> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: new InputDecoration(
              labelText: "Name",
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Name cannot be empty';
              }
            },
          ),
          TextFormField(
            decoration: new InputDecoration(labelText: "Description"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Description cannot be empty';
              }
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  minWidth: 200.0,
                  height: 42.0,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      createNewSpace();
                    }
                  },
                  color: Colors.red,
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              )),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            child: MaterialButton(
              minWidth: 150.0,
              height: 42.0,
              onPressed: () {},
              color: Colors.blueGrey,
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Creates a new Space as the root (only possibility for spaces)
  createNewSpace() async {
      http.Response response = await http.post(
        serverAddress + "/api/spaces",
        body: json.encode({"name": "vibsss", "description" : "kibs"}),
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
        });
        print(response.body);
  }

  // Creates a new Collection as root/under a space (depends on whether the id parameter is passed)
  // param: spaceId (optional)
  createNewCollection(spaceId) async {
    http.Response response = await http.post(
        serverAddress + "/api/collection",
        body: json.encode({"name": "vibsss", "description" : "kibs"}),
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
        print(response.body);
  }

  // Creates a new Collection under a collection 
  // param: collId (required)
  createNewChildCollection(collId) async {
    http.Response response = await http.post(
        serverAddress + "/api/collections/newCollectionWithParent",
        body: json.encode({"name": "vibsss", "description" : "kibs"}),
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
        print(response.body);
  }

  // Creates a new dataset under a space/collection/root
  // param : spaceId (optional), collId (optional)
  createNewDataset(spaceId, collId) async {
    http.Response response = await http.post(
        serverAddress + "/api/datasets/createempty",
        body: json.encode({"name": "vibsss", "description" : "kibs"}),
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
        print(response.body);
    
  }
}
