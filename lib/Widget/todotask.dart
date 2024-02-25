import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Widget/rowtask.dart';
import 'package:to_do_app/firebase.dart';
import 'package:to_do_app/utils/app_style.dart';
import '../utils/app_style.dart';
import 'bottombar.dart';

class ToDoTask extends StatefulWidget {
  const ToDoTask({super.key});

  @override
  State<ToDoTask> createState() => _ToDoTaskState();
}

class _ToDoTaskState extends State<ToDoTask> {
  Map tasks = {};
  @override
  void initState() {
    super.initState();
    var taks = dataFirebase.getAllData();
    taks.then((value) {
      tasks = value.asMap();
    });
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color pro = Colors.grey;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        if (tasks[index]['propriety'] == 'High') {
          pro = Colors.redAccent;
        } else if (tasks[index]['propriety'] == 'Medium')
          pro = Colors.orange;
        else if (tasks[index]['propriety'] == 'Low') pro = Colors.greenAccent;
        return tasks.length == 0
            ? Text(
                'No tasks has been added yet, please add a new task',
                style: style.textStyleBlack,
              )
            : InkWell(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                      ),
                      title: Center(
                        child: Text(
                          tasks[index]['title'],
                          style: style.textStyleBlack,
                        ),
                      ),
                      content: SizedBox(
                        height: size.height * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(tasks[index]['subtitle'],
                                  style: style.headLinelgray),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(tasks[index]['date'],
                                  style: style.headLinelgray),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: pro,
                              ),
                              child: Text(tasks[index]['propriety']),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  borderOnForeground: false,
                  child: SizedBox(
                    width: size.width * 0.2,
                    height: size.height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              tasks[index]['title'],
                              style: style.textStyle,
                            ),
                            Container(
                              width: size.width * 0.25,
                              child: Text(
                                tasks[index]['subtitle'],
                                style: style.headLine3,
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Text(tasks[index]['propriety']),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: pro,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                //pop up
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: 'Delete task',
                                  desc:
                                      'Are you sure that you want to delete ${tasks[index]['title']} task?',
                                  btnCancelColor: Colors.grey,
                                  btnOkColor: Colors.redAccent,
                                  btnOkText: 'Delete',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () async {
                                    var documentID;
                                    //delete task
                                    CollectionReference Firebasetask =
                                        await FirebaseFirestore.instance
                                            .collection('task');
                                    var querySnapshots =
                                        await Firebasetask.get();
                                    for (var snapshot in querySnapshots.docs) {
                                      documentID = snapshot.id;
                                    }

                                    Firebasetask.doc(documentID).delete().then(
                                        (value) =>
                                            print('task has been deleted'));
                                    Get.off(() => const BottomBar());
                                  },
                                ).show();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 122, 122, 122),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 122, 122, 122),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
