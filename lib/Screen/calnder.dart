import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../utils/app_style.dart';
import '../firebase.dart';

class Calander extends StatefulWidget {
  const Calander({super.key});

  @override
  State<Calander> createState() => _CalanderState();
}

class _CalanderState extends State<Calander> {
  Map tasks = {};
  List<Meeting> meetings = <Meeting>[];
  @override
  void initState() {
    super.initState();
    var taks = dataFirebase.getAllData();
    taks.then((value) {
      tasks = value.asMap();
    });
  }

  List<Meeting> _getDataSource() {
    List<Meeting> meetings = [];
    DateTime today = DateTime.now();
    DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    DateTime endTime = startTime.add(const Duration(hours: 2));

    meetings.add(Meeting('Conference', startTime, endTime, Colors.redAccent, false));
    meetings.add(Meeting('Conference2', startTime, endTime, Colors.greenAccent, false));
    meetings.add(Meeting('Conference2', startTime, endTime, Colors.orange, false));

    if (tasks != null) {
      tasks.forEach((key, value) {
        print(value['title']);
        Color temp;
        if (value['propriety'] == 'High')
          temp = Colors.redAccent;
        else if (value['propriety'] == 'Medium')
          temp = Colors.orange;
        else
          temp = Colors.greenAccent;
        meetings.add(Meeting(value['title'], startTime, endTime, temp, false));
      });
    }

    return meetings;
  }


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
              'Calendar',
              style: style.textStyleWhite,
            ),
          ),
        ),
        Expanded(
          child: SfCalendar(
            view: CalendarView.month,

            monthViewSettings: MonthViewSettings(showAgenda: true),
            //bring data from firebase as a list
            dataSource: MeetingDataSource(_getDataSource()),
          ),
        ),
      ],
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
