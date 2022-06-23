// ignore_for_file: unnecessary_string_interpolations

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_edu/src/screens/faculty/AttendanceModel.dart';
import 'package:virtual_edu/src/screens/faculty/fhomedrawer.dart';
import 'package:virtual_edu/src/screens/roledropdown.dart';
import 'package:virtual_edu/src/styles/app_colors.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarkAttendance extends StatefulWidget {
  final String subject;
  final String lecDate;
  final String stream;
  final String year;
  final String div;

  const MarkAttendance({
    required this.subject,
    required this.lecDate,
    required this.stream,
    required this.year,
    required this.div,
  });

  @override
  _MarkAttendanceState createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double _scaleFactor = 1.0;
  var animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  var animationController;
  DateTime? selectedDay;
  List<CleanCalendarEvent>? selectedEvent;
  late List<AttendanceModel> atd;
  List<AttendanceModel> selectedStudents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<AttendanceModel> attendance = [
      AttendanceModel("Abc", "4001", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("Xyz", "4002", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("Pqr", "4003", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("Stu", "4004", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("Vwx", "4005", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("Dbe", "4006", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("fgh", "4007", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("Abc", "4008", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("Xyz", "4009", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("Pqr", "4010", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("Stu", "4011", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("Vwx", "4012", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("Dbe", "4013", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
      AttendanceModel("fgh", "4014", "${widget.subject}", "${widget.year}",
          "${widget.lecDate}", "${widget.stream}", "${widget.div}", false),
    ];

    atd = attendance;
    print(atd.length);
    print(atd);
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 0.5, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 0.5, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("role");
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => RoleDropdown(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    animationController.forward();

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, _) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              drawer: FHomeDrawer(),
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColor.primary, AppColor.primaryLight])),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Transform(
                                transform: Matrix4.translationValues(
                                    animation.value * width, 0, 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: BouncingWidget(
                                      scaleFactor: _scaleFactor,
                                      child: Icon(Icons.menu_outlined,
                                          size: 30, color: Colors.white),
                                      onPressed: () {
                                        _scaffoldKey.currentState!.openDrawer();
                                      }),
                                ),
                              ),
                              Row(
                                children: [
                                  Transform(
                                    transform: Matrix4.translationValues(
                                        animation.value * width, 0, 0),
                                    child: Container(
                                      child: Icon(
                                        Icons.school_rounded,
                                        color: Colors.redAccent,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                  Transform(
                                    transform: Matrix4.translationValues(
                                        animation.value * width, 0, 0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "E-Attendance",
                                        style: GoogleFonts.pacifico(
                                            //fontStyle: FontStyle.italic,
                                            color: Colors.white,
                                            fontSize: 28),
                                        // style: AppTextStyle.style(
                                        //     fontsize: 22,
                                        //     fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Transform(
                                transform: Matrix4.translationValues(
                                    animation.value * width, 0, 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: GestureDetector(
                                    onTap: removeValues,
                                    child: Icon(Icons.logout,
                                        size: 30, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(38),
                            topLeft: Radius.circular(38),
                          ),
                        ),
                        child: atd.isEmpty
                            ? CircularProgressIndicator()
                            : ListView.builder(
                                itemCount: atd.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // return item
                                  return AttendanceItem(
                                    atd[index].name,
                                    atd[index].roleNumber,
                                    atd[index].lecDate,
                                    atd[index].year,
                                    atd[index].stream,
                                    atd[index].subject,
                                    atd[index].div,
                                    atd[index].isSelected,
                                    index,
                                  );
                                }),
                      ),
                    ),
                    selectedStudents.length > 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 10,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                color: AppColor.primary,
                                child: Text(
                                  "Submit (${selectedStudents.length})",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  print(
                                      "Submit List Lenght: ${selectedStudents.length}");
                                },
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget AttendanceItem(
      String name,
      String roleNumber,
      String lecDate,
      String subject,
      String div,
      String stream,
      String year,
      bool isSelected,
      int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green[700],
        child: Icon(
          Icons.person_outline_outlined,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(roleNumber),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Colors.green[700],
            )
          : Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          atd[index].isSelected = !atd[index].isSelected;
          if (atd[index].isSelected == true) {
            selectedStudents.add(AttendanceModel(name, roleNumber, lecDate,
                subject, div, stream, year, isSelected));
          } else if (atd[index].isSelected == false) {
            selectedStudents
                .removeWhere((element) => element.name == atd[index].name);
          }
        });
      },
    );
  }
}