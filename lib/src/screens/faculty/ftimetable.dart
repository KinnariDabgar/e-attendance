import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_textstyle.dart';
import '../roledropdown.dart';
import 'fhomedrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dateWidget.dart' as date_util;

class FTimetablePage extends StatefulWidget {
  @override
  _FTimetablePageState createState() => _FTimetablePageState();
}

class _FTimetablePageState extends State<FTimetablePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late VoidCallback _showPersistantBottomSheetCallBack;

  var animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  var animationController;
  double _scaleFactor = 1.0;
  bool _selectDate = false;
  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List<String> todos = <String>[];
  TextEditingController controller = TextEditingController();
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
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
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

  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Text(
        date_util.DateUtils.months[currentDateTime.month - 1] +
            ' ' +
            currentDateTime.year.toString(),
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget hrizontalCapsuleListView() {
    return Container(
      width: width,
      height: 150,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
            });
          },
          child: Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: (currentMonthList[index].day != currentDateTime.day)
                        ? [
                            Colors.white.withOpacity(0.8),
                            Colors.white.withOpacity(0.7),
                            Colors.white.withOpacity(0.6)
                          ]
                        : [
                            HexColor("ED6184"),
                            HexColor("EF315B"),
                            HexColor("E2042D")
                          ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 4,
                    spreadRadius: 2,
                    color: Colors.black12,
                  )
                ]),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    currentMonthList[index].day.toString(),
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? HexColor("465876")
                                : Colors.white),
                  ),
                  Text(
                    date_util.DateUtils
                        .weekdays[currentMonthList[index].weekday - 1],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? HexColor("465876")
                                : Colors.white),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget topView() {
    return Container(
      height: height * 0.35,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              HexColor("488BC8").withOpacity(0.7),
              HexColor("488BC8").withOpacity(0.5),
              HexColor("488BC8").withOpacity(0.3)
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: const [0.0, 0.5, 1.0],
            tileMode: TileMode.clamp),
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Colors.black12,
              offset: Offset(4, 4),
              spreadRadius: 2)
        ],
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            titleView(),
            hrizontalCapsuleListView(),
          ]),
    );
  }

  Widget todoList() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, height * 0.38, 10, 10),
      width: width,
      height: height * 0.60,
      child: ListView.builder(
          itemCount: todos.length,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              width: width - 20,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white12,
                        blurRadius: 2,
                        offset: Offset(2, 2),
                        spreadRadius: 3)
                  ]),
              child: Center(
                child: Text(
                  todos[index],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
    );
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
              drawer: FHomeDrawer(),
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
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.22,
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // boxShadow: const [
                                // BoxShadow(
                                //     blurRadius: 4,
                                //     color: Colors.black12,
                                //     offset: Offset(4, 4),
                                //     spreadRadius: 2)
                                // ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(38)),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        "Lectures",
                                        style: GoogleFonts.lato(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 28),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: Text(
                                        date_util.DateUtils.months[
                                                currentDateTime.month - 1] +
                                            ' ' +
                                            currentDateTime.year.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      height: 80,
                                      child: ListView.builder(
                                        controller: scrollController,
                                        scrollDirection: Axis.horizontal,
                                        physics: const ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: currentMonthList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return capsuleView(index);
                                        },
                                      ),
                                    )
                                  ]),
                            )
                          ],
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

class cardWidget extends StatelessWidget {
  const cardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "13:00",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              lineGen(
                lines: [20.0, 30.0, 40.0, 10.0],
              ),
            ],
          ),
        ),
        SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: Container(
            height: 100.0,
            width: 100,
            decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0))),
            child: Container(
              margin: EdgeInsets.only(left: 4.0),
              color: Color(0xfffcf9f5),
              padding: EdgeInsets.only(left: 16.0, top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 21.0,
                    child: Row(
                      children: [
                        Text(
                          "13:00 - 14:00",
                        ),
                        VerticalDivider(),
                        Text(
                          "Hitesh Parmar",
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Information Security",
                    style:
                        TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class dateWidget extends StatefulWidget {
  final index;

  const dateWidget({Key? key, this.index}) : super(key: key);

  @override
  State<dateWidget> createState() => _dateWidgetState();
}

class _dateWidgetState extends State<dateWidget> {
  bool _selectDate = false;
  var weeklist = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectDate = !_selectDate;
        });
      },
      child: Container(
        decoration: _selectDate
            ? BoxDecoration(
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 2),
                    blurRadius: 7,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(4.0)))
            : BoxDecoration(
                color: AppColor.primaryLight,
                // boxShadow: [

                //   // BoxShadow(
                //   //   color: AppColor.primaryLight,
                //   //   offset: Offset(0, 2),
                //   //   blurRadius: 3,
                //   // ),
                // ],
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(weeklist[widget.index],
                  style: TextStyle(
                    fontWeight:
                        _selectDate ? FontWeight.bold : FontWeight.normal,
                    color: _selectDate ? Colors.white : Colors.black,
                  )),
              Text("${DateTime.now().day + widget.index}",
                  // "${10 + widget.index}"
                  style: TextStyle(
                      fontWeight:
                          _selectDate ? FontWeight.bold : FontWeight.normal,
                      color: _selectDate ? Colors.white : Colors.black)),
              Container(
                width: 4.0,
                height: 4.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectDate ? Colors.yellow : Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class topRow extends StatelessWidget {
  const topRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            "Lectures",
            style: GoogleFonts.lato(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 28),
          ),
          Spacer(),
          Text(
            "Jan",
            style: GoogleFonts.lato(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          )
        ],
      ),
    );
  }
}

class lineGen extends StatelessWidget {
  final lines;
  const lineGen({Key? key, this.lines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            4,
            (index) => Container(
                height: 2.0,
                width: lines[index],
                color: AppColor.primary,
                margin: EdgeInsets.symmetric(vertical: 12.0))));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
