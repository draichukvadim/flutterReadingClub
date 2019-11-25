import 'package:flutter/material.dart';
import 'package:homework/editScreen.dart';
import 'package:homework/genderList.dart';
import 'package:homework/profile.dart';
import 'package:homework/skillsList.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
            appBar: AppBar(title: Text("Profile")), body: ProfileWidget()));
  }
}

class ProfileWidget extends StatefulWidget {
  @override
  State createState() => ProfileState(Profile(
      "Vadim",
      "Vadimdraichuk@gmail.com",
      "Tamriel",
      "https://avatars2.githubusercontent.com/u/33314734?s=460&v=4",
      GenderList.male,
      "https://github.com/draichukvadim",
      true));
}

class ProfileState extends State<ProfileWidget> {
  Profile _profile;

  ProfileState(this._profile);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Edit"),
            onPressed: () async {
              Profile push = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditScreen(_profile)));
              setState(() {
                _profile = push;
              });
            },
          ),
          Text("Name: " + _profile.name),
          Text("Email: " + _profile.email),
          Text("Address: " + _profile.address),
          Text("Gender: " + getGender(_profile.genderList)),
          FlatButton(
              onPressed: () async {
                if (await canLaunch(_profile.github)) {
                  await launch(_profile.github);
                } else {
                  throw 'Could not launch ' + _profile.github;
                }
              },
              child: new Text("Link to Github: " + _profile.github)),
          Image.network(this._profile.avatarUrl),
          Text("Skills:"),
          Divider(),
          SkillsList(["Вышиваю", "Бухаю", "Танцую", "Пеку блинцы", "Сплю"])
        ],
      ),
    );
  }

  String getGender(GenderList gender) {
    return gender == GenderList.male ? "Male" : "Female";
  }
}
