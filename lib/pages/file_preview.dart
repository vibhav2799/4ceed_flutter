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

  getFilePreviewUrl() async {
    http.Response response = await http.get(serverAddress+"/api/files/previewJson/"+fileId, headers: {
      "Authorization": auth,
    });

    var data = jsonDecode(response.body);
    if(response.statusCode == 200) {
      return data;
    } else {
      throw Exception("Failed");
    }
    
  }


  Future<Widget> getBodyWidget() async {
    var data = await getFilePreviewUrl();
    //var decodedData = jsonDecode(http.Response.body);
    if(data["content-type"] == "application/pdf") {
      return new FlatButton(onPressed: () => fetchPdf(data["id"], data["filename"]), 
        child: Text('OPEN PDF', 
        style: new TextStyle(color: Colors.redAccent))
      );
    } else if (data["previewsWithPreview"]=="/blob") {
      return new Image.network(serverAddress+'/api/files/'+fileId, 
      headers: {
      "Authorization": auth,
    });
    } else {
      return new Image.network(serverAddress+data["previewsWithPreview"], 
      headers: {
      "Authorization": auth,
    });
    }
  }

  fetchPdf(fileId, fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    String _localPath = directory.path;
    
    http.Response response = await http.get(serverAddress+"/api/files/"+fileId, headers: {
      //serverAddress+'/api/files/'+fileId, headers: {
      "Authorization": auth,
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Methods": "*",
      "Content-Encoding": "gzip",
      "Access-Control-Allow-Origin": "*"
    });
    final File file = new File("$_localPath/"+fileName);
    await file.writeAsBytes(response.bodyBytes);

    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('4CeeD Home'),
        backgroundColor: Colors.redAccent,
      ),
      
      body: new FutureBuilder(
                  future: getBodyWidget(),
                  builder: (BuildContext context, AsyncSnapshot <Widget> bodyWidget) {
                    if(!bodyWidget.hasData) {
                      return new Container(child: CircularProgressIndicator(), alignment: Alignment.center);
                    } else {
                      return bodyWidget.data;
                    }
                  }
    )
    );
  }
}
//'http://127.0.0.1:9000/api/files/5b55f39bb64accee5013988b'
//'http://127.0.0.1:9000/api/previews/5b6882862f6c802673f902ee',