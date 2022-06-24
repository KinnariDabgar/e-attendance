import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_edu/src/screens/login_screen.dart';
import 'package:virtual_edu/src/screens/roledropdown.dart';
import 'package:virtual_edu/src/styles/app_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  var animationController;
  void initState() {
    Timer(Duration(seconds: 3), start);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColor.primary, AppColor.primaryLight])),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: Center(child: Image.asset('assets/images/kslogo.png')),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   child: Icon(
                  //     Icons.school_rounded,
                  //     color: Colors.redAccent,
                  //     size: 50,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "E-Attendance",
                      style: GoogleFonts.pacifico(
                          //fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 36),
                      // style: AppTextStyle.style(
                      //     fontsize: 22,
                      //     fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  start() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => RoleDropdown(),
        ),
      );
    });
  }
}
