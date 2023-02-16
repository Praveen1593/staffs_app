import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_projects/common/widgets/common_widgets.dart';
import 'package:get/get.dart';

import '../../../../controller/daily_activities/class_timetable_controller/staff_class_timetable_controller.dart';


class StaffClassTimetableView extends StatelessWidget {

  int? type;

   StaffClassTimetableView(this.type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StaffclassTimetableController>(
          init: StaffclassTimetableController(),
          builder: (staffclassTimetableController) {
            return _buildbody(staffclassTimetableController,context);
          }),
    );

  }

  Widget _buildbody(StaffclassTimetableController controller,BuildContext context){
    return WillPopScope(
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
                  data: type==1?
                  controller.staffClassTimetableModel?.data?.periodSchedule ??'':type==2?
                  controller.staffClassTimetableModel?.data?.onlineSchedule ??'':type==3?
                  controller.staffClassTimetableModel?.data?.staffSubject ??'':"")
                  .paddingOnly(top: 20),
            ],
          ),
        ),
      ),
    );
  }
}
