import 'package:flutter/material.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_add_entry_screen.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_class_teacher_view_screen.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_report_screen.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_result_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../common/widgets/staff_common_widgets.dart';
import '../../../../../parent/themes/app_styles.dart';
import '../../../../controller/daily_activities/classtest_controller/classtest_controller.dart';
import '../../../../controller/daily_activities/homework_controller/homework_controller.dart';

class StaffViewClasstest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffClasstestController>(
        init: StaffClasstestController(),
        builder: (staffClasstestController) => Scaffold(
            appBar: smsAppbar("Class Test"),
            body: staffClasstestController
                .list[staffClasstestController.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.darkPinkColor,
              currentIndex: staffClasstestController.currentIndex,
              onTap: (index) {
                staffClasstestController.updateIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Today",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Result",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Report",
                ),
              ],
            ),
            floatingActionButton: staffClasstestController.currentIndex != 0
                ? FloatingActionButton(
                    onPressed: () async{
                      if (staffClasstestController.subSelectFlag != 0) {
                        //staffClasstestController.classTestListData();
                        if(staffClasstestController.currentIndex!=0){
                          Map<String,dynamic> mapData = {
                            "start_date":staffClasstestController.startDate,
                            "end_date":staffClasstestController.endDate,
                            "standard_id":staffClasstestController.selectedStdValue,
                            "group_section_id":staffClasstestController.selectedSectionValue,
                            "std_subject_id":[staffClasstestController.stdSubjectId],
                          };
                          int result = await staffClasstestController.classTestListData(mapData);
                          if(result==200){
                            if(staffClasstestController.classTestReplyListData!=null&&staffClasstestController.classTestReplyListData!.isEmpty){
                            //  showStaffToastMsg("No Data Found");
                            }
                          }
                        }
                      } else {
                     //   showStaffToastMsg("Select Standard");
                      }
                    },
                    backgroundColor: AppColors.darkPinkColor,
                    heroTag: null,
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                : Container()));
  }
}

class BuildTodayBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<StaffClasstestController>(
      init: StaffClasstestController(),
      builder: (staffClasstestController) => staffClasstestController
                      .classTestSTViewModel?.data !=
                  null &&
              staffClasstestController.classTestSTViewModel!.code == 200
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Class Teacher Class Test",
                                    style: nunitoRegularTextStyle(
                                        fontSize: 15, color: Colors.black87)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "Click the icon to view current and previous Class Test",
                                    style: nunitoRegularTextStyle(
                                        fontSize: 12, color: Colors.black38))
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Get.to(StaffClassTeacherViewClasstest());
                                },
                                child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black38,
                                    )),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("View Class Test",
                                    style: nunitoRegularTextStyle(
                                        fontSize: 15, color: Colors.black87)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "Click the icon to select the date to view current and previous Class Test",
                                    style: nunitoRegularTextStyle(
                                        fontSize: 12, color: Colors.black38))
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      staffClasstestController.selectDate(
                                          context, 3);
                                    },
                                    child: const Icon(
                                      Icons.calendar_month,
                                      color: Colors.black38,
                                    ),
                                  ))),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${staffClasstestController.selectedDate}",
                                  style: nunitoExtraBoldTextStyle(
                                      fontSize: 15, color: Colors.black87)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("Selected Date",
                                  style: nunitoRegularTextStyle(
                                      fontSize: 12, color: Colors.black38))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.55,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          staffClasstestController.classTestViewData?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 25.0,
                                          backgroundColor:
                                              AppColors.darkPinkColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${staffClasstestController.classTestViewData?[index].standardSectionName} | ${staffClasstestController.classTestViewData?[index].subjectName}",
                                                style: nunitoExtraBoldTextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black87)),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            staffClasstestController
                                                        .classTestViewData?[
                                                            index]
                                                        .classTest !=
                                                    null
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        color: staffClasstestController
                                                                    .classTestViewData?[
                                                                        index]
                                                                    .classTest
                                                                    ?.approvalType ==
                                                                1
                                                            ? AppColors
                                                                .darkGreenColor
                                                            : AppColors
                                                                .indianRedColor,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Text(
                                                            staffClasstestController
                                                                        .classTestViewData?[
                                                                            index]
                                                                        .classTest
                                                                        ?.approvalType ==
                                                                    1
                                                                ? "Approved"
                                                                : "Not Approved",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          "${staffClasstestController.classTestViewData?[index].classTest?.title}",
                                                          style:
                                                              nunitoExtraBoldTextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          "${staffClasstestController.classTestViewData?[index].classTest?.description}",
                                                          style:
                                                              nunitoRegularTextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black))
                                                    ],
                                                  )
                                                : Text(
                                                    "Class Test not Assigned",
                                                    style:
                                                        nunitoRegularTextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () async {
                                              int value =
                                                  await staffClasstestController
                                                      .checkSettings();
                                              if (value == 200) {
                                                Future.delayed(
                                                    const Duration(seconds: 1));
                                                if (staffClasstestController
                                                        .classTestViewData?[
                                                            index]
                                                        .classTest ==
                                                    null) {
                                                  staffClasstestController
                                                      .titleEditController
                                                      .text = "";
                                                  staffClasstestController
                                                      .descriptionEditController
                                                      .text = "";
                                                  Get.to(StaffAddEntryClasstest(
                                                    type: 1,
                                                    classTestId:
                                                        staffClasstestController
                                                            .classTestViewData?[
                                                                index]
                                                            .id,
                                                    sectionSubjectItemId:
                                                        staffClasstestController
                                                            .classTestViewData?[
                                                                index]
                                                            .sectionSubjectItemId,
                                                    selectedDate:
                                                        staffClasstestController
                                                            .selectedDate,
                                                  ));
                                                } else {
                                                  staffClasstestController
                                                      .attachmentList
                                                      ?.clear();
                                                  staffClasstestController
                                                          .attachmentList =
                                                      staffClasstestController
                                                          .classTestViewData?[
                                                              index]
                                                          .classTest
                                                          ?.images;
                                                  staffClasstestController
                                                          .titleEditController
                                                          .text =
                                                      staffClasstestController
                                                              .classTestViewData?[
                                                                  index]
                                                              .classTest
                                                              ?.title ??
                                                          "";
                                                  staffClasstestController
                                                      .descriptionEditController
                                                      .text = staffClasstestController
                                                          .classTestViewData?[
                                                              index]
                                                          .classTest
                                                          ?.description ??
                                                      "";

                                                  if (staffClasstestController
                                                          .classTestViewData?[
                                                              index]
                                                          .classTest
                                                          ?.approvalType ==
                                                      1) {
                                                    staffClasstestController
                                                        .radiotype = 1;
                                                  } else {
                                                    staffClasstestController
                                                        .radiotype = 2;
                                                  }
                                                  Get.to(StaffAddEntryClasstest(
                                                    type: 2,
                                                    classTestId:
                                                        staffClasstestController
                                                            .classTestViewData?[
                                                                index]
                                                            .id,
                                                    sectionSubjectItemId:
                                                        staffClasstestController
                                                            .classTestViewData?[
                                                                index]
                                                            .sectionSubjectItemId,
                                                    title:
                                                        staffClasstestController
                                                            .classTestViewData?[
                                                                index]
                                                            .classTest
                                                            ?.title,
                                                    description:
                                                        staffClasstestController
                                                            .classTestViewData?[
                                                                index]
                                                            .classTest
                                                            ?.description,
                                                    classTestItemId:
                                                        staffClasstestController
                                                            .classTestViewData?[
                                                                index]
                                                            .classTest
                                                            ?.id,
                                                    approvalType:
                                                        staffClasstestController
                                                            .classTestViewData?[
                                                                index]
                                                            .classTest
                                                            ?.approvalType,
                                                  ));
                                                }
                                              }
                                            },
                                            child: staffClasstestController
                                                        .classTestViewData?[
                                                            index]
                                                        .classTest ==
                                                    null
                                                ? const Icon(
                                                    Icons.add,
                                                    color:
                                                        AppColors.darkPinkColor,
                                                  )
                                                : Image.asset(
                                                    "assets/edit_icons.png",
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                          ))),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),

      /*Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Class Teacher Class Test",
                              style: nunitoRegularTextStyle(
                                  fontSize: 15, color: Colors.black87)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Click the icon to view current and previous Class Test",
                              style: nunitoRegularTextStyle(
                                  fontSize: 12, color: Colors.black38))
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Get.to(StaffClassTeacherViewClasstest());
                          },
                          child: const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black38,
                              )),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("View Class Test",
                              style: nunitoRegularTextStyle(
                                  fontSize: 15, color: Colors.black87)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Click the icon to select the date to view current and previous Class Test",
                              style: nunitoRegularTextStyle(
                                  fontSize: 12, color: Colors.black38))
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                staffClasstestController.selectDate(context);
                              },
                              child: const Icon(
                                Icons.calendar_month,
                                color: Colors.black38,
                              ),
                            ))),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${staffClasstestController.selectedDate}",
                            style: nunitoExtraBoldTextStyle(
                                fontSize: 15, color: Colors.black87)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("Selected Date",
                            style: nunitoRegularTextStyle(
                                fontSize: 12, color: Colors.black38))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 25.0,
                            backgroundColor: AppColors.darkPinkColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("UKG - A | Tamil",
                                  style: nunitoExtraBoldTextStyle(
                                      fontSize: 15, color: Colors.black87)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("Classtest Not Assign",
                                  style: nunitoRegularTextStyle(
                                      fontSize: 12, color: Colors.black))
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                               // Get.to(StaffAddEntryHomework(1));
                              },
                              child: const Icon(
                                Icons.add,
                                color: AppColors.darkPinkColor,
                              ),
                            ))),
                  ],
                ),
              ),
            ),
          )
        ],
      ),*/
    );
  }
}

class BuildReplyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<StaffClasstestController>(
      init: StaffClasstestController(),
      builder: (staffClasstestController) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          staffClasstestController.selectDate(context, 1);
                        },
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Start Date",
                                  style: nunitoRegularTextStyle(
                                      fontSize: 12, color: Colors.black38)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("${staffClasstestController.startDate}",
                                  style: nunitoExtraBoldTextStyle(
                                      fontSize: 15, color: Colors.black87)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          staffClasstestController.selectDate(context, 2);
                        },
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("End Date",
                                  style: nunitoRegularTextStyle(
                                      fontSize: 12, color: Colors.black38)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("${staffClasstestController.endDate}",
                                  style: nunitoExtraBoldTextStyle(
                                      fontSize: 15, color: Colors.black87)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                              builder: (context) =>
                                  buildSheet(staffClasstestController));
                        },
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Standard & subject",
                                  style: nunitoRegularTextStyle(
                                      fontSize: 12, color: Colors.black38)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("${staffClasstestController.selectedStdTxt}",
                                  overflow: TextOverflow.ellipsis,
                                  style: nunitoExtraBoldTextStyle(
                                      fontSize: 15, color: Colors.black87)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 10,
            color: Colors.black,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: staffClasstestController.classTestReplyListData!=null?staffClasstestController.classTestReplyListData?.length:0,
              itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 25.0,
                        backgroundColor: AppColors.darkPinkColor,
                      ),
                      trailing: InkWell(
                        onTap: ()async {
                          staffClasstestController.studentResultDetailsModel?.code = 0;
                          staffClasstestController.studentResultDetailsFetchId = staffClasstestController.classTestReplyListData?[index].id;
                          staffClasstestController.resultTitleTxt = staffClasstestController.classTestReplyListData?[index].title;
                          staffClasstestController.resultDescriptionTxt = staffClasstestController.classTestReplyListData?[index].description;
                          Get.to(StaffResultClasstest());
                          await staffClasstestController.studentResultDetails();
                          staffClasstestController.maxMarkEditController.text = staffClasstestController.studentResultDetailsModel?.data?.classTestDetail?.resultMax.toString()??"";
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text("Result",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 15, color: AppColors.darkPinkColor)),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${staffClasstestController.classTestReplyListData?[index].code}",
                                style: nunitoExtraBoldTextStyle(
                                    fontSize: 15, color: Colors.black87)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("${staffClasstestController.classTestReplyListData?[index].date}",
                                style: nunitoRegularTextStyle(
                                    fontSize: 10, color: Colors.black)),
                          ],
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${staffClasstestController.classTestReplyListData?[index].title}",
                                style: nunitoExtraBoldTextStyle(
                                    fontSize: 15, color: Colors.black87)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("${staffClasstestController.classTestReplyListData?[index].description}",
                                style: nunitoRegularTextStyle(
                                    fontSize: 10, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),

        ],
      ),
    );
  }
}

Widget buildSheet(StaffClasstestController controller) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Text("Select Standard",
            style: nunitoExtraBoldTextStyle(fontSize: 15, color: Colors.black)),
      ),
      const Divider(
        height: 5,
        color: Colors.black,
      ),
      ListView.builder(
          itemCount: controller.stdList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () async {
                controller.subSelectFlag = 1;
                controller.selectedStdTxt = controller.stdList[index].stdSection;
                controller.selectedStandardUpdate(
                    controller.stdList[index].stdSection ?? "",
                    controller.stdList[index].stdId ?? 0,
                    controller.stdList[index].sectionId ?? 0);
                Get.back();
                await controller.subjectListData();
                controller.stdSubject.isNotEmpty
                    ? showDialog(
                        context: Get.context!,
                        builder: (ctx) {
                          return AlertDialog(
                            contentPadding: const EdgeInsets.all(5),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:10),
                                  child: Text("Select Subject",
                                          style: AppStyles.arimBold.copyWith(
                                              fontSize: 18,
                                              color: AppColors.blackColor))
                                      .paddingOnly(bottom: 15, top: 15),
                                ),
                                const SizedBox(height: 10,),
                                const Divider(
                                  height: 1,
                                  color: Colors.black38,
                                ),
                                const SizedBox(height: 10,),
                                controller.stdSubject.isNotEmpty
                                    ? SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: ListView.builder(
                                            itemCount: controller.stdSubject.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  controller.stdSubjectId = controller.stdSubject[index].stdSubjectId;
                                                  controller.selectedStdTxt = "${controller.selectedStdTxt} ${controller.stdSubject[index].shortSubjectName   }";
                                                  controller.update();
                                                  Get.back();
                                                },
                                                child: Padding(padding: const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  child: Text(
                                                      "${controller.stdSubject[index].shortSubjectName} - ${controller.stdSubject[index].fullSubjectName}",
                                                      style:
                                                      nunitoRegularTextStyle(
                                                          fontSize: 13,
                                                          color: Colors
                                                              .black)),
                                                ),
                                              );
                                            }),
                                      )
                                    : Container(),
                              ],
                            ),
                          );
                        },
                      ):  Get.snackbar("Success","updated" ,snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                //showStaffToastMsg("No Subject Found");
                /*showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        )),
                    builder: (context) => buildStandardSheet(controller));*/
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(controller.stdList[index].stdSection,
                        style: nunitoRegularTextStyle(
                            fontSize: 13, color: Colors.black)),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.black38,
                  ),
                ],
              ),
            );
          }),
      /* Container(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 64,
    // offAxisFraction:0.5,
            // This is called when selected item is changed.
            onSelectedItemChanged: (int selectedItem) {
              controller.selectedStandardUpdate(controller.cTStandardList?.data?[selectedItem].name??"");
            },
            children:
              List<Widget>.generate(controller.cTStandardList?.data?.length??0, (index) => Center(child: Text("${controller.cTStandardList?.data?[index].name}",style: const TextStyle(color: Colors.black),)))

          ),
        )*/
    ],
  );
}

Widget buildStandardSheet(StaffClasstestController controller) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Text("Select Subject",
            style: nunitoExtraBoldTextStyle(fontSize: 15, color: Colors.black)),
      ),
      const Divider(
        height: 5,
        color: Colors.black,
      ),
      ListView.builder(
          itemCount: controller.stdList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                controller.subSelectFlag = 1;
                controller.selectedStandardUpdate(
                    controller.stdList[index].stdSection ?? "",
                    controller.stdList[index].stdId ?? 0,
                    controller.stdList[index].sectionId ?? 0);
                Get.back();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(controller.stdList[index].stdSection,
                        style: nunitoRegularTextStyle(
                            fontSize: 13, color: Colors.black)),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.black38,
                  ),
                ],
              ),
            );
          }),
      /* Container(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 64,
    // offAxisFraction:0.5,
            // This is called when selected item is changed.
            onSelectedItemChanged: (int selectedItem) {
              controller.selectedStandardUpdate(controller.cTStandardList?.data?[selectedItem].name??"");
            },
            children:
              List<Widget>.generate(controller.cTStandardList?.data?.length??0, (index) => Center(child: Text("${controller.cTStandardList?.data?[index].name}",style: const TextStyle(color: Colors.black),)))

          ),
        )*/
    ],
  );
}

class BuildReportBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<StaffClasstestController>(
      init: StaffClasstestController(),
      builder: (staffClasstestController) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          //staffClasstestController.startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                          staffClasstestController.selectDate(context, 1);
                        },
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Start Date",
                                  style: nunitoRegularTextStyle(
                                      fontSize: 12, color: Colors.black38)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("${staffClasstestController.startDate}",
                                  style: nunitoExtraBoldTextStyle(
                                      fontSize: 15, color: Colors.black87)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                        //  staffClasstestController.endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                          staffClasstestController.selectDate(context, 2);
                        },
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("End Date",
                                  style: nunitoRegularTextStyle(
                                      fontSize: 12, color: Colors.black38)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("${staffClasstestController.endDate}",
                                  style: nunitoExtraBoldTextStyle(
                                      fontSize: 15, color: Colors.black87)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  )),
                              builder: (context) =>
                                  buildSheet(staffClasstestController));
                        },
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Standard & subject",
                                  style: nunitoRegularTextStyle(
                                      fontSize: 12, color: Colors.black38)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("${staffClasstestController.selectedStdTxt}",
                                  overflow: TextOverflow.ellipsis,
                                  style: nunitoExtraBoldTextStyle(
                                      fontSize: 15, color: Colors.black87)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 10,
            color: Colors.black,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: staffClasstestController.classTestReplyListData!=null?staffClasstestController.classTestReplyListData?.length:0,
              itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 25.0,
                        backgroundColor: AppColors.darkPinkColor,
                      ),
                      trailing: InkWell(
                        onTap: ()async {
                          staffClasstestController.studentResultDetailsModel?.code = 0;
                          staffClasstestController.studentResultDetailsFetchId = staffClasstestController.classTestReplyListData?[index].id;
                          staffClasstestController.resultTitleTxt = staffClasstestController.classTestReplyListData?[index].title;
                          staffClasstestController.resultDescriptionTxt = staffClasstestController.classTestReplyListData?[index].description;
                          Get.to(StaffReportClasstest());
                          await staffClasstestController.studentResultDetails();
                          staffClasstestController.maxMarkEditController.text = staffClasstestController.studentResultDetailsModel?.data?.classTestDetail?.resultMax.toString()??"";
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text("Report",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 15, color: AppColors.darkPinkColor)),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${staffClasstestController.classTestReplyListData?[index].code}",
                                style: nunitoExtraBoldTextStyle(
                                    fontSize: 15, color: Colors.black87)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("${staffClasstestController.classTestReplyListData?[index].date}",
                                style: nunitoRegularTextStyle(
                                    fontSize: 10, color: Colors.black)),
                          ],
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${staffClasstestController.classTestReplyListData?[index].title}",
                                style: nunitoExtraBoldTextStyle(
                                    fontSize: 15, color: Colors.black87)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("${staffClasstestController.classTestReplyListData?[index].description}",
                                style: nunitoRegularTextStyle(
                                    fontSize: 10, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),

        ],
      ),
    );
  }
}
