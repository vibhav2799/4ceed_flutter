import 'dart:async';
import 'dart:convert';
import 'package:open_file/open_file.dart';


import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import '../utils/user_info.dart';

class PreviewFile extends StatelessWidget {
  fetchPdf() async {
    
    http.Response response = await http.get('http://127.0.0.1:9000/api/files/5b520c6ab64a0258b2c3c556', headers: {
      "Authorization": auth,
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Methods": "*",
      "Content-Encoding": "gzip",
      "Access-Control-Allow-Origin": "*"
    });
    print(response.bodyBytes);
  }

//http://127.0.0.1:9000/api/files/5b4f9eeae84a34d772377758

  @override
  Widget build(BuildContext context) {
    fetchPdf();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('4CeeD Home'),
        backgroundColor: Colors.redAccent,
      ),
      body: Image.network('http://127.0.0.1:9000/api/previews/5b6882862f6c802673f902ee', 
      headers: {
      "Authorization": auth,
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Methods": "*",
      "Content-Encoding": "gzip",
      "Access-Control-Allow-Origin": "*",
      "Transfer-Encoding" : "chunked"
    }
    ) ,
    );
  }
}
//'http://127.0.0.1:9000/api/files/5b55f39bb64accee5013988b'
//'http://127.0.0.1:9000/api/previews/5b6882862f6c802673f902ee',