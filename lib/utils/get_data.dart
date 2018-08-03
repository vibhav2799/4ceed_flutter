import 'dart:async';
import 'package:http/http.dart' as http;

import 'dart:convert';

class GetData {

  String nodeType;
  String parentId;
  
  GetData(this.nodeType, this.parentId);

  Future<String> getData() async {
    String username = 'vibhavk2@illinois.edu';
    String password = 'Vibhav27\$';
    String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.get('http://127.0.0.1:9000/api/fulltree/getChildrenOfNode?nodeType='+nodeType+
      '&nodeId='+parentId,
    headers: {
      "Authorization": basicAuth,
      "Content-Type": "application/json",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Methods": "*",
      "Content-Encoding": "gzip",
      "Access-Control-Allow-Origin": "*"
    }
    );

    return response.body;
  }



}