import 'package:flutter/material.dart';
import 'package:to_do_app/Screen/add.dart';
import 'package:to_do_app/Screen/calnder.dart';
import 'package:to_do_app/Screen/homepage.dart';
import 'package:to_do_app/Screen/profile.dart';
import 'package:to_do_app/Screen/timer.dart';
import 'package:to_do_app/utils/app_style.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List _pages = [
    HomePage(),
    const Calander(),
    const AddToDo(),
    const Timer(),
    const ProfileManagement(),
  ];
  int _pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //for not shown FloatingActionButton when keyboard is active
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: style.yellow,
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            _pageindex = 2;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _pages[_pageindex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon(const Icon(Icons.home), 0),
            icon(const Icon(Icons.calendar_month), 1),
            icon(const Icon(Icons.timer), 3),
            icon(const Icon(Icons.settings), 4),
          ],
        ),
      ),
    );
  }

  Widget icon(Icon icon, int page) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: IconButton(
        color: _pageindex == page
            ? style.green
            : const Color.fromARGB(255, 35, 134, 156),
        onPressed: () {
          setState(() {
            _pageindex = page;
          });
        },
        icon: icon,
      ),
    );
  }
}

//  bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_month),
//             label: 'Calendar',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_circle),
//             label: 'Add',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.timer),
//             label: 'Timer',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: _pageindex,
//         unselectedItemColor: Color.fromARGB(255, 35, 134, 156),
//         selectedItemColor: const Color(0xFF064F60),
//         onTap: (index) {
//           setState(() {
//             _pageindex = index;
//           });
//         },
//       ),
