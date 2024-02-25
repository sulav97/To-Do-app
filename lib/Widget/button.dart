// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  final String text;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            const Size.fromWidth(double.infinity),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(10),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: () {
          //check firebase then go to homepage, or register
          ontap;
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
