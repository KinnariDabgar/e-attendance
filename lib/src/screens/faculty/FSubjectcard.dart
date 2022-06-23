import 'package:flutter/material.dart';
import 'package:virtual_edu/Widgets/button.dart';
import 'package:virtual_edu/src/screens/faculty/markattendance.dart';
import 'package:virtual_edu/src/styles/app_textstyle.dart';

bool checkstatus = false;

class FsubjectCard extends StatefulWidget {
  final String subject;
  final String lecDate;
  final String lecTime;
  final String Stream;
  final String Year;
  final String Div;

  const FsubjectCard({
    required this.subject,
    required this.lecDate,
    required this.lecTime,
    required this.Stream,
    required this.Year,
    required this.Div,
  });

  @override
  _FsubjectCardState createState() => _FsubjectCardState();
}

class _FsubjectCardState extends State<FsubjectCard>
    with SingleTickerProviderStateMixin {
  var animation, delayedAnimation;
  var animationController;
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
        curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn)));
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
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: Transform(
              transform: Matrix4.translationValues(
                  delayedAnimation.value * width, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 2),
                      blurRadius: 7,
                    ),
                  ],
                ),
                // BoxDecoration(
                //   color: Colors.white,
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black26,
                //       offset: Offset(0, 3),
                //       //blurRadius: 3,
                //       //spreadRadius: 1,
                //     ),
                //   ],
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Text(
                        "${widget.subject}",
                        style: AppTextStyle.style(
                            fontsize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "Date",
                            style: AppTextStyle.style(
                                fontsize: 20,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "Time",
                            style: AppTextStyle.style(
                                fontsize: 20,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "${widget.lecDate}",
                            style: AppTextStyle.style(
                                fontsize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "${widget.lecTime}",
                            style: AppTextStyle.style(
                                fontsize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "Stream",
                            style: AppTextStyle.style(
                                fontsize: 20,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "Year",
                            style: AppTextStyle.style(
                                fontsize: 20,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "Div",
                            style: AppTextStyle.style(
                                fontsize: 20,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "${widget.Stream}",
                            style: AppTextStyle.style(
                                fontsize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "${widget.Year}",
                            style: AppTextStyle.style(
                                fontsize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "${widget.Div}",
                            style: AppTextStyle.style(
                                fontsize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MarkAttendance(
                                            subject: widget.subject,
                                            lecDate: widget.lecDate,
                                            stream: widget.Stream,
                                            year: widget.Year,
                                            div: widget.Div)));
                          },
                          child: ButtonPage(
                              height: 5,
                              name: "Mark Attendance",
                              icon: Icons.check),
                        ))
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 20, vertical: 16),
                    //   child: Text("Mark Attendance",
                    //       style: TextStyle(
                    //           decoration: TextDecoration.underline,
                    //           color: Colors.blue,
                    //           fontWeight: FontWeight.w900,
                    //           fontSize: 16)),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
