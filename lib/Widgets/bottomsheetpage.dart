import 'dart:io';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:virtual_edu/Widgets/button.dart';
import 'package:virtual_edu/Widgets/filepicker.dart';
import 'package:virtual_edu/src/styles/app_colors.dart';
import 'package:virtual_edu/src/styles/app_textstyle.dart';

double _scalefactor = 1.0;

class BottomSheetPage extends StatelessWidget {
  void show(BuildContext ctx, int index, String subject, String createdate,
      String subdate, String status, String marks) {
    showModalBottomSheet<void>(
      enableDrag: false,
      isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(38))),
      context: ctx,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: FloatingActionButton(
                              onPressed: () async {
                                Navigator.pop(ctx);
                              },
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        AppColor.primary,
                                        AppColor.primary.withOpacity(0.7)
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(5, 5),
                                        blurRadius: 10,
                                      )
                                    ],
                                  ),
                                  child: Icon(Icons.close_outlined))),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Text(
                          subject,
                          style: AppTextStyle.style(
                              fontsize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
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
                        createdate,
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
                        subdate,
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
                        status,
                        style: TextStyle(
                            fontSize: 14,
                            background: Paint()..color = Colors.red,
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
                        marks,
                        style: AppTextStyle.style(
                            fontsize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: BouncingWidget(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FilePickerDemo()));
                        },
                        scaleFactor: _scalefactor,
                        child: Row(
                          children: [
                            Icon(Icons.search_outlined,
                                size: 20, color: Colors.blue),
                            Text("Browse",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: BouncingWidget(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FilePickerDemo()));
                        },
                        scaleFactor: _scalefactor,
                        child: ButtonPage(
                            height: 56,
                            name: "Upload",
                            icon: Icons.file_upload_outlined)))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
