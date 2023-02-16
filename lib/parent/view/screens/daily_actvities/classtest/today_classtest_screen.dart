import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_projects/common/widgets/staff_common_widgets.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controllers/daily_activity_controller/class_test_controller/class_test_controller.dart';
import '../../../../model/class_test_model.dart';
import '../../../../themes/app_styles.dart';

class TodayClassTestScreen extends StatelessWidget {
  ClassTestModel? classTestModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassTestController>(
        init: ClassTestController(),
        builder: (classTestController) {
          return SingleChildScrollView(
            child: _buildBody(classTestController, context),
          );
        });
  }

  Widget _buildBody(
      ClassTestController classTestController, BuildContext context) {
    return classTestController.classTestModel != null &&
        classTestController.classTestModel!.data!.isNotEmpty
        ? classTestController.customTodayModel.isNotEmpty
        ? SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: classTestController.customTodayModel.length,
                  //classTestData!.length
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        classTestController
                            .customTodayModel[index].flag !=
                            1
                            ? _dateWidget(classTestController, index)
                            : _buildCardWidget(
                            classTestController, context, index)
                      ],
                    );
                  }),
            ),
          ],
        ))
        : SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: const Center(child: Text("")),
    )
        : SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Padding _dateWidget(ClassTestController classTestController, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 8.0, bottom: 5),
      child: Text(classTestController.customTodayModel[index].date ?? "",
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: AppColors.darkPinkColor,
          )),
    );
  }

  Widget _buildCardWidget(
      ClassTestController classTestController,
      BuildContext context,
      int index,
      ) {
    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: _leadingImage(classTestController, index),
                title: _titleWidget(classTestController, index),
                subtitle: subtitleAndDesWidget(classTestController, index),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget subtitleAndDesWidget(
      ClassTestController classTestController, int index) {
    print(
        "result mark : ${classTestController.customTodayModel[index].classTestTodayData?.resultData?.totalMark}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: Text(
            classTestController
                .customTodayModel[index].classTestTodayData!.title
                .toString() ??
                "",
            style: AppStyles.arimoRegular.copyWith(
              fontSize: 13,
              color: AppColors.blackColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Html(data:classTestController
              .customTodayModel[index].classTestTodayData!.description
              .toString()??""),

        ),
        Visibility(
          visible: classTestController.customTodayModel[index].classTestTodayData!
              .attachFile!.isNotEmpty?true:false,
          child: SizedBox(
            height: 50,
            child: classTestController.customTodayModel[index].classTestTodayData!
                .attachFile!.isNotEmpty
                ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: classTestController.customTodayModel[index]
                    .classTestTodayData?.attachFile?.length,
                //classTestData!.length
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index1) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      classTestController
                          .customTodayModel[index]
                          .classTestTodayData!
                          .attachFile![index1]
                          .attachFile!
                          .contains(".pdf")
                          ? InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset(
                            "assets/pdf.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        onTap: () {
                          showAnyFileDownloaderBottomModelSheet(
                              context,
                              classTestController,
                              classTestController
                                  .customTodayModel[index]
                                  .classTestTodayData
                                  ?.attachFile?[index1]
                                  .attachFile ??
                                  "");
                        },
                      )
                          : classTestController
                          .customTodayModel[index]
                          .classTestTodayData!
                          .attachFile![index1]
                          .attachFile!
                          .contains(".doc")
                          ? InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.network(
                            "assets/doc_icon.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        onTap: () {
                          showAnyFileDownloaderBottomModelSheet(
                              context,
                              classTestController,
                              classTestController
                                  .customTodayModel[index]
                                  .classTestTodayData
                                  ?.attachFile?[index1]
                                  .attachFile ??
                                  "");
                        },
                      )
                          : classTestController
                          .customTodayModel[index]
                          .classTestTodayData!
                          .attachFile![index1]
                          .attachFile!
                          .contains(".xlsx")
                          ? InkWell(
                        child: Padding(
                          padding:
                          const EdgeInsets.only(right: 10),
                          child: Image.network(
                            "assets/xls.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        onTap: () {
                          showAnyFileDownloaderBottomModelSheet(
                              context,
                              classTestController,
                              classTestController
                                  .customTodayModel[index]
                                  .classTestTodayData
                                  ?.attachFile?[index1]
                                  .attachFile ??
                                  "");
                        },
                      )
                          : InkWell(
                        child: Padding(
                          padding:
                          const EdgeInsets.only(right: 10),
                          child: Image.network(
                            classTestController
                                .customTodayModel[index]
                                .classTestTodayData
                                ?.attachFile?[index1]
                                .attachFile ??
                                "",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        onTap: () {
                          showImageViewerBottomModelSheet(
                              context,
                              classTestController,
                              classTestController
                                  .customTodayModel[index]
                                  .classTestTodayData
                                  ?.attachFile?[index1]
                                  .attachFile ??
                                  "",0);
                        },
                      ),
                    ],
                  );
                })
                : Container(),
          ),
        ),
        classTestController
            .customTodayModel[index].classTestTodayData?.resultData !=
            null
            ? classTestController.customTodayModel[index].classTestTodayData
            ?.resultData?.absent ==
            1
            ? Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text("Absent",
              style: AppStyles.arimBold.copyWith(
                  fontSize: 15, color: AppColors.darkPinkColor)),
        )
            : Stack(
          children: [
            CircularPercentIndicator(
              radius: 40.0,
              lineWidth: 10.0,
              percent: 0.41,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${classTestController.customTodayModel[index].classTestTodayData?.resultData?.totalMark ?? ""}",
                    style: const TextStyle(
                        fontSize: 15,
                        color: AppColors
                            .blackColor), //${controller.finalList[index].classTestPastSubject!.resultData!.totalMark??""}
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${classTestController.customTodayModel[index].classTestTodayData?.resultData?.resultMax ?? ""}",
                    style: const TextStyle(
                        fontSize: 15,
                        color: AppColors
                            .blackColor), //${controller.finalList[index].classTestPastSubject!.resultData!.resultMax??""}
                  ),
                ],
              ),
              progressColor: AppColors.shadeOfIndianRed,
            ),
          ],
        )
            : Container(),
      ],
    );
  }

  Widget _titleWidget(ClassTestController classTestController, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Text(
        classTestController
            .customTodayModel[index].classTestTodayData!.subjectName
            .toString() ??
            "",
        //classTestData![index].subject![0].subjectName.toString()??""
        style: AppStyles.NunitoExtrabold.copyWith(
          fontSize: 14,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  Widget _leadingImage(ClassTestController classTestController, int index) {
    return Container(
        width: 50.0,
        height: 40.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(classTestController
                    .customTodayModel[index].classTestTodayData!.icon
                    .toString() ??
                    ""))));
  }
}
