import 'package:flutter/material.dart';
import 'package:to_do_app/utils/app_style.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: ((context, index) {
          return ListTile(
            title: Text(
              'Title',
              style: style.textStyle,
            ),
            subtitle: Text(
              'Subtitle',
              style: style.headLine3,
            ),
            leading: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.redAccent,
              ),
              child: const Text('Priority'),
            ),
          );
        }),
      ),
    );
  }
}
