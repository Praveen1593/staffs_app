import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/common_widgets.dart';
import 'package:flutter_projects/staff/view/screens/students/students_attendance/student_attendance_screen.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../../common/widgets/staff_common_widgets.dart';
import '../../../../controller/students_controller/students_sttendance_controller.dart';
import '../../../../themes/app_styles.dart';

class StudentNewAttendanceScreen extends StatelessWidget {
  const StudentNewAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: smsAppbar("New Attendance"),
        body: GetBuilder<StudentsAttendanceController>(
            tag: "new",
            init: StudentsAttendanceController(),
            didChangeDependencies: (state) {
              Future.delayed(const Duration(seconds: 0), () {
                state.controller?.clearData();
              });
            },
            builder: (controller) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(children: [
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
                                            controller
                                                .studentsListSelectedIndex]
                                        .section?[
                                            controller.studentsListSectionIndex]
                                        .standardId ??
                                    0;
                                controller.groupSectionId = controller
                                        .filterStudentsStandardListData[
                                            controller
                                                .studentsListSelectedIndex]
                                        .section?[
                                            controller.studentsListSectionIndex]
                                        .id ??
                                    0;
                                controller.studentsAttendanceList = [];
                                if (controller.selectedDate != "") {
                                  if (controller.studentsListSelectedIndex !=
                                      0) {
                                    await controller
                                        .fetchStudentsAttendanceData();
                                  } else {
                                    // showStaffToastMsg(
                                    //     "Select Student Standard");
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
                      Text(
                        "Note:AM-Morning Absent | PM - Afternoon Absent",
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ).paddingAll(8),
                      if (controller.isLoading)
                        const Center(
                            child: CircularProgressIndicator.adaptive()),
                      if (controller.studentsAttendanceList.isEmpty)
                        const Center(child: Text(" "))
                      else
                        SizedBox(
                          height: Get.height * 0.6,
                          child: ListView.builder(
                              itemCount:
                                  controller.studentsAttendanceList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    elevation: 5,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    width: 45.0,
                                                    height: 45.0,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                                controller
                                                                        .studentsAttendanceList[
                                                                            index]
                                                                        .photo ??
                                                                    "")))),
                                                Text(
                                                  "${controller.studentsAttendanceList[index].firstName}",
                                                  style:
                                                      AppStyles.NunitoExtrabold
                                                          .copyWith(
                                                              fontSize: 15,
                                                              color: AppColors
                                                                  .blackColor),
                                                ).paddingOnly(left: 25),
                                              ],
                                            ),
                                            Visibility(
                                              visible: (controller
                                                              .studentsAttendanceList[
                                                                  index]
                                                              .flag ==
                                                          1 ||
                                                      controller
                                                              .studentsAttendanceList[
                                                                  index]
                                                              .flag ==
                                                          2 ||
                                                      (controller
                                                                  .studentsAttendanceList[
                                                                      index]
                                                                  .attendance !=
                                                              null &&
                                                          controller
                                                                  .studentsAttendanceList[
                                                                      index]
                                                                  .attendance!
                                                                  .leaveTypeId ==
                                                              1) ||
                                                      (controller
                                                                  .studentsAttendanceList[
                                                                      index]
                                                                  .attendance !=
                                                              null &&
                                                          controller
                                                                  .studentsAttendanceList[
                                                                      index]
                                                                  .attendance!
                                                                  .leaveTypeId ==
                                                              2))
                                                  ? true
                                                  : false,
                                              child: InkWell(
                                                onTap: () {
                                                  controller
                                                          .studentsAttendanceList[
                                                              index]
                                                          .remarkFlag =
                                                      !controller
                                                          .studentsAttendanceList[
                                                              index]
                                                          .remarkFlag;
                                                  controller.update();
                                                },
                                                child: Text(
                                                  "Remark",
                                                  style: AppStyles
                                                          .NunitoExtrabold
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: AppColors
                                                              .darkPinkColor),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                                value: 1,
                                                groupValue: controller
                                                    .studentsAttendanceList[
                                                        index]
                                                    .flag,
                                                activeColor:
                                                    AppColors.darkPinkColor,
                                                onChanged: (changedValue) {
                                                  controller
                                                      .studentsAttendanceList[
                                                          index]
                                                      .flag = changedValue ?? 0;

                                                  controller.update();
                                                }),
                                            Text("Present"),
                                            Radio(
                                                value: 2,
                                                groupValue: controller
                                                    .studentsAttendanceList[
                                                        index]
                                                    .flag,
                                                activeColor:
                                                    AppColors.darkPinkColor,
                                                onChanged: (changedValue) {
                                                  controller
                                                      .studentsAttendanceList[
                                                          index]
                                                      .flag = changedValue ?? 0;
                                                  controller
                                                      .studentsAttendanceList[
                                                          index]
                                                      .time = "ENTER TIME";
                                                  controller.update();
                                                }),
                                            Text("Absent"),
                                            Radio(
                                                value: 3,
                                                groupValue: controller
                                                    .studentsAttendanceList[
                                                        index]
                                                    .flag,
                                                activeColor:
                                                    AppColors.darkPinkColor,
                                                onChanged: (changedValue) {
                                                  controller
                                                      .studentsAttendanceList[
                                                          index]
                                                      .flag = changedValue ?? 0;
                                                  controller.update();
                                                }),
                                            Text("AM"),
                                            Radio(
                                                value: 4,
                                                groupValue: controller
                                                    .studentsAttendanceList[
                                                        index]
                                                    .flag,
                                                activeColor:
                                                    AppColors.darkPinkColor,
                                                onChanged: (changedValue) {
                                                  controller
                                                      .studentsAttendanceList[
                                                          index]
                                                      .flag = changedValue ?? 0;
                                                  controller.update();
                                                }),
                                            Text("PM"),
                                          ],
                                        ),
                                        if (controller
                                                    .studentsAttendanceList[
                                                        index]
                                                    .attendance !=
                                                null &&
                                            controller
                                                .studentsAttendanceList[index]
                                                .attendance!
                                                .remark!
                                                .isNotEmpty)
                                          _buildTextFormField(controller, index)
                                        else if ((controller
                                                        .studentsAttendanceList[
                                                            index]
                                                        .flag ==
                                                    1 ||
                                                controller
                                                        .studentsAttendanceList[
                                                            index]
                                                        .flag ==
                                                    2) &&
                                            controller
                                                .studentsAttendanceList[index]
                                                .remarkFlag)
                                          _buildTextFormField(controller, index)
                                        else if (controller
                                                    .studentsAttendanceList[
                                                        index]
                                                    .flag ==
                                                3 ||
                                            controller
                                                    .studentsAttendanceList[
                                                        index]
                                                    .flag ==
                                                4)
                                          _buildTextFormField(controller, index)
                                        else
                                          Container(),
                                        (controller
                                                    .studentsAttendanceList[
                                                        index]
                                                    .flag ==
                                                2)
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                              .studentsAttendanceList[
                                                                  index]
                                                              .lateComer =
                                                          !controller
                                                              .studentsAttendanceList[
                                                                  index]
                                                              .lateComer;
                                                      controller.update();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: ((controller
                                                                      .studentsAttendanceList[
                                                                          index]
                                                                      .time !=
                                                                  "ENTER TIME") ||
                                                              (controller
                                                                      .studentsAttendanceList[
                                                                          index]
                                                                      .lateComer ==
                                                                  true))
                                                          ? Colors.orange
                                                          : Colors.grey[300],
                                                      foregroundColor:
                                                          AppColors.whiteColor,
                                                      minimumSize:
                                                          const Size(10, 30),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                    child: Text("Late comer",
                                                        style: AppStyles
                                                            .arimBold
                                                            .copyWith(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        )),
                                                  ),
                                                  Visibility(
                                                    visible: ((controller
                                                                    .studentsAttendanceList[
                                                                        index]
                                                                    .time !=
                                                                "ENTER TIME") ||
                                                            (controller
                                                                    .studentsAttendanceList[
                                                                        index]
                                                                    .lateComer ==
                                                                true))
                                                        ? true
                                                        : false,
                                                    child: SMSButtonWidget(
                                                      onPress: () async {
                                                        await controller
                                                            .displayTimeDialog();
                                                        controller
                                                                .studentsAttendanceList[
                                                                    index]
                                                                .time =
                                                            controller
                                                                .selectedTime
                                                                .toString();
                                                        controller.update();
                                                      },
                                                      text: controller
                                                          .studentsAttendanceList[
                                                              index]
                                                          .time,
                                                      width: Get.width * 0.6,
                                                      height: 40,
                                                      borderRadius: 5,
                                                      primaryColor: AppColors
                                                          .darkPinkColor,
                                                    ),
                                                  )
                                                ],
                                              )
                                      ],
                                    ).paddingAll(10));
                              }),
                        ),
                    ]),
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                        height: 60,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            AppColors.indigo1Color,
                            AppColors.indigo2Color,
                            //add more colors
                          ]),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            List studentsList = [];
                            Map<String, dynamic> mapData = {};
                            for (int i = 0;
                                i < controller.studentsAttendanceList.length;
                                i++) {
                              if ((controller.studentsAttendanceList[i]
                                          .remarkText !=
                                      "") ||
                                  (controller.studentsAttendanceList[i].flag !=
                                      1) ||
                                  controller.studentsAttendanceList[i].time !=
                                      "ENTER TIME") {
                                mapData = {
                                  "id": controller.studentsAttendanceList[i].id,
                                  "student_id": controller
                                      .studentsAttendanceList[i].studentId,
                                  "first_name": controller
                                      .studentsAttendanceList[i].firstName,
                                  "attendance": {
                                    "late_att": controller
                                                .studentsAttendanceList[i]
                                                .time ==
                                            "ENTER TIME"
                                        ? 0
                                        : 1,
                                    "late_time": controller
                                                .studentsAttendanceList[i]
                                                .time ==
                                            "ENTER TIME"
                                        ? null
                                        : controller.studentsAttendanceList[i]
                                                .time ??
                                            "",
                                    "remark": controller
                                            .studentsAttendanceList[i]
                                            .remarkText ??
                                        "",
                                    "leave_type_id": controller
                                        .studentsAttendanceList[i].flag
                                  }
                                };
                                studentsList.add(mapData);
                              }
                            }
                            print("studentsList $studentsList");
                            Map<String, dynamic> mapData1 = {
                              "standard_id": controller.standardId,
                              "group_section_id": controller.groupSectionId,
                              "date": controller.selectedDate,
                              "student_list": studentsList
                            };
                            await controller.fetchNewAttendanceData(mapData1);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text("SUBMIT",
                              style: AppStyles.arimBold.copyWith(
                                  fontSize: 15,
                                  color: Colors.white,
                                  letterSpacing: 1)),
                        )),
                  )
                ],
              );
            }));
  }

  Widget _buildTextFormField(
      StudentsAttendanceController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: TextFormField(
        initialValue:
            controller.studentsAttendanceList[index].attendance != null
                ? controller.studentsAttendanceList[index].attendance?.remark
                : "",
        onChanged: (changed) {
          controller.studentsAttendanceList[index].remarkText = changed;
        },
        decoration: InputDecoration(
          hintText: "Enter Remark",
          contentPadding:
              const EdgeInsets.only(top: 0.0, bottom: 0, left: 10, right: 0),
          errorStyle: const TextStyle(height: 0, color: AppColors.redColor),
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFF969A9D),
            fontWeight: FontWeight.w300,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:
                  const BorderSide(color: AppColors.blackColor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:
                  const BorderSide(color: AppColors.blackColor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:
                  const BorderSide(color: AppColors.blackColor, width: 1.5)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:
                const BorderSide(color: AppColors.blackColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}
