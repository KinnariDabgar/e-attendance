import 'package:flutter/material.dart';
import 'package:virtual_edu/src/styles/app_textstyle.dart';

class FacultyDetailCard extends StatefulWidget {
  @override
  _FacultyDetailCardState createState() => _FacultyDetailCardState();
}

class _FacultyDetailCardState extends State<FacultyDetailCard>
    with SingleTickerProviderStateMixin {
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

  Widget build(BuildContext context) {
    animationController.forward();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 3),
          child: Container(
            alignment: Alignment(0, 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: ExactAssetImage('assets/images/images.jpeg'),
                  //     fit: BoxFit.fill),
                  color: Color.fromRGBO(201, 204, 141, 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: height * 0.15,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform(
                            transform: Matrix4.translationValues(
                                muchDelayedAnimation.value * width, 0, 0),
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                width: 70.0,
                                height: 70,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                  image: new DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: new NetworkImage(
                                      "https://cdn.pixabay.com/photo/2018/08/28/13/29/avatar-3637561__340.png",
                                    ),
                                  ),
                                ),
                              ),
                              // child: CircleAvatar(
                              //   radius: 40,
                              //   backgroundColor: Colors.blue[50],
                              //   child: Image.network(
                              //       'https://cdn.pixabay.com/photo/2018/08/28/13/29/avatar-3637561__340.png',fit: BoxFit.fill,),
                              // ),
                            ),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                delayedAnimation.value * width, 0, 0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      "Hitesh Parmar",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Stream: M.sc.[CA&IT]",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 8.0),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Text(
                                  //         "Subject: IS",
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.black,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
