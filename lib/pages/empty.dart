import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        color: Colors.grey[100],
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                Icons.error,
                size: 100.0,
                textDirection: TextDirection.ltr,
              ),
              new Padding(padding: EdgeInsets.only(top: 20.0)),
              new Text(
                  "Data Not Found", 
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 20.0)),
              new Padding(padding: EdgeInsets.only(top: 10.0)),
              new Text(
                "Consider creating a storage type or add files using the button on the bottom right",
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.normal, fontSize: 15.0)),
              
            ]));
  }
}
