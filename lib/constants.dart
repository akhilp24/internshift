import 'package:flutter/material.dart';

class ColorPalette {
  Color bcgColor = Colors.green;
  Color appBarColor = Colors.green;
  Color themeColor = Color(0xff06745A);
  Color bottomNavigationBarColor = Color(0xffC6EFDB);
}



TextStyle titleTextStyle() {
  return TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff06745A));
}

TextStyle simpleTextFieldStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 16
  );
}

TextStyle mediumTextFieldStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 17
  );
}

InputDecoration textFieldInputDecoration(String hint) {
  return InputDecoration(
  hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                )
              );
}
