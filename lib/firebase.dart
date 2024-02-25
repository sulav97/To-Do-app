import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dataFirebase {
  static RegisterUser(String email, String username) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      'email': email, // John Doe
      'username': username, // Stokes and Sons
    }).catchError((error) => print("Failed to add user: $error"));
  }

  static getTaks() {
    CollectionReference task = FirebaseFirestore.instance.collection('task');
  }

  static getuser() async {
    final prefs = await SharedPreferences.getInstance();

    FirebaseAuth auth = FirebaseAuth.instance;
    Stream _stateChange = auth.authStateChanges();
    _stateChange.listen((event) async {
      await prefs.setString('email', event.email);
      print(event);
    });
  }

  static Future<String?> getemail() async {
    final prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    return email;
  }

  static getusername() async {
    final prefs = await SharedPreferences.getInstance();
    final String? username = await prefs.getString('username');
    print(username);
    return username;
  }

  static Future<List> getAllData() async {
    List productModelList = [];

    var data = await FirebaseFirestore.instance.collection("task").get();
    final allData =
        data.docs.map((doc) => productModelList.add(doc.data())).toList();

    return productModelList;
  }
}
