import 'package:homework/genderList.dart';
import 'package:homework/profile.dart';

class ProfileRepository{
  Profile _profile = Profile(
      "Vadim",
      "Vadimdraichuk@gmail.com",
      "Tamriel",
      "https://avatars2.githubusercontent.com/u/33314734?s=460&v=4",
      GenderList.male,
      "https://github.com/draichukvadim",
      true);

  Profile get profile => _profile;

  set profile(Profile value) {
    _profile = value;
  }

  static final ProfileRepository _singleton = ProfileRepository._internal();

  factory ProfileRepository() {
    return _singleton;
  }

  ProfileRepository._internal();
}