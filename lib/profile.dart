import 'package:homework/genderList.dart';

class Profile {
  String name;
  String email;
  String address;
  String avatarUrl;
  String github;
  GenderList genderList;
  bool iAmAdult;

  Profile(this.name, this.email, this.address, this.avatarUrl, this.genderList,
      this.github, this.iAmAdult);
}
