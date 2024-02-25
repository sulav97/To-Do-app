import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/utils/app_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../Widget/bottombar.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final _formKey = GlobalKey<FormState>();

  //title, subtitle, due date, proirity, notfication before due date,
  final _title = TextEditingController();
  final _subtitle = TextEditingController();
  final _date = TextEditingController();
  String? _propriety;

  String Selected = 'At the same day';
  List<String> notification = [
    'At the same day',
    'A day before ',
    'Two days before',
  ];
  //default value
  final String status = 'New';

  late DatabaseReference dbref;
  @override
  void dispose() {
    _title.dispose();
    _subtitle.dispose();
    _date.dispose();
    //childe is name of database
    dbref = FirebaseDatabase.instance.ref().child('Tasks');
    super.dispose();
  }

  CollectionReference task = FirebaseFirestore.instance.collection('task');

  Future<void> addtask(String title, String subtitle, String date, String not,
      String propriety) {
    // Calling the collection to add a new user
    return task
        //adding to firebase collection
        .add({
      //Data added in the form of a dictionary into the document.
      'title': title,
      'subtitle': subtitle,
      'date': date,
      'propriety': propriety,
      'not': not
    }).then((value) {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        body: const Center(
          child: Text(
            'Task has been added successfully. ',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        btnOkOnPress: () {
          Get.off(() => const BottomBar());
        },
      ).show();
    }).catchError((error) {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.error,
        body: const Center(
          child: Text(
            'Something went wrong, please try agin',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        btnOkOnPress: () {},
      ).show();
    });
  }

  bool submit = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.18,
              width: double.infinity,
              decoration: BoxDecoration(
                color: style.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'Add new Task',
                  style: style.textStyleWhite,
                ),
              ),
            ),
            textForm('Title', _title),
            textForm('Subtitle', _subtitle),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _date,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Select a due date';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Select due date'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    _date.text = formattedDate;
                  }
                },
              ),
            ),
            DropdownButton(
              value: Selected,
              hint: const Text(
                'Send a reminder',
              ),
              items: notification.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  Selected = value!;
                });
              },
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Propriety',
                    style: style.headLinelgray,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    propriety('High', Colors.redAccent),
                    propriety('Medium', Colors.orange),
                    propriety('Low', Colors.greenAccent),
                  ],
                ),
              ],
            ),

            //save
            Container(
              height: 90,
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_propriety == '' || _propriety == null)
                      _propriety = 'Low';
                    //save data in firebase
                    await addtask(_title.text, _subtitle.text, _date.text,
                        Selected, _propriety!);
                  }
                },
                child: const Text(
                  'Add new task',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget propriety(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                _propriety == text ? color : Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )),
        onPressed: () {
          setState(() {
            _propriety = text;
          });
        },
        child: Text(
          text,
          style:
              TextStyle(color: _propriety == text ? Colors.white : style.green),
        ),
      ),
    );
  }
}

Widget textForm(String type, TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.only(top: 5.0),
    padding: const EdgeInsets.all(20.0),
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a ${type}';
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(type),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    ),
  );
}
