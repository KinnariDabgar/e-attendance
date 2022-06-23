import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:virtual_edu/src/styles/app_colors.dart';
import 'sdrawertile.dart';

class SHomeDrawer extends StatefulWidget {
  const SHomeDrawer({Key? key}) : super(key: key);

  @override
  _SHomeDrawerState createState() => _SHomeDrawerState();
}

class _SHomeDrawerState extends State<SHomeDrawer> {
  double _scaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Drawer(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: new Container(
                  margin: const EdgeInsets.only(top: 0.0),
                  width: 80.0,
                  height: 120.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: new DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: new NetworkImage(
                        "https://cdn.pixabay.com/photo/2018/08/28/13/29/avatar-3637561__340.png",
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [AppColor.primary, AppColor.primaryLight])),
                accountName: Text("Alex"),
                accountEmail: Text("alex@123gmail.com"),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: BouncingWidget(
                    scaleFactor: _scaleFactor,
                    child: SDrawerTile(
                      imgpath: "home.png",
                      name: "Home",
                    ),
                    onPressed: () {}),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: BouncingWidget(
                    scaleFactor: _scaleFactor,
                    child: SDrawerTile(
                      imgpath: "profile.png",
                      name: "Profile",
                    ),
                    onPressed: () {}),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: BouncingWidget(
                    scaleFactor: _scaleFactor,
                    child: SDrawerTile(
                      imgpath: "exit.png",
                      name: "Log Out",
                    ),
                    onPressed: () {}),
              ),
            ],
          ),
        ));
  }
}
