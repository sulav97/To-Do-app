import 'package:flutter/material.dart';
import '../utils/app_style.dart';

class ProfileManagement extends StatefulWidget {
  const ProfileManagement({super.key});

  @override
  State<ProfileManagement> createState() => _ProfileManagementState();
}

class _ProfileManagementState extends State<ProfileManagement> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
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
              'Settings',
              style: style.textStyleWhite,
            ),
          ),
        ),
      ],
    );
  }
}
