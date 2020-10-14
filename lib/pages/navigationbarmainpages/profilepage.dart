import 'package:flutter/material.dart';

import '../../constants.dart';

class SettingsPage extends StatefulWidget {
  final String image;
  final String firstName;
  final String lastName;
  final String email;
  final String school;
  final String userName;
  final String password;
  SettingsPage({this.image, this.firstName, this.lastName, this.email, this.userName, this.password, this.school});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController firstNameController = new TextEditingController();
  @override
  // ignore: override_on_non_overriding_member
  double maxWidth = 200;
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('Settings', style: titleTextStyle()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 25),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Image.network(widget.image, height: 100, width: 100,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black),
                  color: Colors.white
                ),
              ),
            ),
          ),
        ]
            
                
    ));
  }
}