import 'package:flutter/material.dart';
import 'package:my_app/utils/dataset_form.dart';
import '../utils/user_info.dart';
import '../utils/form.dart';

class CreateForm extends StatelessWidget {
  final String type;
  final String id;
  CreateForm(this.type, this.id);

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
    return new Container(
        child: Scaffold(
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
                  FormBuilder(type, id),
                ]))));
  }
}

