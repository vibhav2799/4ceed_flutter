import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_info.dart';
import 'dart:convert';

class FormBuilder extends StatefulWidget {
  final String type;
  final String id;

  FormBuilder(this.type, this.id);

  @override
  FormBuilderState createState() {
    return FormBuilderState(type, id);
  }
}

class FormBuilderState extends State<FormBuilder> {
  final _formKey = GlobalKey<FormState>();
  var data, currentSpace, type, id;

  FormBuilderState(this.type, this.id);

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  // A method to return a list of spaces the user has
  getSpaces() async {
    http.Response response =
        await http.get(serverAddress + '/api/spaces', headers: {
      "Authorization": auth,
    });
    setState(() {
      data = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    getSpaces();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: new InputDecoration(
              labelText: "Name",
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Name cannot be empty';
              }
            },
          ),
          TextFormField(
            controller: descriptionController,
            decoration: new InputDecoration(labelText: "Description"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Description cannot be empty';
              }
            },
          ),
          (data == null || type == "space")
              ? new Text("")
              : new DropdownButton<String>(
                  hint: new Text("Share with Space"),
                  items: data.map<DropdownMenuItem<String>>((var dataItem) {
                    return new DropdownMenuItem<String>(
                      value: dataItem["name"],
                      child: new Text(dataItem["name"]),
                    );
                  }).toList(),
                  onChanged: (String dataStr) {
                    setState(() {
                      currentSpace = dataStr;
                    });
                  },
                  value: currentSpace),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: MaterialButton(
                  minWidth: 200.0,
                  height: 42.0,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (type == "space") {
                        print("form.dart, type is space, create new space");
                        createNewSpace();
                      } else if (type == "collection") {
                        print("form.dart, type is collection, create new collection");
                        print(id);
                        createNewCollection(id);
                      } else {
                        print("form.dart, type is dataset, create new dataset");
                        createNewDatasetInSpace(id);
                      }
                    }
                  },
                  color: Colors.red,
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            child: MaterialButton(
              minWidth: 150.0,
              height: 42.0,
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.blueGrey,
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Creates a new Space as the root (only possibility for spaces)
  createNewSpace() async {
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

  // Creates a new Collection as root/under a space (depends on whether the id parameter is passed)
  // param: spaceId (optional)
  createNewCollection(spaceId) async {
    var jsonData = {
      "name": nameController.text,
      "description": descriptionController.text
    };
    if (spaceId.length > 0) {
      jsonData = {
        "name": nameController.text,
        "description": descriptionController.text,
        "space": spaceId
      };
    }
    http.Response response = await http.post(serverAddress + "/api/collections",
        body: json.encode(jsonData),
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/home');
    }
    print(response.body);
  }

  // Creates a new Collection under a collection
  // param: collId (required)
  createNewChildCollection(collId) async {
    http.Response response = await http.post(
        serverAddress + "/api/collections/newCollectionWithParent",
        body: json.encode({
          "name": nameController.text,
          "description": descriptionController.text
        }),
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/home');
    }
    print(response.body);
  }

  // Creates a new dataset under a space/collection/root
  // param : spaceId (optional), collId (optional)
  createNewDatasetOnly() async {

    var jsonData;


    jsonData = json.encode({
      "name": nameController.text,
      "description": descriptionController.text
    });

    http.Response response = await http.post(
        serverAddress + "/api/datasets/createempty",
        body: jsonData,
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json",
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/home');
    }
    print(response.body);
  }

  // Creates a new dataset under a space/collection/root
  // param : spaceId (optional), collId (optional)
  createNewDataset(spaceId, collId) async {
    List<String> spaceList = new List(), collList = new List();
    spaceList.add(spaceId);
    collList.add(collId);
    var jsonData;

    if (spaceId.length > 0) {
      jsonData = json.encode({
        "name": nameController.text,
        "description": descriptionController.text,
        "space": spaceList
      });
    } else if (collId.length > 0) {
      jsonData = json.encode({
        "name": nameController.text,
        "description": descriptionController.text,
        "collection": collList
      });
    } else {
      jsonData = json.encode({
      "name": nameController.text,
      "description": descriptionController.text
      });
    
    }
    print("COLL ID: "+collId);

    http.Response response = await http.post(
        serverAddress + "/api/datasets/createempty",
        body: jsonData,
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json",
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/home');
    }
    print(response.body);
  }

  // Creates a new dataset under a space/collection/root
  // param : spaceId (optional), collId (optional)
  createNewDatasetInSpace(spaceId) async {
    List<String> spaceList = new List();
    spaceList.add(spaceId);
    var jsonData;

    if (spaceId.length > 0) {
      jsonData = json.encode({
        "name": nameController.text,
        "description": descriptionController.text,
        "space": spaceList
      });
    } else {
      jsonData = json.encode({
        "name": nameController.text,
        "description": descriptionController.text
      });

    }
    print("SPACE ID: "+ spaceId);

    http.Response response = await http.post(
        serverAddress + "/api/datasets/createempty",
        body: jsonData,
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json",
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/home');
    }
    print(response.body);
  }

  // Creates a new dataset under a space/collection/root
  // param : spaceId (optional), collId (optional)
  createNewDatasetInCollection(collId) async {
    List<String>  collList = new List();
    collList.add(collId);
    var jsonData;

   if (collId.length > 0) {
      jsonData = json.encode({
        "name": nameController.text,
        "description": descriptionController.text,
        "collection": collList
      });
    } else {
      jsonData = json.encode({
        "name": nameController.text,
        "description": descriptionController.text
      });

    }
    print("COLL ID: "+collId);

    http.Response response = await http.post(
        serverAddress + "/api/datasets/createempty",
        body: jsonData,
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json",
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/home');
    }
    print(response.body);
  }
}
