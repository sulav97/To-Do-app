import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Screen/sellall.dart';
import '../utils/app_style.dart';

class RowTask extends StatelessWidget {
  const RowTask({
    super.key,
    required this.text,
    required this.text2,
    required this.type,
  });

  final String text;
  final String text2;
  final String type;
  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              //send type
              Get.to(() => const SeeAll());
            },
            child: Text(
              text2,
              style: style.headLine3,
            ),
          ),
        ),
      ],
    );
  }
}
