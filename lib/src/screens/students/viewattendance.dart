import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_edu/Widgets/calender.dart';
import 'package:virtual_edu/src/screens/students/shomedrawer.dart';
import 'package:virtual_edu/src/screens/students/todayattendance.dart';
import 'package:virtual_edu/src/screens/students/allattendance.dart';
import 'package:virtual_edu/src/styles/app_colors.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class ViewAttendance extends StatefulWidget {
  const ViewAttendance({Key? key}) : super(key: key);

  @override
  _ViewAttendanceState createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double _scaleFactor = 1.0;
  var animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  var animationController;
  DateTime? selectedDay;
  List<CleanCalendarEvent>? selectedEvent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
              drawer: SHomeDrawer(),
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
                                        Icons.checklist_outlined,
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
                                  child: Icon(
                                    Icons.notifications,
                                    size: 30,
                                    color: Colors.yellow,
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
                      child: SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Center(
                                child: Text(
                                  "Attendance",
                                  style: GoogleFonts.lato(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                      fontSize: 28),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CalenderPage(),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              DefaultTabController(
                                length: 2, // length of tabs
                                initialIndex: 0,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Container(
                                        child: TabBar(
                                          labelColor: Colors.black,
                                          unselectedLabelColor: Colors.black26,
                                          indicatorColor: Colors.black,
                                          tabs: [
                                            Tab(text: 'Today'),
                                            Tab(text: 'Overall'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.68, //height of TabBarView
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: TabBarView(
                                        children: <Widget>[
                                          TodayAttendance(),
                                          OverallAttendance(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
