import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


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
      body: new Center(
        child: _image == null
            ? new Text('No image selected.')
            : new Image.file(_image),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return new Scaffold();
  // }

}