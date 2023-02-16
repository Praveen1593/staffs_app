import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/common_widgets.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_class_time_table/staff_class_timetable_view.dart';
import 'package:get/get.dart';

import '../../../../../common/const/colors.dart';
import '../../../../controller/daily_activities/class_timetable_controller/staff_class_timetable_controller.dart';


class StaffClassTimetable extends StatelessWidget {
  const StaffClassTimetable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("Class Timetable"),
      body: GetBuilder<StaffclassTimetableController>(
        init: StaffclassTimetableController(),
        builder: (staffclassTimetableController) {
          return staffclassTimetableController.staffClassTimetableModel?.data!=null?
            _buildbody(context):SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      )
    );

  }

  Widget _buildbody(BuildContext context){
    return Column(
      children: [
        InkWell(
          onTap: (){
            Get.to(StaffClassTimetableView(1));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration:  BoxDecoration(
                  gradient:   const LinearGradient(
                    colors: <Color>[AppColors.timetableColor1, AppColors.timetableColor2],
                  ),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Image.asset("assets/timetable_icons.png",width: 30,height: 30,),
                  title: Text("Regular Timetable",
                      style: nunitoExtraBoldTextStyle(
                          fontSize: 15, color: AppColors.whiteColor)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text("Screen has been rotated Landscape for better User Experience",
                        style: nunitoRegularTextStyle(
                            fontSize: 13, color: AppColors.whiteColor)),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (){
            Get.to(StaffClassTimetableView(2));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration:  BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[AppColors.timetableColor1, AppColors.timetableColor2],
                  ),
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Image.asset("assets/timetable_icons.png",width: 30,height: 30,),
                  title: Text("Online Timetable",
                      style: nunitoExtraBoldTextStyle(
                          fontSize: 15, color: AppColors.whiteColor)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text("Screen has been rotated Landscape for better User Experience",
                        style: nunitoRegularTextStyle(
                            fontSize: 13, color: AppColors.whiteColor)),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (){
            Get.to(StaffClassTimetableView(3));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration:  BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[AppColors.timetableColor1, AppColors.timetableColor2],
                  ),
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Image.asset("assets/timetable_icons.png",width: 30,height: 30,),
                  title: Text("Standard Subject",
                      style: nunitoExtraBoldTextStyle(
                          fontSize: 15, color: AppColors.whiteColor)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text("Screen has been rotated Portrait for better User Experience",
                        style: nunitoRegularTextStyle(
                            fontSize: 13, color: AppColors.whiteColor)),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
