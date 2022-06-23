import 'package:flutter/material.dart';
import 'package:virtual_edu/Widgets/attendancecard.dart';

class TodayAttendance extends StatefulWidget {
  @override
  _TodayAttendanceState createState() => _TodayAttendanceState();
}

class _TodayAttendanceState extends State<TodayAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AttendanceCard(
            attendance: true,
            endtime: "10 AM",
            staff: "Alex",
            starttime: "9 AM",
            subject: "English",
          ),
          AttendanceCard(
            attendance: false,
            endtime: "10 AM",
            staff: "Alex",
            starttime: "9 AM",
            subject: "English",
          ),
        ],
      ),
    );
  }
}
