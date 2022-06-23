import 'package:flutter/material.dart';
// import 'package:fzregex/utils/fzregex.dart';
// import 'package:fzregex/utils/pattern.dart';
import 'package:virtual_edu/src/screens/login_screen.dart';
import 'package:virtual_edu/src/styles/app_colors.dart';
import 'package:virtual_edu/src/styles/app_textstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoleDropdown extends StatefulWidget {
  @override
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown>
    with SingleTickerProviderStateMixin {
  bool _autoValidate = false;
  bool passshow = false;
  var animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  var animationController;
  List<String> Role = ['Admin', 'Faculty', 'Student'];
  var _selectedRole;

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
                            child: Image.asset('assets/images/smallkslogo.png'),
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
                                  "Hi User",
                                  style: AppTextStyle.style(
                                      fontsize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Select role to Continue",
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
                        width: MediaQuery.of(context).size.width,
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
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height /
                                        3.5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                  ),
                                  child: Center(
                                    child: DropdownButton(
                                      // underline: Container(
                                      //   decoration: ShapeDecoration(
                                      //     shape: RoundedRectangleBorder(
                                      //       side: BorderSide(
                                      //         width: 1,
                                      //         color:
                                      //             Colors.black.withOpacity(0.8),
                                      //       ),
                                      //       borderRadius: BorderRadius.all(
                                      //           Radius.circular(7.0)),
                                      //     ),
                                      //   ),
                                      // ),
                                      iconSize: 50,
                                      hint: Text(
                                        'Select Role',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontFamily: "SourceSansPro",
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ), // Not necessary for Option 1
                                      value: _selectedRole,
                                      onChanged: (newValue) async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        setState(() {
                                          _selectedRole = newValue;
                                          prefs.setString(
                                              "role", _selectedRole);
                                          print(newValue);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        });
                                      },
                                      items: Role.map((std) {
                                        return DropdownMenuItem(
                                          child: new Text(std.toString()),
                                          value: std,
                                        );
                                      }).toList(),
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
