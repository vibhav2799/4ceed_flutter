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
      body: ListView (
        children: <Widget>[Center(
        child: _image == null
            ? new Text('No image selected.')
            : new Image.file(_image),
      ), MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: null,
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
 

}