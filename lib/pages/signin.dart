import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:internshift/constants.dart';
import 'package:internshift/functions/auth.dart';
import 'package:internshift/functions/database.dart';
import 'package:internshift/functions/helperfunctions.dart';
import 'package:internshift/main.dart';
import 'package:internshift/pages/signup.dart';

class SignInPage extends StatefulWidget {
  final Function toggle;
  SignInPage({this.toggle});
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  double ifUserIsOnBigScreen() {
    if (MediaQuery.of(context).size.width >= 500) {
      return 500;
    } else {
      return MediaQuery.of(context).size.width;
    }
  }
  
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTexteditingController = new TextEditingController();
  bool isLoading = false;
  
  QuerySnapshot snapshotUserInfo;
  signIn() {
    if(formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      
  DatabaseMethods().getUserByUserEmail(emailTextEditingController.text).then((val) {
      snapshotUserInfo = val;
      HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.documents[0].data["username"]);
    });
      setState(() {
        isLoading = true;
      });
    


      AuthMethods().signInWithEmailAndPassword(emailTextEditingController.text, passwordTexteditingController.text).then((val) {
        if (val != null) {
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()
        ));
        }
      });

      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
    // title: Text("InternShift",),
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.transparent
    ),
    backgroundColor: Colors.transparent,
    ),
      body: SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                              child: Container(
                  height: MediaQuery.of(context).size.height - 150,
                  width: ifUserIsOnBigScreen(),
          alignment: Alignment.bottomCenter,
                  child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/InternShift.png'),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          autocorrect: false,
                          validator: (val) {
                            return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                            null : "Enter correct email"; 
                          },
                      controller: emailTextEditingController,
                      style: simpleTextFieldStyle(),
                      decoration: textFieldInputDecoration("email")
                    ),
                    TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      validator: (val) {
                        return val.length > 6 ? null: "Please provide a password with 6+ characters";
                      },
                      controller: passwordTexteditingController,
                      style: simpleTextFieldStyle(),
                      decoration: textFieldInputDecoration("password")
                    ),
                      ]
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                    print(MediaQuery.of(context).size.width);
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                        child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "Forgot Password?",
                          style: simpleTextFieldStyle()
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      signIn();
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                                          child: Container(
                        alignment: Alignment.center,
                        width: ifUserIsOnBigScreen(),
                        padding: EdgeInsets.symmetric(vertical: 20),
                        
                        decoration: BoxDecoration(
                          color: Color(0xff5FBA94),                       
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text("Sign In", style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600
                      ),)
                      ),
                    ),
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.all(30),
                                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
  context,
  PageRouteBuilder(pageBuilder: (_, a1, a2) => SignUpPage()),
);
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                                                    child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text("Sign Up Now", style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                decoration: TextDecoration.underline
                              ),),
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                  SizedBox(height: 40)
                ],
                )
          ),
        ),
              ),
      ),
    );
  }
}

