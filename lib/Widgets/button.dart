import 'package:flutter/material.dart';
import 'package:virtual_edu/src/styles/app_colors.dart';
import 'package:virtual_edu/src/styles/app_textstyle.dart';

class ButtonPage extends StatelessWidget {
  final double height;
  final String name;
  final IconData icon;
  const ButtonPage(
      {required this.height, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.primary, AppColor.primary.withOpacity(0.7)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(5, 5),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text(
                  name,
                  style: AppTextStyle.style(
                      fontsize: 20, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(icon, color: Colors.white, size: 32),
          )
        ],
      ),
    );
  }
}
