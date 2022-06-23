import 'package:flutter/material.dart';
import 'package:virtual_edu/src/styles/app_textstyle.dart';

bool checkstatus = false;

class HomeworkCard extends StatefulWidget {
  final String subject;
  final String createDate;
  final String subDate;
  final String marks;
  final String status;

  const HomeworkCard(
      {required this.subject,
      required this.createDate,
      required this.subDate,
      required this.status,
      required this.marks});

  @override
  _HomeworkCardState createState() => _HomeworkCardState();
}

class _HomeworkCardState extends State<HomeworkCard>
    with SingleTickerProviderStateMixin {
  var animation, delayedAnimation;
  var animationController;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.status.toString() == "Complete") {
      setState(() {
        checkstatus = true;
      });
    } else {
      setState(() {
        checkstatus = false;
      });
    }
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
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 3),
                      //blurRadius: 3,
                      //spreadRadius: 1,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "${widget.subject}",
                            style: AppTextStyle.style(
                                fontsize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text("View",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16)),
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
                            "Created",
                            style: AppTextStyle.style(
                                fontsize: 16,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "Submission",
                            style: AppTextStyle.style(
                                fontsize: 16,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "Status",
                            style: AppTextStyle.style(
                                fontsize: 16,
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
                            "${widget.createDate}",
                            style: AppTextStyle.style(
                                fontsize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "${widget.subDate}",
                            style: AppTextStyle.style(
                                fontsize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "${widget.status}",
                            style: TextStyle(
                                fontSize: 14,
                                backgroundColor:
                                    checkstatus ? Colors.green : Colors.red,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "Marks",
                            style: AppTextStyle.style(
                                fontsize: 16,
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
                            "${widget.marks}",
                            style: AppTextStyle.style(
                                fontsize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
