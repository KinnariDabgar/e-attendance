import 'package:flutter/cupertino.dart';

class BouncingPageRoute extends PageRouteBuilder {
  final Widget widget;
  BouncingPageRoute({required this.widget})
      : super(
            transitionDuration: Duration(seconds: 2),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.elasticInOut);

              return ScaleTransition(
                scale: animation,
                alignment: Alignment.center,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation){
              return widget;
            }
            );
}
