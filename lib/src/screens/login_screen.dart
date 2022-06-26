import 'dart:async';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fzregex/utils/fzregex.dart';
// import 'package:fzregex/utils/pattern.dart';
import 'package:virtual_edu/Widgets/bouncingpagerout.dart';
import 'package:virtual_edu/src/screens/faculty/facultyhome_screen.dart';
import 'package:virtual_edu/src/screens/registration.dart';
import 'package:virtual_edu/src/screens/signup.dart';
import 'package:virtual_edu/src/screens/students/Studenthome_screen.dart';
import 'package:virtual_edu/src/styles/app_colors.dart';
import 'package:virtual_edu/src/styles/app_textstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _autoValidate = false;
  bool passshow = false;
  var animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  var animationController;
  var _pass;
  var _email;
  var user1;
  var role;
  bool _issecure = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    getRoleValuesSF();
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.bounceOut)));

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

  getRoleValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    role = prefs.getString('role');
    print(role);
    return role;
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
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Image.asset(
                              'assets/images/smallkslogo.png',
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Column(
                              children: [
                                Text(
                                  "Hi " + role.toString(),
                                  style: AppTextStyle.style(
                                      fontsize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Sign in to Continue",
                                  style: AppTextStyle.style(
                                      fontsize: 18,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
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
                                            hintText: "Enter E-mail id:",
                                            labelText: "E-mail-Id",
                                            labelStyle: AppTextStyle.style(
                                                color: Colors.black
                                                    .withOpacity(0.8))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
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
                                    animation.value * width, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'Forgot Password?',
                                        style: AppTextStyle.style(
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Transform(
                                transform: Matrix4.translationValues(
                                    animation.value * width, 0, 0),
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
                                    //   context,
                                    //   BouncingPageRoute(widget: HomeScreen()),
                                    // );
                                    role == "Faculty"
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  FacultyHomeScreen(),
                                            ))
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  StudentHomeScreen(),
                                            ));
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
                                                'Sign In',
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
                                          child: Icon(Icons.arrow_forward,
                                              color: Colors.white, size: 32),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Transform(
                                transform: Matrix4.translationValues(
                                    animation.value * width, 0, 0),
                                child: BouncingWidget(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SignupScreen(),
                                        ));
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
                                                'Sign Up',
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
