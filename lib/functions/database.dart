import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await Firestore.instance.collection("users").where("username", isEqualTo: username).getDocuments();
  }

  getUserByUserEmail(String userEmail) async {
    return await Firestore.instance.collection("users").where("email", isEqualTo: userEmail).getDocuments();
  }

  Future <void> uploadUserInfo(userMap, String userName) async {
    return await Firestore.instance.collection("users").document(userName).setData(userMap);
  }

  getUserFirstName(String firstName) async {
    // ignore: await_only_futures
    return await Firestore.instance.collection("users").document().get();
  }

  
  
}