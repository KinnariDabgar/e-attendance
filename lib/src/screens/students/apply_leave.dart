import 'dart:io';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtual_edu/Widgets/button.dart';
import 'package:virtual_edu/Widgets/homecard.dart';
import 'package:virtual_edu/src/screens/students/shomedrawer.dart';
import 'package:virtual_edu/src/screens/students/studentDetail.dart';
import 'package:virtual_edu/src/styles/app_colors.dart';
import 'package:virtual_edu/src/styles/app_textstyle.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplyLeave extends StatefulWidget {
  @override
  _ApplyLeaveState createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave>
    with SingleTickerProviderStateMixin {
  double _scaleFactor = 1.0;
  var animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  var animationController;
  var _applyleavecontroller;
  final searchFieldController = TextEditingController();

  String _applyleavevalueChanged = '';
  String _applyleavevalueToValidate = '';
  String _applyleavevalueSaved = '';

  var _fromcontroller;
  String _fromvalueChanged = '';
  String _fromvalueToValidate = '';
  String _fromvalueSaved = '';

  var _tocontroller;
  String _tovalueChanged = '';
  String _tovalueToValidate = '';
  String _tovalueSaved = '';

  var fileName;
  var path;
  Map<String, String>? paths;
  List<String>? extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  var fileType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);
    _applyleavecontroller =
        TextEditingController(text: DateTime.now().toString());
    _fromcontroller = TextEditingController(text: DateTime.now().toString());
    _tocontroller = TextEditingController(text: DateTime.now().toString());

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

  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

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
                        child: Form(
                          key: _formkey,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Center(
                                    child: Text(
                                      "Apply_Leave",
                                      style: GoogleFonts.lato(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black,
                                          fontSize: 28),
                                    ),
                                  ),

                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Transform(
                                    transform: Matrix4.translationValues(
                                        muchDelayedAnimation.value * width,
                                        0,
                                        0),
                                    child: Text(
                                      "Apply Leave Date",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 13,
                                    ),
                                    child: Container(
                                      // height: height * 0.06,
                                      padding: EdgeInsets.only(
                                        left: 10,
                                      ),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Transform(
                                            transform:
                                                Matrix4.translationValues(
                                                    muchDelayedAnimation.value *
                                                        width,
                                                    0,
                                                    0),
                                            child: Container(
                                              width: width * 0.75,
                                              child: DateTimePicker(
                                                type: DateTimePickerType.date,
                                                dateMask: 'dd/MM/yyyy',
                                                controller:
                                                    _applyleavecontroller,
                                                //initialValue: _initialValue,
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2100),
                                                calendarTitle: "Leave Date",
                                                confirmText: "Confirm",
                                                enableSuggestions: true,
                                                //locale: Locale('en', 'US'),
                                                onChanged: (val) => setState(
                                                    () =>
                                                        _applyleavevalueChanged =
                                                            val),
                                                validator: (val) {
                                                  setState(() =>
                                                      _applyleavevalueToValidate =
                                                          val.toString());
                                                  return null;
                                                },
                                                onSaved: (val) => setState(() =>
                                                    _applyleavevalueSaved =
                                                        val.toString()),
                                              ),
                                            ),
                                          ),
                                          Transform(
                                            transform:
                                                Matrix4.translationValues(
                                                    delayedAnimation.value *
                                                        width,
                                                    0,
                                                    0),
                                            child: Icon(
                                              Icons.calendar_today,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  Transform(
                                    transform: Matrix4.translationValues(
                                        muchDelayedAnimation.value * width,
                                        0,
                                        0),
                                    child: Text(
                                      "Choose Leave Type",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Transform(
                                    transform: Matrix4.translationValues(
                                        delayedAnimation.value * width, 0, 0),
                                    child: DropdownSearch<String>(
                                      validator: (v) =>
                                          v == null ? "required field" : null,
                                      // hint: "Please Select Leave type",
                                      mode: Mode.MENU,
                                      // showSelectedItem: true,
                                      items: [
                                        "Medical",
                                        "Family",
                                        "Sick",
                                        'Function',
                                        'Others'
                                      ],
                                      showClearButton: true,
                                      onChanged: print,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Transform(
                                    transform: Matrix4.translationValues(
                                        muchDelayedAnimation.value * width,
                                        0,
                                        0),
                                    child: Text(
                                      "Leave Date",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Transform(
                                        transform: Matrix4.translationValues(
                                            delayedAnimation.value * width,
                                            0,
                                            0),
                                        child: Container(
                                          width: width / 3,
                                          child: DateTimePicker(
                                            type: DateTimePickerType.date,
                                            dateMask: 'dd/MM/yyyy',
                                            controller: _fromcontroller,
                                            //initialValue: _initialValue,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                            calendarTitle: "Leave From",
                                            confirmText: "Confirm",
                                            enableSuggestions: true,
                                            //locale: Locale('en', 'US'),
                                            onChanged: (val) => setState(
                                                () => _fromvalueChanged = val),
                                            validator: (val) {
                                              setState(() =>
                                                  _fromvalueToValidate =
                                                      val.toString());
                                              return null;
                                            },
                                            onSaved: (val) => setState(() =>
                                                _fromvalueSaved =
                                                    val.toString()),
                                          ),
                                        ),
                                      ),
                                      Transform(
                                          transform: Matrix4.translationValues(
                                              animation.value * width, 0, 0),
                                          child: Icon(
                                            Icons.arrow_right_alt,
                                            size: 40,
                                            color: AppColor.darkText,
                                          )),
                                      Transform(
                                        transform: Matrix4.translationValues(
                                            muchDelayedAnimation.value * width,
                                            0,
                                            0),
                                        child: Container(
                                          width: width / 3,
                                          child: DateTimePicker(
                                            type: DateTimePickerType.date,
                                            dateMask: 'dd/MM/yyyy',
                                            controller: _tocontroller,
                                            //initialValue: _initialValue,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                            calendarTitle: "Leave Date",
                                            confirmText: "Confirm",
                                            enableSuggestions: true,
                                            //locale: Locale('en', 'US'),
                                            onChanged: (val) => setState(
                                                () => _tovalueChanged = val),
                                            validator: (val) {
                                              setState(() =>
                                                  _tovalueToValidate =
                                                      val.toString());
                                              return null;
                                            },
                                            onSaved: (val) => setState(() =>
                                                _tovalueSaved = val.toString()),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: height * 0.05,
                                  ),

                                  Center(
                                    child: Transform(
                                      transform: Matrix4.translationValues(
                                          muchDelayedAnimation.value * width,
                                          0,
                                          0),
                                      child: Text(
                                        "Attach Document",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Transform(
                                      transform: Matrix4.translationValues(
                                          delayedAnimation.value * width, 0, 0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FloatingActionButton(
                                            onPressed: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles();
                                              if (result != null) {
                                                print(result.files.single.path);
                                                // Share.shareFiles([
                                                //   "${result.files.single.path}"
                                                // ], text: "Image");
                                              }
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    AppColor.primary,
                                                    AppColor.primary
                                                        .withOpacity(0.7)
                                                  ],
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    offset: Offset(5, 5),
                                                    blurRadius: 10,
                                                  )
                                                ],
                                              ),
                                              child: Icon(Icons
                                                  .add_photo_alternate_outlined),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Transform(
                                    transform: Matrix4.translationValues(
                                        delayedAnimation.value * width, 0, 0),
                                    child: BouncingWidget(
                                        onPressed: () {},
                                        child: ButtonPage(
                                            height: 56,
                                            name: "Request Leave",
                                            icon: Icons
                                                .pending_actions_outlined)),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  // Transform(
                                  //   transform: Matrix4.translationValues(
                                  //       muchDelayedAnimation.value * width,
                                  //       0,
                                  //       0),
                                  //   child: Divider(
                                  //     color: Colors.black,
                                  //     thickness: 0.9,
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //     top: 8.0,
                                  //     bottom: 8.0,
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Transform(
                                  //         transform: Matrix4.translationValues(
                                  //             muchDelayedAnimation.value *
                                  //                 width,
                                  //             0,
                                  //             0),
                                  //         child: Text(
                                  //           "Leave History",
                                  //           style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 15,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Transform(
                                  //         transform: Matrix4.translationValues(
                                  //             delayedAnimation.value * width,
                                  //             0,
                                  //             0),
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.all(4.0),
                                  //           child: InkWell(
                                  //             onTap: () async {},
                                  //             child: Text(
                                  //               "See All",
                                  //               style: TextStyle(
                                  //                 color: Colors.blue,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // // Transform(
                                  //   transform: Matrix4.translationValues(
                                  //       delayedAnimation.value * width, 0, 0),
                                  //   child: BouncingWidget(
                                  //     onPressed: () {},
                                  //     child: LeaveHistoryCard(
                                  //       reason:
                                  //           "this is sample reason.this is sample reason.this is sample reason.this is sample reason.",
                                  //       enddate: "12.12.2020",
                                  //       startdate: "11.12.2020",
                                  //       status: "usual reason",
                                  //       adate: "05.12.2020",
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                )),
          );
        });
  }
}
