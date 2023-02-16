import 'package:flutter/material.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:flutter_projects/common/widgets/staff_common_widgets.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_add_entry_screen.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_reply_screen.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controller/daily_activities/homework_controller/homework_class_teacher_controller.dart';

class StaffClassTeacherViewHomework extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffClassTeacherHomeworkController>(
        init: StaffClassTeacherHomeworkController(),
        builder: (staffClassTeacherHomeworkController) => Scaffold(
            appBar: smsAppbar("Homework Class Teacher"),
            body: staffClassTeacherHomeworkController
                .list[staffClassTeacherHomeworkController.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.darkPinkColor,
              currentIndex: staffClassTeacherHomeworkController.currentIndex,
              onTap: (index) {
                staffClassTeacherHomeworkController.selectedStdTxt =
                    "Select Standard";
                staffClassTeacherHomeworkController.selectedStdValue = 0;
                staffClassTeacherHomeworkController.selectedSectionValue = 0;
                staffClassTeacherHomeworkController.updateIndex(index);
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
              ],
            ),
            floatingActionButton:
                staffClassTeacherHomeworkController.currentIndex != 0
                    ? FloatingActionButton(
                        onPressed: () {
                          staffClassTeacherHomeworkController
                              .replyHomeworkData();
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
    return GetBuilder<StaffClassTeacherHomeworkController>(
      init: StaffClassTeacherHomeworkController(),
      builder: (staffClassTeacherHomeworkController) =>
          staffClassTeacherHomeworkController.cTStandardList?.code == 200
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Class Teacher Standard",
                                        style: nunitoRegularTextStyle(
                                            fontSize: 15,
                                            color: Colors.black87)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => buildSheet(
                                                staffClassTeacherHomeworkController));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.89,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black38),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                              "${staffClassTeacherHomeworkController.selectedStdTxt}",
                                              style: nunitoExtraBoldTextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "Click the select box to select the standard list\n section will be displayed on below",
                                        style: nunitoRegularTextStyle(
                                            fontSize: 12,
                                            color: Colors.black38)),
                                  ],
                                ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("View Class Teacher Homework",
                                          style: nunitoRegularTextStyle(
                                              fontSize: 15,
                                              color: Colors.black87)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Click the icon to select the date to view current and previous Homework",
                                          style: nunitoRegularTextStyle(
                                              fontSize: 12,
                                              color: Colors.black38))
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            staffClassTeacherHomeworkController
                                                .selectDate(context, 3);
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${staffClassTeacherHomeworkController.selectedDate}",
                                        style: nunitoExtraBoldTextStyle(
                                            fontSize: 15,
                                            color: Colors.black87)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text("Selected Date",
                                        style: nunitoRegularTextStyle(
                                            fontSize: 12,
                                            color: Colors.black38))
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (staffClassTeacherHomeworkController
                                            .selectedStdValue ==
                                        0) {
                                      //showStaffToastMsg("Select Standard");
                                    } else {
                                      staffClassTeacherHomeworkController
                                          .classTeacherViewHomeworkData
                                          ?.clear();
                                      staffClassTeacherHomeworkController
                                          .viewHomeworkData();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.darkPinkColor,
                                    foregroundColor: AppColors.whiteColor,
                                    minimumSize: const Size(30, 35),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text("Submit",
                                      style: nunitoExtraBoldTextStyle(
                                          fontSize: 15, color: Colors.white)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      staffClassTeacherHomeworkController
                                  .classTeacherViewHomeworkModel?.code ==
                              200
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: staffClassTeacherHomeworkController
                                  .classTeacherViewHomeworkData?.length,
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
                                                        "${staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].standardSectionName} | ${staffClassTeacherHomeworkController.classTeacherViewHomeworkModel?.data?[index].subjectName}",
                                                        style:
                                                            nunitoExtraBoldTextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black87)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    staffClassTeacherHomeworkController
                                                                .classTeacherViewHomeworkData?[
                                                                    index]
                                                                .homework !=
                                                            null
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                color: staffClassTeacherHomeworkController
                                                                            .classTeacherViewHomeworkData?[
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
                                                                              .all(
                                                                          5.0),
                                                                  child: Text(
                                                                    staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].homework?.approvalType ==
                                                                            1
                                                                        ? "Approved"
                                                                        : "Not Approved",
                                                                    style: const TextStyle(
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
                                                                  "${staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].homework?.title}",
                                                                  style: nunitoExtraBoldTextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black)),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                  "${staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].homework?.description}",
                                                                  style: nunitoRegularTextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black))
                                                            ],
                                                          )
                                                        : Text(
                                                            "Homework not Assigned",
                                                            style:
                                                                nunitoRegularTextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      int value =
                                                          await staffClassTeacherHomeworkController
                                                              .checkSettings();
                                                      if (value == 200) {
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 1));
                                                        if (staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].homework == null) {
                                                          staffClassTeacherHomeworkController.titleEditController.text = "";
                                                          staffClassTeacherHomeworkController.descriptionEditController.text = "";
                                                          Get.to(StaffAddEntryHomework(
                                                            type: 1,
                                                            hwId: staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].id,
                                                            sectionSubjectItemId: staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].sectionSubjectItemId,
                                                            selectedDate: staffClassTeacherHomeworkController.selectedDate,
                                                          ));
                                                        } else {
                                                          staffClassTeacherHomeworkController.attachmentList?.clear();
                                                          staffClassTeacherHomeworkController.attachmentList = staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].homework?.images;
                                                          Get.to(StaffAddEntryHomework(
                                                            type: 2,
                                                            hwId: staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].id,
                                                            sectionSubjectItemId: staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].sectionSubjectItemId,
                                                            selectedDate: staffClassTeacherHomeworkController.selectedDate,
                                                            title: staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].homework?.title,
                                                            description: staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].homework?.description,
                                                            hwItemId: staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].homework?.id,
                                                            approvalType: staffClassTeacherHomeworkController.classTeacherViewHomeworkData?[index].homework?.approvalType,
                                                          ));
                                                        }
                                                      }
                                                    },
                                                    child: staffClassTeacherHomeworkController
                                                                .classTeacherViewHomeworkData?[
                                                                    index]
                                                                .homework ==
                                                            null
                                                        ? const Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .darkPinkColor,
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
                              })
                          : Container(),
                    ],
                  ),
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

Widget buildSheet(StaffClassTeacherHomeworkController controller) {
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
          itemCount: controller.cTStandardList?.data?.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                controller.selectedStandardUpdate(
                    controller.cTStandardList?.data?[index].name ?? "",
                    controller.cTStandardList?.data?[index].standardId ?? 0,
                    controller.cTStandardList?.data?[index].groupSectionId ??
                        0);
                Get.back();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                        "${controller.cTStandardList?.data?[index].name}",
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

class BuildReplyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffClassTeacherHomeworkController>(
      init: StaffClassTeacherHomeworkController(),
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
            height: Get.height*0.7,
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
                                onTap: ()async {
                                  staffClassTeacherHomeworkController.multiReplySelect = false;
                                  staffClassTeacherHomeworkController.overallReplySelect = false;
                                  staffClassTeacherHomeworkController.studentReplyList?.clear();
                                  staffClassTeacherHomeworkController.replyId = staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].id;
                                  staffClassTeacherHomeworkController.studentReplyData();
                                  staffClassTeacherHomeworkController.staffReplyEntryList?.clear();
                                  Get.to(StaffReplyHomework());


                                  /*int result = await staffClassTeacherHomeworkController.studentReplyData(staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].id??0);
                                  if(result==200){

                                  }*/

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child:staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].edit==true?Text("Reply",
                                      style: nunitoExtraBoldTextStyle(
                                          fontSize: 15,
                                          color: AppColors.darkPinkColor)):Container(),
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].code}",
                                        style: nunitoExtraBoldTextStyle(
                                            fontSize: 15, color: Colors.black87)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text("${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].date}",
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
                                    Text("${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].title}",
                                        style: nunitoExtraBoldTextStyle(
                                            fontSize: 15, color: Colors.black87)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text("${staffClassTeacherHomeworkController.staffHomeworkReplyList?.data?[index].description}",
                                        style: nunitoRegularTextStyle(
                                            fontSize: 10, color: Colors.black)),
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
