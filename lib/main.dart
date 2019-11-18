import 'package:flutter/material.dart';
import 'package:homework/skillsList.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
            appBar: AppBar(),
            body: ProfileWidget(
                "Vadim",
                "Vadimdraichuk@gmail.com",
                "Tamriel",
                "https://github.com/draichukvadim",
                "https://avatars2.githubusercontent.com/u/33314734?s=460&v=4")));
  }
}

class ProfileWidget extends StatelessWidget {
  String _name;
  String _email;
  String _address;
  String _github;
  String _avatarUrl;

  ProfileWidget(
      this._name, this._email, this._address, this._github, this._avatarUrl);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        children: <Widget>[
          Text("Name: $_name"),
          Text("Email: $_email"),
          Text("Address: $_address"),
          FlatButton(
              onPressed: () async {
                if (await canLaunch(_github)) {
                  await launch(_github);
                } else {
                  throw 'Could not launch $_github';
                }
              },
              child: new Text("Link to Github: $_github")),
          Image.network(this._avatarUrl),
          Text("Skills:"),
          Divider(),
          SkillsList(["Вышиваю","Бухаю","Танцую","Пеку блинцы","Сплю"])
        ],
      ),
    );
  }
}
