import 'dart:async';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fzregex/utils/fzregex.dart';
// import 'package:fzregex/utils/pattern.dart';
import 'package:virtual_edu/src/styles/app_colors.dart';
import 'package:virtual_edu/src/styles/app_textstyle.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  var animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  var animationController;
  bool _autoValidate = false;
  bool passshow = false;
  var _selectedStd, _selectedDiv;
  var _pass;
  var _email;
  var user1;
  bool _issecure = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<int> standard = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<String> div = ['A', 'B', 'C', 'D'];

  @override
  void initState() {
    // TODO: implement initState
    WidgetsFlutterBinding.ensureInitialized();
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

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, _) {
          return SafeArea(
            child: Scaffold(
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
                        Transform(
                          transform: Matrix4.translationValues(
                              animation.value * width, 0, 0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            child: Image.asset('assets/images/kslogo.png'),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
                            child: Column(
                              children: [
                                Text(
                                  "Registration",
                                  style: AppTextStyle.style(
                                      fontsize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(38),
                            topLeft: Radius.circular(38),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Form(
                                key: _formkey,
                                // autovalidate: _autoValidate,
                                child: Column(
                                  children: [
                                    Transform(
                                      transform: Matrix4.translationValues(
                                          LeftCurve.value * width, 0, 0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null) {
                                            return "Please Enter Valid Name";
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.name,
                                        style: AppTextStyle.style(
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                        decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Icon(Icons.person_outline),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            hintText: "Enter Name",
                                            labelText: "Name",
                                            labelStyle: AppTextStyle.style(
                                                color: Colors.black
                                                    .withOpacity(0.8))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Transform(
                                      transform: Matrix4.translationValues(
                                          LeftCurve.value * width, 0, 0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null) {
                                            return "Please Enter Roll No";
                                          } else {
                                            return null;
                                          }
                                        },
                                        style: AppTextStyle.style(
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                        decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Icon(Icons
                                                  .format_list_numbered_outlined),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            hintText: "Enter Roll No",
                                            labelText: "Roll No",
                                            labelStyle: AppTextStyle.style(
                                                color: Colors.black
                                                    .withOpacity(0.8))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Transform(
                                          transform: Matrix4.translationValues(
                                              LeftCurve.value * width, 0, 0),
                                          child: Container(
                                            child: DropdownButton(
                                              underline: Container(
                                                decoration: ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                  ),
                                                ),
                                              ),
                                              iconSize: 30,
                                              hint: Text(
                                                'Select Standard',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "SourceSansPro",
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                              ), // Not necessary for Option 1
                                              value: _selectedStd,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _selectedStd = newValue;
                                                });
                                              },
                                              items: standard.map((std) {
                                                return DropdownMenuItem(
                                                  child:
                                                      new Text(std.toString()),
                                                  value: std,
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        Transform(
                                          transform: Matrix4.translationValues(
                                              muchDelayedAnimation.value *
                                                  width,
                                              0,
                                              0),
                                          child: Container(
                                            child: DropdownButton(
                                              underline: Container(
                                                decoration: ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                  ),
                                                ),
                                              ),
                                              iconSize: 30,
                                              hint: Text(
                                                'Select Division',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "SourceSansPro",
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                              ), // Not necessary for Option 1
                                              value: _selectedDiv,
                                              onChanged: (newDiv) {
                                                setState(() {
                                                  _selectedDiv = newDiv;
                                                });
                                              },
                                              items: div.map((div) {
                                                return DropdownMenuItem(
                                                  child:
                                                      new Text(div.toString()),
                                                  value: div,
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Transform(
                                      transform: Matrix4.translationValues(
                                          LeftCurve.value * width, 0, 0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null) {
                                            return "Please Enter Address";
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.multiline,
                                        style: AppTextStyle.style(
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                        decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Icon(
                                                  Icons.location_city_outlined),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            hintText: "Enter Address",
                                            labelText: "Address",
                                            labelStyle: AppTextStyle.style(
                                                color: Colors.black
                                                    .withOpacity(0.8))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Transform(
                                      transform: Matrix4.translationValues(
                                          LeftCurve.value * width, 0, 0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null) {
                                            return "Enter Vaild Phone No";
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.phone,
                                        maxLength: 10,
                                        style: AppTextStyle.style(
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                        decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Icon(
                                                  Icons.phone_android_outlined),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            hintText: "Enter Mobile No",
                                            labelText: "Mobile No",
                                            labelStyle: AppTextStyle.style(
                                                color: Colors.black
                                                    .withOpacity(0.8))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Transform(
                                      transform: Matrix4.translationValues(
                                          LeftCurve.value * width, 0, 0),
                                      child: TextFormField(
                                        // validator: (value) {
                                        //   if ((Fzregex.hasMatch(
                                        //           value, FzPattern.email) ==
                                        //       false)) {
                                        //     return "Enter Vaild Email address";
                                        //   } else {
                                        //     return null;
                                        //   }
                                        // },
                                        onSaved: (value) {
                                          _email = value;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: AppTextStyle.style(
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                        decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Icon(Icons.email_outlined),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            hintText: "kinnaridabgar@gmail.com",
                                            labelText: "E-mail-Id",
                                            labelStyle: AppTextStyle.style(
                                                color: Colors.black
                                                    .withOpacity(0.8))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Transform(
                                      transform: Matrix4.translationValues(
                                          LeftCurve.value * width, 0, 0),
                                      child: TextFormField(
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Enter Vaild password";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (val) {
                                          _pass = val;
                                        },
                                        obscureText: true,
                                        style: AppTextStyle.style(
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                        decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Icon(Icons.lock_outline),
                                            ),
                                            suffixIcon: Padding(
                                              padding: EdgeInsets.all(15),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _issecure = !_issecure;
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  color: _issecure
                                                      ? Colors.black
                                                          .withOpacity(0.8)
                                                      : Colors.black
                                                          .withOpacity(0.4),
                                                ),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            hintText: "Enter Password",
                                            labelText: "PassWord",
                                            labelStyle: AppTextStyle.style(
                                                color: Colors.black
                                                    .withOpacity(0.8))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 32),
                              Transform(
                                transform: Matrix4.translationValues(
                                    delayedAnimation.value * width, 0, 0),
                                child: BouncingWidget(
                                  onPressed: () {
                                    // if (_formkey.currentState!.validate()) {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (BuildContext context) =>
                                    //             HomeScreen(),
                                    //       ));
                                    // } else {
                                    //   Fluttertoast.showToast(
                                    //       msg: "please fill all the field");
                                    // }
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (BuildContext context) =>
                                    //           SHomeScreen(),
                                    //     ));
                                  },
                                  child: Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColor.primary,
                                          AppColor.primary.withOpacity(0.7)
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
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 32),
                                              child: Text(
                                                'Registration',
                                                style: AppTextStyle.style(
                                                    fontsize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Icon(
                                              Icons.app_registration_outlined,
                                              color: Colors.white,
                                              size: 32),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
