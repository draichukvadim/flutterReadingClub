import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homework/profile.dart';
import 'package:homework/profileRepository.dart';
import 'package:homework/screenId.dart';

import 'genderList.dart';

class EditScreen extends StatelessWidget {
  Function(int) onChanged;

  EditScreen(this.onChanged);

  @override
  Widget build(BuildContext context) {
    return ProfileForm(onChanged);
  }
}

class ProfileForm extends StatefulWidget {
  Profile _profile = ProfileRepository().profile;
  Function(int) onChanged;

  ProfileForm(this.onChanged);

  @override
  State<StatefulWidget> createState() => ProfileFormState(_profile, onChanged);
}

class ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  Function(int) onChanged;

  Profile _profile;

  ProfileFormState(this._profile, this.onChanged);

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: new Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                Text(
                  'Name',
                  style: TextStyle(fontSize: 20.0),
                ),
                TextFormField(
                    initialValue: _profile.name,
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter the Name!';
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        _profile.name = value;
                      });
                    }),
                SizedBox(height: 20.0),
                Text(
                  'Email',
                  style: TextStyle(fontSize: 20.0),
                ),
                TextFormField(
                    initialValue: _profile.email,
                    validator: (value) {
                      var validationResult = _validateEmail(value);
                      if (validationResult != null) {
                        return validationResult;
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        _profile.email = value;
                      });
                    }),
                SizedBox(height: 20.0),
                Text(
                  'Address',
                  style: TextStyle(fontSize: 20.0),
                ),
                TextFormField(
                    initialValue: _profile.address,
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter Address!';
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        _profile.address = value;
                      });
                    }),
                SizedBox(height: 20.0),
                Text(
                  'Gender',
                  style: TextStyle(fontSize: 20.0),
                ),
                RadioListTile(
                  title: const Text('Male'),
                  value: GenderList.male,
                  groupValue: _profile.genderList,
                  onChanged: (GenderList value) {
                    setState(() {
                      _profile.genderList = value;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Female'),
                  value: GenderList.female,
                  groupValue: _profile.genderList,
                  onChanged: (GenderList value) {
                    setState(() {
                      _profile.genderList = value;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                CheckboxListTile(
                    value: _profile.iAmAdult,
                    title: new Text("I am absolutelly ADULT"),
                    onChanged: (bool value) =>
                        setState(() => _profile.iAmAdult = value)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Color color = Colors.red;
                          String text;

                          if (_profile.genderList == null)
                            text =
                                'Please specify your gender(Yeeeap you ll need to select one of TWO)';
                          else if (_profile.iAmAdult == false)
                            text =
                                'You need to be adult to save profile! Its to dangerous for kids!';
                          else {
                            text = 'Well done!';
                            color = Colors.green;
                            ProfileRepository().profile = _profile;
                            onChanged(ScreenId.PROFILE);
                          }

                          Fluttertoast.showToast(
                              toastLength: Toast.LENGTH_SHORT,
                              msg: text,
                              textColor: Colors.white,
                              backgroundColor: color);
                        }
                      },
                      child: Text('Save'),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                    SizedBox(width: 20.0),
                    RaisedButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                            toastLength: Toast.LENGTH_SHORT,
                            msg: "Трусик!",
                            textColor: Colors.white,
                            backgroundColor: Colors.red);
                        onChanged(ScreenId.PROFILE);
                      },
                      child: Text('Cancel'),
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  ],
                )
              ],
            )));
  }

  String _validateEmail(String value) {
    if (value.isEmpty) return 'Please enter Email';

    String p =
        "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) return null;

    return 'Does it really look like email for you?';
  }
}
