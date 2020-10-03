import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:internshift/constants.dart';
import 'package:internshift/widgets.dart';

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List saved = [
    1, 2, 3
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text('Saved', style: titleTextStyle()),
      ),
      
                    Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 15, right: 15),
          child: Center(
            child: Container(
              child: ListView.builder(  
                  
                  itemCount: saved.length,
                  itemBuilder: (context, i) {
                      return SavedScreenCard(
                  nameofJob: "Software Engineering",
                    employer: "Google LLC",
                    location: "Austin, TX",
                    logo: "https://cdn.icon-icons.com/icons2/2119/PNG/512/google_icon_131222.png",
                );
                    },
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 1/1.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(0, 4),
                  color: Colors.grey[300]),]
                ),
              ),
          ),
        ),
      
       
      
          ],
        ),
    );
  }
}