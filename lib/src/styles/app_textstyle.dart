import 'package:flutter/material.dart';

mixin AppTextStyle {
  static const primaryText =
      TextStyle(fontSize: 18, color: Colors.white, fontFamily: "SourceSansPro");
  static TextStyle style(
          {double fontsize = 18,
          Color color = Colors.white,
          FontWeight fontWeight: FontWeight.normal}) =>
      TextStyle(fontFamily: "SourceSansPro", fontSize: fontsize, color: color,fontWeight: fontWeight);
}
