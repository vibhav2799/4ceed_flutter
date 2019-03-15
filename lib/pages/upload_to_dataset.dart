import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UploadFilesToDataset extends StatefulWidget {

  final String datasetId;
  UploadFilesToDataset(this.datasetId);

  State createState() => new UploadFilesToDatasetState();
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
          onPressed: () {uploadToDataset();},
          color: Colors.red,
          child: Text('Upload', style: TextStyle(color: Colors.white)),
        )]),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
  uploadToDataset() async {
    http.Response response = await http.post(serverAddress + "/api/spaces",
        body: json.encode({
          "name": nameController.text,
          "description": descriptionController.text
        }),
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/home');
    }

  }

}