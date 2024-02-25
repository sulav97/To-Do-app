import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:to_do_app/Screen/homepage.dart';
import 'package:to_do_app/Screen/sellall.dart';
import 'package:to_do_app/Widget/rowtask.dart';
import '../utils/app_style.dart';
import 'ToDotask.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({super.key, required List<Task> tasks});

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Numbers of task 10',
            style: style.headLinelightgreen,
          ),
        ),
        const RowTask(
          text: 'Tasks To do',
          text2: 'See All',
          type: 'To do',
        ),
        SizedBox(
          height: size.height * 0.25,
          width: size.width,
          child: ToDoTask(),
        ),
        const SizedBox(
          height: 20,
        ),
        const RowTask(
            text: 'Tasks in progress', text2: 'See All', type: 'progress'),
        SizedBox(
          height: size.height * 0.25,
          width: size.width,
          child: const ToDoTask(),
        ),
      ],
    );
  }
}
