import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  final String image;
  final String firstName;
  final String lastName;
  final String email;
  final String school;
  final String userName;
  final String password;
  SettingsPage(
      {this.image,
      this.firstName,
      this.lastName,
      this.email,
      this.userName,
      this.password,
      this.school});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent
      ),
      body: Container(),
    );
  }
}

class OtherWidget extends StatefulWidget {
  @override
  _OtherWidgetState createState() => _OtherWidgetState();
}

class _OtherWidgetState extends State<OtherWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
