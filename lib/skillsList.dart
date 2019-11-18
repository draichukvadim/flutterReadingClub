import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SkillsList extends StatefulWidget {
  List<String> _skills;

  SkillsList(this._skills);

  @override
  State<StatefulWidget> createState() => SkillsState(this._skills);
}

class SkillsState extends State {
  List<String> _skills;

  SkillsState(this._skills);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 35.0,
          maxHeight: 200.0,
        ),
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: _skills.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) =>
                ListTile(title: Text(_skills[index]))));
  }
}
