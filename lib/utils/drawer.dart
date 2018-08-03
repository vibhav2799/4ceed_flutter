import 'package:flutter/material.dart';
import '../utils/user_info.dart';

class MyDrawer extends StatelessWidget {
  final String userImageUrl = 'https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg';

  @override
  Widget build(BuildContext context) {
    return new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountEmail: new Text(email),
                accountName: new Text(userName),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new NetworkImage(userImageUrl)
                  )
                )
              ),
              new ListTile(
                title: new Text("Home"),
                trailing: new Icon(Icons.grid_on),
                onTap: () => Navigator.of(context).pushNamed('/home')
              ),
              new ListTile(
                title: new Text("Spaces"),
                trailing: new Icon(Icons.home),
                onTap: () => Navigator.of(context).pushNamed('/specific-data-spaces')
              ),
              new ListTile(
                title: new Text("Collections"),
                trailing: new Icon(Icons.book),
                onTap: () => Navigator.of(context).pushNamed('/specific-data-collections')
              ),
              new ListTile(
                title: new Text("Datasets"),
                trailing: new Icon(Icons.folder),
                onTap: () => Navigator.of(context).pushNamed('/specific-data-datasets'),
              )
              ],
          )
        );
  }
}