import 'package:flutter/material.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:flutter_projects/common/const/image_constants.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../../common/widgets/staff_common_widgets.dart';
import '../../../../controller/students_controller/leave_request_controller.dart';
import '../../../../model/standard_students_list_model.dart';
import '../../../../model/student_leave_request_model.dart';
import '../../../../themes/app_styles.dart';

class StudentLeaveRequestScreen extends GetView<LeaveRequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("Student Leave Request"),
      body: Obx(() {
        final loadingType = controller.loadingState.value.loadingType;
        return Column(
          children: [
            Card(
              elevation: 10,
              margin: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Student & Subject      ",
                    style: TextStyle(fontSize: 13),
                  ),
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
                          builder: (context) => selectStd(controller));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.blackColor, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Text(
                                  controller.filterStudentsStandardListData
                                          .isNotEmpty
                                      ? "${controller.filterStudentsStandardListData[controller.studentsListSelectedIndex.value].fullName} - ${controller.filterStudentsStandardListData[controller.studentsListSelectedIndex.value].section?[controller.studentsListSectionIndex.value].fullName ?? ""}"
                                      : "",
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                      fontSize: 14))
                              .paddingOnly(left: 5),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.greyColor,
                          ).paddingOnly(left: 10, right: 5),
                        ],
                      ),
                    ),
                  )
                ],
              ).paddingAll(5),
            ),
            if (controller.isLoading.value)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator.adaptive()),
              ),
            if (controller.leaveRequestList.isEmpty)
              const Center(child: Text(""))
            else
              Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount: loadingType == LoadingType.loading ||
                          loadingType == LoadingType.error ||
                          loadingType == LoadingType.completed
                      ? controller.leaveRequestList.length + 1
                      : controller.leaveRequestList.length,
                  // shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final isLastItem =
                        index == controller.leaveRequestList.length;
                    if (isLastItem && loadingType == LoadingType.loading) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    } else if (isLastItem && loadingType == LoadingType.error) {
                      return Text(
                          controller.loadingState.value.error.toString());
                    } else if (isLastItem &&
                        loadingType == LoadingType.completed) {
                      return Text(
                          controller.loadingState.value.completed.toString());
                    } else {
                      return Card(
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${controller.leaveRequestList[index].firstName}",
                                    style: AppStyles.NunitoExtrabold.copyWith(
                                        fontSize: 13,
                                        color: AppColors.blackColor)),
                                Text(
                                    "${controller.leaveRequestList[index].statusName}",
                                    style: AppStyles.NunitoExtrabold.copyWith(
                                        fontSize: 13,
                                        color: controller
                                                    .leaveRequestList[index]
                                                    .statusName ==
                                                "Pending"
                                            ? AppColors.orangeColor
                                            : controller.leaveRequestList[index]
                                                        .statusName ==
                                                    "Approved"
                                                ? AppColors.darkGreenColor
                                                : AppColors.redColor)),
                              ],
                            ).paddingAll(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "From ${controller.leaveRequestList[index].startDate} to ${controller.leaveRequestList[index].endDate}",
                                        style: AppStyles.NunitoRegular.copyWith(
                                            fontSize: 12,
                                            color: AppColors.blackColor)),
                                    Text("Total Days : ${controller.leaveRequestList[index].total}",
                                            style: AppStyles.NunitoRegular
                                                .copyWith(
                                                    fontSize: 12,
                                                    color:
                                                        AppColors.blackColor))
                                        .paddingOnly(top: 8),
                                  ],
                                ),
                                controller.leaveRequestList[index].statusName ==
                                        "Pending"
                                    ? InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: Get.context!,
                                              builder: (context) => editView(
                                                  controller
                                                      .leaveRequestList[index],
                                                  controller));
                                        },
                                        child: Image.asset(
                                          ImageConstants.editIconImage,
                                          height: 20,
                                        ).paddingOnly(right: 20))
                                    : Container()
                              ],
                            ).paddingAll(2),
                            Text("${controller.leaveRequestList[index].description}",
                                    style: AppStyles.NunitoRegular.copyWith(
                                        fontSize: 12,
                                        color: AppColors.blackColor))
                                .paddingOnly(left: 3, top: 5),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                    "Applied on ${controller.leaveRequestList[index].applyDate}",
                                    style: AppStyles.NunitoRegular.copyWith(
                                        fontSize: 12, color: Colors.grey[600])))
                          ],
                        ).paddingAll(10),
                      );
                    }
                  },
                ),
              )
          ],
        );
      }),
    );
  }

  Widget editView(
      StudentsLeaveRequestData leaveData, LeaveRequestController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            color: Colors.grey[300],
            height: 4,
            width: 50,
          ),
        ),
        _buildTextBold("Edit Leave Request").paddingOnly(top: 15),
        _buildText("You can give the type for your leave"),
        _buildTextBold("Leave Date"),
        _buildText("From ${leaveData.startDate} to ${leaveData.endDate}"),
        _buildTextBold("Number Of Leaves"),
        _buildText("${leaveData.total}"),
        _buildTextBold("Leave Type"),
        _buildText("Please select your leave type"),
        GetBuilder<LeaveRequestController>(builder: (leaveRequestController) {
          return FormField(
            builder: (FormFieldState state) {
              return InputDecorator(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 0.0),
                  errorStyle:
                      const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: leaveRequestController.updateLeaveTypeValue,
                    isDense: true,
                    onChanged: (changed) {
                      leaveRequestController.updateLeaveType(changed);
                    },
                    items: ["Pending", "Approve", "Reject"].map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value ?? ""),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Text("CANCEL")),
            const SizedBox(
              width: 20,
            ),
            SMSButtonWidget(
              onPress: () async {
                Map<String, dynamic> mapData = {
                  "leave_request_id": leaveData.id,
                  "status": controller.updateLeaveTypeValue != ""
                      ? controller.updateLeaveTypeValue == "Pending"
                          ? 0
                          : controller.updateLeaveTypeValue == "Approve"
                              ? 1
                              : 2
                      : leaveData.status,
                  "reject_remark": leaveData.rejectRemark
                };
                await controller.editLeaveRequest(mapData);
              },
              text: "SUBMIT",
              width: Get.width * 0.1,
              height: 30,
              borderRadius: 20,
              fontSize: 12,
              primaryColor: AppColors.darkPinkColor,
            ),
          ],
        ),
      ],
    ).paddingOnly(left: 10, right: 10, top: 10);
  }

  Widget _buildText(String text) {
    return Text(text,
            style: AppStyles.NunitoRegular.copyWith(
                fontSize: 14, color: AppColors.blackColor))
        .paddingOnly(bottom: 20);
  }

  Widget _buildTextBold(String text) {
    return Text(text,
            style: AppStyles.NunitoExtrabold.copyWith(
                fontSize: 15, color: AppColors.blackColor))
        .paddingOnly(bottom: 8);
  }

  Widget selectStd(LeaveRequestController controller) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 1,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              ).paddingOnly(left: 20, top: 20),
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
                                    ),
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
