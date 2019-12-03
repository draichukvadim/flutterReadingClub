import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homework/profile.dart';
import 'package:homework/profileRepository.dart';
import 'package:homework/skillsList.dart';
import 'package:url_launcher/url_launcher.dart';

import 'genderList.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State createState() => ProfileState(ProfileRepository().profile);
}

class ProfileState extends State<ProfileScreen> {
  Profile _profile;

  ProfileState(this._profile);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        children: <Widget>[
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
