import 'package:flutter/material.dart';

import '../constants.dart';

class TopRatedOffersPage extends StatefulWidget {
  @override
  _TopRatedOffersPageState createState() => _TopRatedOffersPageState();
}

class _TopRatedOffersPageState extends State<TopRatedOffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Rated Offers", style: TextStyle(color: ColorPalette().themeColor),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: ColorPalette().themeColor,)),
      ),
    );
  }
}