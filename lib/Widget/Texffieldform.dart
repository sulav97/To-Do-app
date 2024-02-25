import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
  final Icon icons;
  final TextEditingController controller;
  MyTextFormField({
    required this.hintText,
    required this.validator,
    required this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
    required this.icons,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        keyboardType:
            isEmail == true ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: icons,
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
        ),
      ),
    );
  }
}
