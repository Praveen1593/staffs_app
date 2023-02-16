import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controllers/daily_activity_controller/class_time_table_controller/class_time_table_controller.dart';

class ClassTimeTableScreen extends StatefulWidget {
  const ClassTimeTableScreen({Key? key}) : super(key: key);

  @override
  State<ClassTimeTableScreen> createState() => _ClassTimeTableScreenState();
}

class _ClassTimeTableScreenState extends State<ClassTimeTableScreen> {

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GetBuilder<ClassTimeTableController>(
          init: ClassTimeTableController(),
          builder: (classTimeTableController) {
            return classTimeTableController.classTimeTableModel
                ?.cttData?.periodSchedule != "" ?WillPopScope(
              onWillPop: () async {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitDown,
                  DeviceOrientation.portraitUp
                ]);
                return true;
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Html(
                              shrinkWrap: true,
                              data: classTimeTableController.classTimeTableModel
                                      ?.cttData?.periodSchedule ??
                                  '',  style: {
                        "td": Style(
                            padding:
                            const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            backgroundColor:
                            const Color(0xff2196f3),
                            width: Get.width * 0.5,
                            color: Colors.white),
                        "tr": Style(
                            padding:
                            const EdgeInsets.all(
                                12),
                            alignment: Alignment.center,
                            backgroundColor:
                            Colors.blueGrey,
                            color: Colors.white),
                        "th": Style(
                            padding:
                            const EdgeInsets.all(
                                10),
                            alignment: Alignment.center,
                            backgroundColor:
                            const Color(0xffffe082),
                            color: Colors.black),
                      })
                          .paddingOnly(top: 20),
                    ],
                  ),
                ),
              ),
            ): circularProgressIndicator();
          }),
    );
  }
}
