import 'package:flutter/material.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_add_entry_screen.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_class_teacher_view_screen.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_reply_staff_screen.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_subject_add_entry_screen.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../common/widgets/staff_common_widgets.dart';
import '../../../../controller/daily_activities/homework_controller/homework_controller.dart';

class StaffViewHomework extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffHomeworkController>(
        init: StaffHomeworkController(),
        builder: (staffHomeworkController) => Scaffold(
            appBar: smsAppbar("Homework"),
            body: staffHomeworkController
                .list[staffHomeworkController.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.darkPinkColor,
              currentIndex: staffHomeworkController.currentIndex,
              onTap: (index) {
                staffHomeworkController.updateIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Today",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Reply",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Report",
                ),
              ],
            ),
            floatingActionButton: staffHomeworkController.currentIndex != 0
                ? FloatingActionButton(
                    onPressed: () {
                      if (staffHomeworkController.subSelectFlag != 0) {
                        staffHomeworkController.replyHomeworkData();
                      } else {
                        //showStaffToastMsg("Select Standard");
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
    return GetBuilder<StaffHomeworkController>(
      init: StaffHomeworkController(),
      builder: (staffHomeworkController) => staffHomeworkController
                      .subjectTeacherViewHomeworkModel?.data !=
                  null &&
              staffHomeworkController.subjectTeacherViewHomeworkModel!.code ==
                  200
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
                                Text("Class Teacher Homework",
                                    style: nunitoRegularTextStyle(
                                        fontSize: 15, color: Colors.black87)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "Click the icon to view current and previous Homework",
                                    style: nunitoRegularTextStyle(
                                        fontSize: 12, color: Colors.black38))
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Get.to(StaffClassTeacherViewHomework());
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
                                Text("View Homework",
                                    style: nunitoRegularTextStyle(
                                        fontSize: 15, color: Colors.black87)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "Click the icon to select the date to view current and previous Homework",
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
                                      staffHomeworkController.selectDate(
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
                              Text("${staffHomeworkController.selectedDate}",
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
                      itemCount: staffHomeworkController
                          .subjectTeacherViewHomeworkData?.length,
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
                                                "${staffHomeworkController.subjectTeacherViewHomeworkData?[index].standardSectionName} | ${staffHomeworkController.subjectTeacherViewHomeworkData?[index].subjectName}",
                                                style: nunitoExtraBoldTextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black87)),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            staffHomeworkController
                                                        .subjectTeacherViewHomeworkData?[
                                                            index]
                                                        .homework !=
                                                    null
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        color: staffHomeworkController
                                                                    .subjectTeacherViewHomeworkData?[
                                                                        index]
                                                                    .homework
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
                                                            staffHomeworkController
                                                                        .subjectTeacherViewHomeworkData?[
                                                                            index]
                                                                        .homework
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
                                                          "${staffHomeworkController.subjectTeacherViewHomeworkData?[index].homework?.title}",
                                                          style:
                                                              nunitoExtraBoldTextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          "${staffHomeworkController.subjectTeacherViewHomeworkData?[index].homework?.description}",
                                                          style:
                                                              nunitoRegularTextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black))
                                                    ],
                                                  )
                                                : Text("Homework not Assigned",
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
                                              int value = await staffHomeworkController.checkSettings();
                                              if (value == 200) {
                                                Future.delayed(const Duration(seconds: 1));
                                                if (staffHomeworkController.subjectTeacherViewHomeworkData?[index].homework == null) {
                                                  staffHomeworkController.titleEditController.text = "";
                                                  staffHomeworkController.descriptionEditController.text = "";
                                                  Get.to(SubjectStaffAddEntryHomework(
                                                    type: 1,
                                                    hwId: staffHomeworkController.subjectTeacherViewHomeworkData?[index].id,
                                                    sectionSubjectItemId: staffHomeworkController.subjectTeacherViewHomeworkData?[index].sectionSubjectItemId,
                                                    selectedDate: staffHomeworkController.selectedDate,
                                                  ));
                                                } else {
                                                  staffHomeworkController.attachmentList?.clear();
                                                  staffHomeworkController.attachmentList = staffHomeworkController.subjectTeacherViewHomeworkData?[index].homework?.images;
                                                  Get.to(StaffAddEntryHomework(
                                                    type: 2,
                                                    hwId: staffHomeworkController
                                                        .subjectTeacherViewHomeworkData?[
                                                            index]
                                                        .id,
                                                    sectionSubjectItemId:
                                                        staffHomeworkController
                                                            .subjectTeacherViewHomeworkData?[
                                                                index]
                                                            .sectionSubjectItemId,
                                                    selectedDate:
                                                        staffHomeworkController
                                                            .selectedDate,
                                                    title: staffHomeworkController.subjectTeacherViewHomeworkData?[index].homework?.title,
                                                    description:
                                                        staffHomeworkController
                                                            .subjectTeacherViewHomeworkData?[
                                                                index]
                                                            .homework
                                                            ?.description,
                                                    hwItemId:
                                                        staffHomeworkController
                                                            .subjectTeacherViewHomeworkData?[
                                                                index]
                                                            .homework
                                                            ?.id,
                                                    approvalType:
                                                        staffHomeworkController
                                                            .subjectTeacherViewHomeworkData?[
                                                                index]
                                                            .homework
                                                            ?.approvalType,
                                                  ));
                                                }
                                              }
                                            },
                                            child: staffHomeworkController
                                                        .subjectTeacherViewHomeworkData?[
                                                            index]
                                                        .homework ==
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
    );
  }
}

class BuildReplyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffHomeworkController>(
      init: StaffHomeworkController(),
      builder: (staffClassTeacherHomeworkController) => Column(
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
                          staffClassTeacherHomeworkController.selectDate(
                              context, 1);
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
                              Text(
                                  "${staffClassTeacherHomeworkController.startDate}",
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
                          staffClassTeacherHomeworkController.selectDate(
                              context, 2);
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
                              Text(
                                  "${staffClassTeacherHomeworkController.endDate}",
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
                              builder: (context) => buildSheet(
                                  staffClassTeacherHomeworkController));
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
                              Text(
                                  "${staffClassTeacherHomeworkController.selectedStdTxt}",
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
          staffClassTeacherHomeworkController.staffHomeworkReplyList?.code ==
                  200
              ? SingleChildScrollView(
                  child: SizedBox(
                    height: Get.height * 0.7,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: staffClassTeacherHomeworkController
                            .staffHomeworkReplyList?.data?.length,
                        itemBuilder: (BuildContext context, int index) {
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
                                  onTap: () async {
                                    staffClassTeacherHomeworkController
                                        .multiReplySelect = false;
                                    staffClassTeacherHomeworkController
                                        .overallReplySelect = false;
                                    staffClassTeacherHomeworkController
                                        .studentReplyList
                                        ?.clear();
                                    staffClassTeacherHomeworkController
                                            .replyId =
                                        staffClassTeacherHomeworkController
                                            .staffHomeworkReplyList
                                            ?.data?[index]
                                            .id;
                                    staffClassTeacherHomeworkController
                                        .studentReplyData();
                                    staffClassTeacherHomeworkController
                                        .staffReplyEntryList
                                        ?.clear();
                                    Get.to(StaffReplyStaffHomework());

                                    /*int result = await staffClassTeacherHomeworkController.studentReplyData(staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].id??0);
                                  if(result==200){

                                  }*/
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: staffClassTeacherHomeworkController
                                                .staffHomeworkReplyList
                                                ?.data?[index]
                                                .edit ==
                                            true
                                        ? Text("Reply",
                                            style: nunitoExtraBoldTextStyle(
                                                fontSize: 15,
                                                color: AppColors.darkPinkColor))
                                        : Container(),
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].code}",
                                          style: nunitoExtraBoldTextStyle(
                                              fontSize: 15,
                                              color: Colors.black87)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].date}",
                                          style: nunitoRegularTextStyle(
                                              fontSize: 10,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].title}",
                                          style: nunitoExtraBoldTextStyle(
                                              fontSize: 15,
                                              color: Colors.black87)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].description}",
                                          style: nunitoRegularTextStyle(
                                              fontSize: 10,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

Widget buildSheet(StaffHomeworkController controller) {
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
    return GetBuilder<StaffHomeworkController>(
      init: StaffHomeworkController(),
      builder: (staffClassTeacherHomeworkController) {
        return staffClassTeacherHomeworkController
                    .subjectTeacherStandardListModel?.code ==
                200
            ? Column(
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
                                  staffClassTeacherHomeworkController
                                      .selectDate(context, 1);
                                },
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Start Date",
                                          style: nunitoRegularTextStyle(
                                              fontSize: 12,
                                              color: Colors.black38)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${staffClassTeacherHomeworkController.startDate}",
                                          style: nunitoExtraBoldTextStyle(
                                              fontSize: 15,
                                              color: Colors.black87)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  staffClassTeacherHomeworkController
                                      .selectDate(context, 2);
                                },
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("End Date",
                                          style: nunitoRegularTextStyle(
                                              fontSize: 12,
                                              color: Colors.black38)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${staffClassTeacherHomeworkController.endDate}",
                                          style: nunitoExtraBoldTextStyle(
                                              fontSize: 15,
                                              color: Colors.black87)),
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
                                      builder: (context) => buildSheet(
                                          staffClassTeacherHomeworkController));
                                },
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Standard & subject",
                                          style: nunitoRegularTextStyle(
                                              fontSize: 12,
                                              color: Colors.black38)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${staffClassTeacherHomeworkController.selectedStdTxt}",
                                          overflow: TextOverflow.ellipsis,
                                          style: nunitoExtraBoldTextStyle(
                                              fontSize: 15,
                                              color: Colors.black87)),
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
                  staffClassTeacherHomeworkController
                              .staffHomeworkReplyList?.code ==
                          200
                      ? SingleChildScrollView(
                          child: SizedBox(
                            height: Get.height * 0.7,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: staffClassTeacherHomeworkController
                                    .staffHomeworkReplyList?.data?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Card(
                                      elevation: 5,
                                      child: ListTile(
                                        leading: const CircleAvatar(
                                          radius: 25.0,
                                          backgroundColor:
                                              AppColors.darkPinkColor,
                                        ),
                                        trailing: InkWell(
                                          onTap: () async {
                                            staffClassTeacherHomeworkController
                                                .multiReplySelect = false;
                                            staffClassTeacherHomeworkController
                                                .overallReplySelect = false;
                                            staffClassTeacherHomeworkController
                                                .studentReplyList
                                                ?.clear();
                                            staffClassTeacherHomeworkController
                                                    .replyId =
                                                staffClassTeacherHomeworkController
                                                    .staffHomeworkReplyList
                                                    ?.data?[index]
                                                    .id;
                                            staffClassTeacherHomeworkController
                                                .studentReplyData();
                                            staffClassTeacherHomeworkController
                                                .staffReplyEntryList
                                                ?.clear();
                                            Get.to(StaffReplyStaffHomework());

                                            /*int result = await staffClassTeacherHomeworkController.studentReplyData(staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].id??0);
                                  if(result==200){

                                  }*/
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: staffClassTeacherHomeworkController
                                                        .staffHomeworkReplyList
                                                        ?.data?[index]
                                                        .edit ==
                                                    true
                                                ? Text("Reply",
                                                    style:
                                                        nunitoExtraBoldTextStyle(
                                                            fontSize: 15,
                                                            color: AppColors
                                                                .darkPinkColor))
                                                : Container(),
                                          ),
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].code}",
                                                  style:
                                                      nunitoExtraBoldTextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black87)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].date}",
                                                  style: nunitoRegularTextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].title}",
                                                  style:
                                                      nunitoExtraBoldTextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black87)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].description}",
                                                  style: nunitoRegularTextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      : Container(),
                ],
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}
