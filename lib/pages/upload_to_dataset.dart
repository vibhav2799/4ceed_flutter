import 'dart:async';
import 'dart:io';

import '../utils/user_info.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var jsonData = "";

class UploadFilesToDataset extends StatefulWidget {

  final String datasetId;
  UploadFilesToDataset(this.datasetId);

  State createState() => new UploadFilesToDatasetState();
}

void uploadFile(datasetId) async {
    http.Response response = await http.post(serverAddress + "/api/uploadToDataset/" + datasetId,
        body: json.encode(jsonData),
        headers: {
          "Authorization": auth,
          "Content-Type": "multipart/form-data",
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      print("uploaded");
    }
    print(response.body);
  }

class UploadFilesToDatasetState extends State<UploadFilesToDataset> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Upload File(s)'),
      ),
      body: ListView (
        children: <Widget>[Center(
        child: _image == null
            ? new Text('No image selected.')
            : new Image.file(_image),
      ), MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          color: Colors.red,
          child: Text('Upload', style: TextStyle(color: Colors.white)),
          onPressed: () => uploadFile("abc"),
        )]),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}