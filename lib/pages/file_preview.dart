import 'dart:async';
import 'dart:convert';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import '../utils/user_info.dart';

class PreviewFile extends StatelessWidget {
  final String fileId;
  PreviewFile(this.fileId);

  String _localPath;

  fetchPdf() async {
    final directory = await getApplicationDocumentsDirectory();
    _localPath = directory.path;
    
    http.Response response = await http.get(serverAddress+'/api/files/'+fileId, headers: {
      "Authorization": auth,
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Methods": "*",
      "Content-Encoding": "gzip",
      "Access-Control-Allow-Origin": "*"
    });
    final File file = new File("$_localPath/output.pdf");
    await file.writeAsBytes(response.bodyBytes);

    OpenFile.open(file.path);
  }


//http://127.0.0.1:9000/api/files/5b4f9eeae84a34d772377758

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('4CeeD Home'),
        backgroundColor: Colors.redAccent,
      ),
      body: new FlatButton(onPressed: () => fetchPdf(), child: Text('EXPLORE', style: new TextStyle(color: Colors.redAccent)),),
      
      //Image.network('http://127.0.0.1:9000/api/previews/5b6882862f6c802673f902ee', 
    //   headers: {
    //   "Authorization": auth,
    //   "Content-Type": "application/json",
    //   "Accept": "application/json",
    //   "Access-Control-Allow-Credentials": "true",
    //   "Access-Control-Allow-Methods": "*",
    //   "Content-Encoding": "gzip",
    //   "Access-Control-Allow-Origin": "*",
    //   "Transfer-Encoding" : "chunked"
    // }
    );
  }
}
//'http://127.0.0.1:9000/api/files/5b55f39bb64accee5013988b'
//'http://127.0.0.1:9000/api/previews/5b6882862f6c802673f902ee',