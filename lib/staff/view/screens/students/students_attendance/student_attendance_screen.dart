import 'package:flutter/material.dart';
import '../../../../controller/students_controller/students_sttendance_controller.dart';
import 'student_new_attendance_screen.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../common/widgets/staff_common_widgets.dart';
import '../../../../../parent/themes/app_styles.dart';
import '../../../../model/standard_students_list_model.dart';

class StudentAttendanceDetailsScreen extends StatelessWidget {
  const StudentAttendanceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Students Attendance",
                style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18)),
            actions: [
              GetBuilder<StudentsAttendanceController>(
                  init: StudentsAttendanceController(),
                  builder: (controller) {
                    return InkWell(
                      onTap: () {
                        controller.clearData();
                        Get.to(const StudentNewAttendanceScreen());
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add,
                          color: AppColors.whiteColor,
                          size: 20,
                        ),
                      ),
                    );
                  })
            ],
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.whiteColor,
                  size: 28,
                )),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[AppColors.indigo1Color, AppColors.indigo2Color],
              )),
            )),
        body: GetBuilder<StudentsAttendanceController>(
            init: StudentsAttendanceController(),
            builder: (controller) {
              return Column(children: [
                Card(
                  elevation: 10,
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SelectDateAndStudentDetails(controller: controller),
                      SMSButtonWidget(
                        onPress: () async {
                          controller.standardId = controller
                                  .filterStudentsStandardListData[
                                      controller.studentsListSelectedIndex]
                                  .section?[controller.studentsListSectionIndex]
                                  .standardId ??
                              0;
                          controller.groupSectionId = controller
                                  .filterStudentsStandardListData[
                                      controller.studentsListSelectedIndex]
                                  .section?[controller.studentsListSectionIndex]
                                  .id ??
                              0;
                          if (controller.selectedDate != "") {
                            if (controller.studentsListSelectedIndex != 0) {
                              await controller.fetchStudentsAttendanceData();
                            } else {
                              //showStaffToastMsg("Select Student Standard");
                            }
                          } else {
                           // showStaffToastMsg("Select Date");
                          }
                        },
                        text: "SEARCH",
                        width: Get.width * 0.1,
                        height: 30,
                        borderRadius: 5,
                        fontSize: 12,
                        primaryColor: AppColors.darkPinkColor,
                      ),
                    ],
                  ),
                ),
                if (controller.isLoading)
                  const Center(child: CircularProgressIndicator.adaptive()),
                if (controller.studentsAttendanceList.isEmpty)
                  const Center(child: Text(" "))
                else
                  Expanded(
                      child: ListView.builder(
                          itemCount: controller.studentsAttendanceList.length,
                          // shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                      controller.studentsAttendanceList[index]
                                              .firstName ??
                                          "",
                                      style: AppStyles.NunitoExtrabold.copyWith(
                                          fontSize: 13,
                                          color: AppColors.blackColor),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    leading: Container(
                                            width: 40.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(controller
                                                            .studentsAttendanceList[
                                                                index]
                                                            .photo ??
                                                        ""))))
                                        .paddingOnly(left: 0),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          controller
                                                      .studentsAttendanceList[
                                                          index]
                                                      .attendance ==
                                                  null
                                              ? "NA"
                                              : controller
                                                          .studentsAttendanceList[
                                                              index]
                                                          .attendance
                                                          ?.leaveTypeId ==
                                                      1
                                                  ? "${controller.studentsAttendanceList[index].attendance?.leaveName.toString()}"
                                                  : controller
                                                              .studentsAttendanceList[
                                                                  index]
                                                              .attendance
                                                              ?.leaveTypeId ==
                                                          2
                                                      ? "Full Day Absent"
                                                      : controller
                                                                  .studentsAttendanceList[
                                                                      index]
                                                                  .attendance
                                                                  ?.leaveTypeId ==
                                                              3
                                                          ? "AM Absent"
                                                          : controller
                                                                      .studentsAttendanceList[
                                                                          index]
                                                                      .attendance
                                                                      ?.leaveTypeId ==
                                                                  4
                                                              ? "PM Absent"
                                                              : "",
                                          style: AppStyles.NunitoExtrabold.copyWith(
                                              fontSize: 13,
                                              color: ((controller
                                                              .studentsAttendanceList[
                                                                  index]
                                                              .attendance !=
                                                          null) &&
                                                      (controller
                                                                  .studentsAttendanceList[
                                                                      index]
                                                                  .attendance
                                                                  ?.leaveTypeId ==
                                                              2 ||
                                                          controller
                                                                  .studentsAttendanceList[
                                                                      index]
                                                                  .attendance
                                                                  ?.leaveTypeId ==
                                                              3 ||
                                                          controller
                                                                  .studentsAttendanceList[
                                                                      index]
                                                                  .attendance
                                                                  ?.leaveTypeId ==
                                                              4))
                                                  ? AppColors.redColor
                                                  : AppColors.blackColor),
                                        ).paddingOnly(right: 20),
                                        ((controller
                                                        .studentsAttendanceList[
                                                            index]
                                                        .attendance !=
                                                    null) &&
                                                (controller
                                                        .studentsAttendanceList[
                                                            index]
                                                        .attendance
                                                        ?.leaveTypeId ==
                                                    1))
                                            ? const Icon(
                                                Icons.check_circle,
                                                color: AppColors.darkGreenColor,
                                                size: 18,
                                              )
                                            : ((controller
                                                            .studentsAttendanceList[
                                                                index]
                                                            .attendance !=
                                                        null) &&
                                                    (controller
                                                                .studentsAttendanceList[
                                                                    index]
                                                                .attendance
                                                                ?.leaveTypeId ==
                                                            2 ||
                                                        controller
                                                                .studentsAttendanceList[
                                                                    index]
                                                                .attendance
                                                                ?.leaveTypeId ==
                                                            3 ||
                                                        controller
                                                                .studentsAttendanceList[
                                                                    index]
                                                                .attendance
                                                                ?.leaveTypeId ==
                                                            4))
                                                ? Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: AppColors
                                                                .redColor,
                                                            shape: BoxShape
                                                                .circle),
                                                    child: const Icon(
                                                      Icons.clear,
                                                      color:
                                                          AppColors.whiteColor,
                                                      size: 15,
                                                    ),
                                                  )
                                                : Container()
                                      ],
                                    ),
                                  ).paddingOnly(top: 5),
                                  (controller.studentsAttendanceList[index]
                                                  .attendance !=
                                              null &&
                                          controller
                                                  .studentsAttendanceList[index]
                                                  .attendance
                                                  ?.lateTime !=
                                              null)
                                      ? Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .directions_run_outlined,
                                                    size: 20,
                                                    color:
                                                        AppColors.indigo1Color,
                                                  ).paddingOnly(left: 10),
                                                  Text("Late comer",
                                                      style: AppStyles
                                                          .arimoRegular
                                                          .copyWith(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      )),
                                                ],
                                              ),
                                            ).paddingOnly(
                                                left: 10, bottom: 5, top: 0),
                                            Text(
                                                controller
                                                        .studentsAttendanceList[
                                                            index]
                                                        .attendance
                                                        ?.lateTime ??
                                                    "",
                                                style:
                                                    AppStyles.arimBold.copyWith(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                )).paddingOnly(left: 10),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            );
                          }))
              ]);
            }));
  }
}

class SelectDateAndStudentDetails extends StatelessWidget {
  final StudentsAttendanceController controller;

  const SelectDateAndStudentDetails({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: AppColors.redColor,
                    size: 15,
                  ).paddingOnly(right: 5),
                  Text("Date",
                      style: AppStyles.NunitoRegular.copyWith(fontSize: 12))
                ],
              ).paddingOnly(bottom: 10, top: 10),
              InkWell(
                onTap: () async {
                  controller.selectDate(Get.context!);
                },
                child: Text(
                    controller.selectedDate != ""
                        ? controller.selectedDate
                        : "Click to select",
                    style: AppStyles.NunitoExtrabold.copyWith(fontSize: 14)),
              ),
            ],
          ),
          const VerticalDivider(
            color: Colors.grey,
            thickness: 1,
          ).paddingOnly(top: 10, bottom: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(" Standard ",
                      style: AppStyles.NunitoRegular.copyWith(fontSize: 12))
                  .paddingOnly(bottom: 10, top: 10),
              InkWell(
                onTap: () async {
                  controller.filterStudentsStandardListData = [
                    StudentStandardListData(
                        fullName: "Select ",
                        section: [Section(fullName: "Std")])
                  ];
                  await controller.fetchStandardStudentsList();
                  showModalBottomSheet(
                      context: Get.context!,
                      builder: (context) =>
                          StandardStudentsBottomSheet(controller: controller));
                },
                child: Row(
                  children: [
                    Text(
                        controller.filterStudentsStandardListData.isNotEmpty
                            ? "${controller.filterStudentsStandardListData[controller.studentsListSelectedIndex].fullName} - ${controller.filterStudentsStandardListData[controller.studentsListSelectedIndex].section?[controller.studentsListSectionIndex].fullName ?? ""}"
                            : "",
                        style:
                            AppStyles.NunitoExtrabold.copyWith(fontSize: 14)),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.greyColor,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class StandardStudentsBottomSheet extends StatelessWidget {
  final StudentsAttendanceController controller;

  const StandardStudentsBottomSheet({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 1,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Item",
                      style: AppStyles.NunitoExtrabold.copyWith(fontSize: 16)),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: AppColors.redColor,
                    ).paddingOnly(right: 20),
                  ),
                ],
              ).paddingOnly(left: 20,top: 20),
              TextFormField(
                onChanged: (value) async {
                  if (value.length > 3) {
                    controller.filterStandardStudentsResults(value);
                  }
                  if (value.isEmpty) {
                    controller.filterStudentsStandardListData = [
                      StudentStandardListData(
                          fullName: "Select ",
                          section: [Section(fullName: "Std")])
                    ];
                    await controller.fetchStandardStudentsList();
                  }
                },
                decoration: InputDecoration(
                    prefix: const Icon(
                      Icons.search_rounded,
                      color: AppColors.greyColor,
                    ).paddingOnly(right: 20, left: 20),
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: "Search",
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              controller.filterStudentsStandardListData.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount:
                              controller.filterStudentsStandardListData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller
                                        .filterStudentsStandardListData[index]
                                        .section
                                        ?.length ??
                                    0,
                                shrinkWrap: true,
                                itemBuilder: (context, index1) {
                                  return InkWell(
                                    onTap: () {
                                      controller.updateStudentListValue(
                                          index, index1);
                                      controller.studentsAttendanceList = [];
                                      Get.back();
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${controller.filterStudentsStandardListData[index].fullName} - ${controller.filterStudentsStandardListData[index].section?[index1].fullName ?? ""}")
                                            .paddingSymmetric(
                                            horizontal: 25, vertical: 18),
                                        dividerWidget()
                                      ],
                                    )
                                  );
                                });
                          }),
                    )
                  : Container()
            ],
          );
        });
  }
}
