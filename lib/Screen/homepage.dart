import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Screen/login.dart';
import 'package:to_do_app/Screen/profile.dart';
import 'package:to_do_app/Screen/timer.dart';
import 'package:to_do_app/Widget/alltasks.dart';
import 'package:to_do_app/Widget/todotask.dart';
import '../utils/app_style.dart';
import '../Widget/bottombar.dart';

import 'add.dart';
import 'calnder.dart';
import '../firebase.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = []; // List to hold fetched tasks

  @override
  void initState() {
    super.initState();
    fetchData(); // Call method to fetch tasks when the widget is initialized
  }

  Future<void> fetchData() async {
    // Use Firebase or any other method to fetch tasks
    // For example, if using Firebase Firestore:
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('tasks').get();

    // Clear existing tasks before adding new ones
    setState(() {
      tasks.clear();
      tasks.addAll(snapshot.docs.map((doc) => Task.fromSnapshot(doc)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Container(
            height: size.height * 0.15,
            width: double.infinity,
            decoration: BoxDecoration(
              color: style.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
                Text(
                  'Welcome',
                  style: style.textStyleWhite,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Get.off(() => const Login());
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            DateFormat.MMMMEEEEd().format(DateTime.now()).toString(),
            style: style.textStyleBlack,
          ),
        ),
        // Pass the tasks list to the AllTasks widget
        AllTasks(tasks: tasks),
      ],
    );
  }
}

class Task {
  String title;
  String subtitle;
  String date;
  String priority;
  String notification;

  Task({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.priority,
    required this.notification,
  });

  // Factory method to create a Task object from a Firestore snapshot
  factory Task.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Task(
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      date: data['date'] ?? '',
      priority: data['priority'] ?? '',
      notification: data['notification'] ?? '',
    );
  }
}


Widget taskRow(String text, String text2, String type) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: style.textStyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
          child: Text(
            text2,
            style: style.headLine3,
          ),
        ),
      ),
    ],
  );
}
