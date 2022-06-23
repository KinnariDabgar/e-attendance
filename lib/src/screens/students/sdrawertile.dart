import 'package:flutter/material.dart';
import 'package:virtual_edu/src/styles/app_textstyle.dart';

class SDrawerTile extends StatelessWidget {
  final String name;
  final String imgpath;

  const SDrawerTile({required this.name, required this.imgpath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
      child: Container(
        // elevation: 2,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
          child: Row(
            children: [
              Image.asset(
                'assets/images/${imgpath}',
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  name,
                  textAlign: TextAlign.left,
                  style: AppTextStyle.style(fontsize: 20, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
