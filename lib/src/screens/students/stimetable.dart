// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_edu/src/screens/faculty/getFtimetabledata.dart';
import 'package:virtual_edu/src/screens/students/getStimetable.dart';
import 'package:virtual_edu/src/screens/students/shomedrawer.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_textstyle.dart';
import '../roledropdown.dart';
import 'sdateWidget.dart' as date_util;

class STimetablePage extends StatefulWidget {
  @override
  _STimetablePageState createState() => _STimetablePageState();
}

class _STimetablePageState extends State<STimetablePage>
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
  List sTbl = GetStimetable().getSTimetabledata();

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
    currentMonthList = date_util.SDateUtils.daysInMonth(currentDateTime);
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
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "Timetable",
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Text(
                                      currentDateTime.day.toString() +
                                          ", " +
                                          date_util.SDateUtils.months[
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
                                        return DateCardView(index);
                                      },
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: sTbl.length,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return cardWidget(
                                        subject: sTbl[index].subject,
                                        lecDate: sTbl[index].lecDate,
                                        facultyName: sTbl[index].facultyName,
                                        lecSTime: sTbl[index].lecSTime,
                                        lecETime: sTbl[index].lecETime,
                                        Stream: sTbl[index].stream,
                                        Div: sTbl[index].div,
                                        Year: sTbl[index].year);
                                  }),
                            ),
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

  Widget DateCardView(int index) {
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
                    date_util.SDateUtils
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
}

class cardWidget extends StatefulWidget {
  final String subject;
  final String lecDate;
  final String facultyName;
  final String lecSTime;
  final String lecETime;
  final String Stream;
  final String Year;
  final String Div;
  const cardWidget({
    Key? key,
    required this.subject,
    required this.lecDate,
    required this.facultyName,
    required this.lecSTime,
    required this.lecETime,
    required this.Stream,
    required this.Year,
    required this.Div,
  }) : super(key: key);

  @override
  State<cardWidget> createState() => _cardWidgetState();
}

class _cardWidgetState extends State<cardWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "${widget.lecSTime}",
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
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${widget.lecSTime}" + " - " + "${widget.lecETime}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${widget.facultyName}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${widget.subject}",
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
