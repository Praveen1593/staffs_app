import 'package:flutter/material.dart';
import 'package:flutter_projects/staff/themes/app_styles.dart';
import 'package:get/get.dart';
import '../../../../../common/apihelper/api_helper.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../common/widgets/staff_common_widgets.dart';
import '../../../../../parent/model/custom_model.dart';
import '../../../../controller/students_controller/students_details_controller.dart';
import '../../../../model/gender_list_model.dart';
import '../../../../model/standard_students_list_model.dart';

class StudentsListDetailsScreen extends GetView<StudentsDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("Students List & Details"),
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        final loadingType = controller.loadingState.value.loadingType;
        return Column(
          children: [
            Card(
              elevation: 10,
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  _selectedDetailsRow(),
                  SMSButtonWidget(
                    onPress: () async {
                      controller.loadingState.value =
                          LoadingState(loadingType: LoadingType.loading);
                      controller.studentsList = [];
                      controller.checkType.value = 2;
                      controller.pageNo = 1;
                      controller.genderId.value = controller
                              .filteredGenderList[
                                  controller.genderSelectedIndex.value]
                              .id ??
                          0;

                      controller.standardId.value = controller
                              .filterStudentsStandardListData[
                                  controller.studentsListSelectedIndex.value]
                              .section?[
                                  controller.studentsListSectionIndex.value]
                              .standardId ??
                          0;
                      controller.groupSectionId.value = controller
                              .filterStudentsStandardListData[
                                  controller.studentsListSelectedIndex.value]
                              .section?[
                                  controller.studentsListSectionIndex.value]
                              .id ??
                          0;

                      if (controller.genderSelectedIndex.value == 0) {
                        controller.studentsList = [];
                        controller.getData(
                            "${ApiHelper.studentsListUrl}?gender_id=0&standard_id=${controller.standardId.value}&group_section_id=${controller.groupSectionId.value}&page=1");
                      }
                      if (controller.studentsListSelectedIndex.value == 0) {
                        controller.studentsList = [];
                        controller.getData(
                            "${ApiHelper.studentsListUrl}?gender_id=${controller.genderId.value}&standard_id=0&group_section_id=0&page=1");
                      }
                      if (controller.genderSelectedIndex.value != 0 &&
                          controller.studentsListSelectedIndex.value != 0) {
                        controller.studentsList = [];
                        controller.getData(
                            "${ApiHelper.studentsListUrl}?gender_id=${controller.genderId.value}&standard_id=${controller.standardId.value}&group_section_id=${controller.groupSectionId.value}&page=1");
                      }
                    },
                    text: "SEARCH",
                    width: Get.width * 0.1,
                    height: 30,
                    borderRadius: 5,
                    fontSize: 10,
                    primaryColor: AppColors.darkPinkColor,
                  ),
                ],
              ),
            ),
            GetBuilder<StudentsDetailsController>(builder: (studentController) {
              if (controller.isLoading.value) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              }
              if (controller.studentsList.isEmpty) {
                return const Center(child: Text(""));
              } else {
                return Expanded(
                  child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: loadingType == LoadingType.loading ||
                            loadingType == LoadingType.error ||
                            loadingType == LoadingType.completed
                        ? controller.studentsList.length + 1
                        : controller.studentsList.length,
                    // shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final isLastItem =
                          index == controller.studentsList.length;
                      if (isLastItem && loadingType == LoadingType.loading) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (isLastItem &&
                          loadingType == LoadingType.error) {
                        return Text(
                            controller.loadingState.value.error.toString());
                      } else if (isLastItem &&
                          loadingType == LoadingType.completed) {
                        return Text(
                            controller.loadingState.value.completed.toString());
                      } else {
                        return Card(
                          elevation: 5,
                          child: Theme(
                            data: Theme.of(Get.context!)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              onExpansionChanged: (bool expanded) {
                                controller.expandedView(!expanded);
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Text(
                                          "${controller.studentsList[index].firstName}",
                                          style: AppStyles.NunitoExtrabold
                                              .copyWith(
                                                  fontSize: 13,
                                                  color: AppColors.blackColor,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.circle_sharp,
                                        color: Colors.green,
                                        size: 10,
                                      ).paddingOnly(left: 5)
                                    ],
                                  ),
                                  Text("${controller.studentsList[index].academic?.standardSection} . ${controller.studentsList[index].gender}",
                                          style:
                                              AppStyles.NunitoRegular.copyWith(
                                                  fontSize: 12,
                                                  color: AppColors.blackColor))
                                      .paddingOnly(top: 8),
                                ],
                              ),
                              leading: Container(
                                      width: 40.0,
                                      height: 45.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(controller
                                                      .studentsList[index]
                                                      .photo ??
                                                  ""))))
                                  .paddingOnly(left: 0, bottom: 5),
                              trailing: const RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 14,
                                    color: AppColors.indigo1Color,
                                  )).paddingOnly(bottom: 10),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Details",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ).paddingOnly(
                                        top: 12, bottom: 12, left: 20),
                                    Divider(
                                      height: 1,
                                      color: Colors.grey[300],
                                    ).paddingOnly(bottom: 12),
                                    _expandedWidget("Date of Admission",
                                        "${controller.studentsList[index].doa}"),
                                    _expandedWidget("Father Name",
                                        "${controller.studentsList[index].fatherName}"),
                                    _expandedWidget("Phone Number",
                                        "${controller.studentsList[index].phoneNo ?? "NA"}"),
                                    _expandedWidget(
                                        "Academic Year",
                                        controller.studentsList[index].academic
                                                ?.academicYear ??
                                            ""),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )
                              ],
                            ).paddingOnly(top: 10),
                          ),
                        );
                      }
                    },
                  ),
                );
              }
            }),
          ],
        );
      }),
    );
  }

  Widget _selectedDetailsRow() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: AppColors.redColor,
                      size: 14,
                    ).paddingOnly(right: 5),
                    Text(" Gender ( optional ) ",
                        style: AppStyles.NunitoRegular.copyWith(fontSize: 12))
                  ],
                ).paddingOnly(bottom: 10, top: 10),
                InkWell(
                  onTap: () async {
                    controller.filteredGenderList = [
                      GenderData(id: 0, name: "Select Gender")
                    ];
                    await controller.fetchGenderList();
                    showModalBottomSheet(
                        context: Get.context!,
                        builder: (context) => selectGenderBottomSheet());
                  },
                  child: Row(
                    children: [
                      Text(
                          controller.filteredGenderList.isNotEmpty
                              ? controller
                                      .filteredGenderList[
                                          controller.genderSelectedIndex.value]
                                      .name ??
                                  ""
                              : "Select Gender",
                          style:
                              AppStyles.NunitoExtrabold.copyWith(fontSize: 14)),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.greyColor,
                      ).paddingOnly(left: 10),
                    ],
                  ),
                ),
              ],
            ).paddingOnly(left: 15),
          ),
          const VerticalDivider(
            color: Colors.grey,
            thickness: 0.3,
          ).paddingOnly(top: 10, bottom: 5),
          Expanded(
            child: Column(
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
                        isScrollControlled: true,
                        builder: (context) => selectStudentsListBottomSheet());
                  },
                  child: Row(
                    children: [
                      Text(
                          controller.filterStudentsStandardListData.isNotEmpty
                              ? "${controller.filterStudentsStandardListData[controller.studentsListSelectedIndex.value].fullName} - ${controller.filterStudentsStandardListData[controller.studentsListSelectedIndex.value].section?[controller.studentsListSectionIndex.value].fullName ?? ""}"
                              : "",
                          style:
                              AppStyles.NunitoExtrabold.copyWith(fontSize: 14)),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.greyColor,
                      ).paddingOnly(left: 10),
                    ],
                  ),
                ),
              ],
            ).paddingOnly(left: 10),
          )
        ],
      ),
    );
  }

  Widget selectGenderBottomSheet() {
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
            )
          ],
        ).paddingOnly(left: 20, top: 20),
        TextFormField(
          onChanged: (value) async {
            if (value.length > 3) {
              controller.filterGenderResults(value);
            }
            if (value.isEmpty) {
              controller.filteredGenderList = [
                GenderData(id: 0, name: "Select Gender")
              ];
              await controller.fetchGenderList();
            }
          },
          decoration: InputDecoration(
              prefix: const Icon(
                Icons.search_rounded,
                color: AppColors.greyColor,
              ).paddingOnly(right: 20, left: 20),
              hintStyle: const TextStyle(color: Colors.grey),
              hintText: "Search",
              contentPadding: const EdgeInsets.all(0),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        controller.filteredGenderList.isNotEmpty
            ? ListView.builder(
                itemCount: controller.filteredGenderList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      controller.updateGenderValue(index);
                      controller.studentsList = [];
                      Get.back();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${controller.filteredGenderList[index].name}")
                            .paddingSymmetric(horizontal: 25, vertical: 18),
                        dividerWidget()
                      ],
                    ),
                  );
                })
            : Container()
      ],
    );
  }

  Widget selectStudentsListBottomSheet() {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        maxChildSize: 0.5,
        builder: (context, scrollController) {
          return Column(
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
                    contentPadding: const EdgeInsets.all(0),
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
                                itemCount: controller
                                        .filterStudentsStandardListData[index]
                                        .section
                                        ?.length ??
                                    0,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index1) {
                                  return InkWell(
                                    onTap: () {
                                      controller.updateStudentListValue(
                                          index, index1);
                                      controller.studentsList = [];
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

  Widget _expandedWidget(String text, String text1) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: AppStyles.NunitoRegular.copyWith(fontSize: 13)),
          Text(text1, style: AppStyles.NunitoRegular.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}
