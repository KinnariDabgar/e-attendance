import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:virtual_edu/Widgets/homecard.dart';
import 'package:virtual_edu/src/screens/students/shomedrawer.dart';
import 'package:virtual_edu/src/screens/students/studentDetail.dart';
import 'package:virtual_edu/src/screens/students/viewattendance.dart';
import 'package:virtual_edu/src/styles/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../roledropdown.dart';

class StudentHomeScreen extends StatefulWidget {
  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen>
    with SingleTickerProviderStateMixin {
  double _scaleFactor = 1.0;
  var animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  var animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
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
    //var scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    animationController.forward();
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, _) {
          return SafeArea(
            child: Scaffold(
                //appBar: AppBar(),
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
                                // BouncingWidget(
                                //   scaleFactor: _scaleFactor,
                                //   onPressed: () {
                                //     _scaffoldKey.currentState!.openDrawer();
                                //   },
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(20.0),
                                //     child: Icon(
                                //       Icons.menu_outlined,
                                //       size: 30,
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // ),
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
                                          _scaffoldKey.currentState!
                                              .openDrawer();
                                        }),
                                  ),
                                ),
                                Row(
                                  children: [
                                    // Transform(
                                    //   transform: Matrix4.translationValues(
                                    //       animation.value * width, 0, 0),
                                    //   child: Container(
                                    //     child: Icon(
                                    //       Icons.checklist_outlined,
                                    //       color: Colors.redAccent,
                                    //       size: 36,
                                    //     ),
                                    //   ),
                                    // ),
                                    Transform(
                                      transform: Matrix4.translationValues(
                                          animation.value * width, 0, 0),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                        child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                StudentDetailCard(),
                                Center(
                                    child: Text("Student",
                                        style: TextStyle(fontSize: 30))),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(32, 16, 32, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Transform(
                                        transform: Matrix4.translationValues(
                                            delayedAnimation.value * width,
                                            0,
                                            0),
                                        child: BouncingWidget(
                                          scaleFactor: _scaleFactor,
                                          onPressed: () {},
                                          child: DashboardCard(
                                            name: "TimeTable",
                                            imgpath: "calendar.png",
                                          ),
                                        ),
                                      ),
                                      Transform(
                                        transform: Matrix4.translationValues(
                                            muchDelayedAnimation.value * width,
                                            0,
                                            0),
                                        child: BouncingWidget(
                                          scaleFactor: _scaleFactor,
                                          onPressed: () {
                                            Future.delayed(
                                                Duration(milliseconds: 500),
                                                () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ViewAttendance(),
                                                  ));
                                            });
                                          },
                                          child: DashboardCard(
                                            name: "View Attendance",
                                            imgpath: "attendance.png",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ))
                    ],
                  ),
                )),
          );
        });
  }
}
