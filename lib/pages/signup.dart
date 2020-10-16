import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:internshift/constants.dart';
import 'package:internshift/functions/auth.dart';
import 'package:internshift/functions/database.dart';
import 'package:internshift/functions/functions.dart';
import 'package:internshift/functions/helperfunctions.dart';
import 'package:internshift/main.dart';
import 'package:internshift/pages/signin.dart';

class SignUpPage extends StatefulWidget {
  final Function toggle;
  SignUpPage({this.toggle});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  // DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTexteditingController =
      new TextEditingController();

  @override
  // ignore: unused_element
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.transparent),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 160,
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/InternShift.png',
                    height: 300,
                  ),
                  Form(
                    key: formKey,
                    child: Column(children: [
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty || val.length < 3
                              ? "Please provide a valid username"
                              : null;
                        },
                        controller: userNameTextEditingController,
                        style: simpleTextFieldStyle(),
                        decoration: textFieldInputDecoration("Username"),
                        autocorrect: false,
                      ),
                      TextFormField(
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)
                              ? null
                              : "Enter correct email";
                        },
                        controller: emailTextEditingController,
                        style: simpleTextFieldStyle(),
                        decoration: textFieldInputDecoration("Email"),
                        autocorrect: false,
                      ),
                      TextFormField(
                          obscureText: true,
                          validator: (val) {
                            return val.length > 6
                                ? null
                                : "Please provide a password with 6+ characters";
                          },
                          controller: passwordTexteditingController,
                          style: simpleTextFieldStyle(),
                          autocorrect: false,
                          decoration: textFieldInputDecoration("Password")),
                    ]),
                  ),
                  SizedBox(height: 8),
                  // Container(
                  //   alignment: Alignment.centerRight,
                  //     child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //     child: Text(
                  //       "Forgot Password?",
                  //       style: simpleTextFieldStyle()
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 22),
                  GestureDetector(
                    onTap: () {
                      if ((emailTextEditingController.text != null) &&
                          (passwordTexteditingController.text != null) &&
                          (userNameTextEditingController.text != null) &&
                          (formKey.currentState.validate())) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoreInfoSignUpPage(
                                      email: emailTextEditingController.text,
                                      password:
                                          passwordTexteditingController.text,
                                      username:
                                          userNameTextEditingController.text,
                                      formKey: formKey,
                                    )));
                      }
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              color: Color(0xff5FBA94),
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ),
                  // SizedBox(height: 16,),

                  // MouseRegion(
                  //   cursor: SystemMouseCursors.click,
                  //                   child: SignInButtonBuilder(
                  //                     image: Image.network('https://cdn.icon-icons.com/icons2/2119/PNG/512/google_icon_131222.png', height: 18, width: 18,),
                  //                     textColor: Colors.grey[600],
                  //                     text: "Sign Up with Google",
                  //                     icon: Icons.email,
                  //                     onPressed: () {

                  //                     },
                  //                     backgroundColor: Colors.white,
                  //                   )
                  // ),
                  // SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",
                              style: mediumTextFieldStyle()),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, a1, a2) => SignInPage()),
                              );
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  "Sign In Now",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                  SizedBox(height: 50)
                ],
              )),
        ),
      ),
    );
  }
}

class MoreInfoSignUpPage extends StatefulWidget {
  final String email;
  final String username;
  final String password;
  final GlobalKey formKey;
  MoreInfoSignUpPage({this.email, this.username, this.password, this.formKey});
  @override
  _MoreInfoSignUpPageState createState() => _MoreInfoSignUpPageState();
}

class _MoreInfoSignUpPageState extends State<MoreInfoSignUpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameTextEditingController =
      new TextEditingController();
  TextEditingController lastNameTextEditingController =
      new TextEditingController();
  TextEditingController ageTextEditingController = new TextEditingController();
  TextEditingController schoolTextEditingController =
      new TextEditingController();
  TextEditingController locationTextEditingController =
      new TextEditingController();
  bool isLoading = false;
  int age;
  String user;
  signMeUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
        
      });

      await AuthMethods()
          .signUpWithEmailAndPassword(widget.email, widget.password)
          .then((val) {
        if (val != null) {
          Map<String, String> userInfoMap = {
            "username": widget.username,
            "firstName": firstNameTextEditingController.text,
            "lastName": lastNameTextEditingController.text,
            "email": widget.email,
            "school": schoolTextEditingController.text,
            "age": age.toString()
          };
          setState(() {
            user = widget.username;
          });
          
          DatabaseMethods().uploadUserInfo(userInfoMap, widget.username);
          HelperFunctions.saveUserEmailSharedPreference(widget.email);
          HelperFunctions.saveUserNameSharedPreference(widget.username);
          HelperFunctions.saveUserLoggedInSharedPreference(true);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPage(
                        userName: user
                      )));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 150,
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/InternShift.png'),
                        Form(
                          key: formKey,
                          child: Column(children: [
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty || val.length < 3
                                    ? "Please provide a valid name"
                                    : null;
                              },
                              controller: firstNameTextEditingController,
                              style: simpleTextFieldStyle(),
                              decoration:
                                  textFieldInputDecoration("First Name"),
                              autocorrect: false,
                            ),
                            TextFormField(
                              validator: (val) {
                                return val.length > 1
                                    ? null
                                    : "Please provide a last name with more than one letter";
                              },
                              controller: lastNameTextEditingController,
                              style: simpleTextFieldStyle(),
                              decoration: textFieldInputDecoration("Last Name"),
                              autocorrect: false,
                            ),
                            TextFormField(
                                obscureText: false,
                                validator: (val) {
                                  return val.length > 1
                                      ? null
                                      : "Please provide a valid school name.";
                                },
                                controller: schoolTextEditingController,
                                style: simpleTextFieldStyle(),
                                autocorrect: false,
                                decoration: textFieldInputDecoration("School")),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: RaisedButton(
                                  color: Color(0xff5FBA94),
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(1998, 1, 1),
                                        maxTime: DateTime(2007, 1, 1),
                                        onConfirm: (date) {
                                      print('confirm $date');
                                      age = calculateAge(date);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  },
                                  child: Text(
                                    'Enter your age',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ]),
                        ),
                        SizedBox(height: 8),
                        //
                        SizedBox(height: 32),
                        GestureDetector(
                          onTap: () {
                            signMeUp();
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    color: Color(0xff5FBA94),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        ),
                        SizedBox(height: 50)
                      ],
                    )),
              ),
            ),
    );
  }
}
