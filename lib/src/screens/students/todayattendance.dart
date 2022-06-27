import 'package:flutter/material.dart';
import 'package:virtual_edu/src/screens/students/attendancecard.dart';

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
            endtime: "10:00 AM",
            staff: "Alex",
            starttime: "9:00 AM",
            subject: "Operating System",
          ),
          AttendanceCard(
            attendance: false,
            endtime: "11:00 PM",
            staff: "Alex",
            starttime: "10:00 AM",
            subject: "Artificial Intelligence",
          ),
          AttendanceCard(
            attendance: false,
            endtime: "12:00 PM",
            staff: "Alex",
            starttime: "11:00 AM",
            subject: "Data Structure",
          ),
          AttendanceCard(
            attendance: false,
            endtime: "1:30 PM",
            staff: "Alex",
            starttime: "12:30 PM",
            subject: "DBMS",
          ),
          AttendanceCard(
            attendance: true,
            endtime: "2:30 PM",
            staff: "Alex",
            starttime: "1:30 PM",
            subject: "Machine Learning",
          ),
          AttendanceCard(
            attendance: true,
            endtime: "3:30 PM",
            staff: "Alex",
            starttime: "2:30 PM",
            subject: "Software Engineering",
          ),
        ],
      ),
    );
  }
}
