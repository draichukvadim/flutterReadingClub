import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework/editScreen.dart';
import 'package:homework/profileScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new ProfileScreen();
      case 1:
        return new EditScreen();
      default:
        return _showLogoutDialog();
    }
  }

  _showLogoutDialog() {
    return new AlertDialog(
      title: Text('Leaving?'),
      actions: [
        FlatButton(
          onPressed: () {
            exit(0);
          },
          child: Text('Yes'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('No'),
        ),
      ],
    );
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    final drawerItems = [
      new DrawerItem("Profile Fragment", Icons.account_circle),
      new DrawerItem("Edit Fragment", Icons.edit),
      new DrawerItem("Logout", Icons.exit_to_app),
    ];

    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
        appBar: AppBar(title: Text("Luntik!")),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Text('Тут может быть ваша реклама'),
                    Image.network(
                        "https://in-scale.ru/wp-content/uploads/2018/02/ploxaya-reklama-primer-8.jpg")
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              new Column(children: drawerOptions),
            ],
          ),
        ));
  }
}

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}
