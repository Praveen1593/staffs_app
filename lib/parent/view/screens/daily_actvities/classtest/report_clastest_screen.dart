import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../controllers/daily_activity_controller/class_test_controller/class_test_controller.dart';
import '../../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';

class ReportClassTestScreen extends GetView<ClassTestController> {
  ReportClassTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? isClicked = false;
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Choose Date",
                          style: AppStyles.arimBold.copyWith(
                              fontSize: 14, color: AppColors.blackColor),
                        ),
                        SMSButtonWidget(
                          onPress: () {
                            controller.clearData();
                            controller.selectDate(context);
                          },
                          text: "SINGLE DAY",
                          width: 10,
                          height: 40,
                          primaryColor: AppColors.darkPinkColor,
                          borderRadius: 5,
                          fontSize: 11,
                        ),
                        SMSButtonWidget(
                          onPress: () {
                            controller.clearData();
                            controller.dateRangeDialog(context);
                          },
                          text: '''MULTIPLE \n    DAYS''',
                          width: 10,
                          height: 40,
                          borderRadius: 5,
                          primaryColor: AppColors.darkPinkColor,
                          fontSize: 11,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() {
            final loadingType = controller.loadingState.value.loadingType;
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (controller.finalList1.isEmpty) {
              return Column(
                children: [
                  Container(
                    height: Get.height * 0.3,
                  ),
                  Text(controller.selectedDate != "" ? " No Data in ${controller.selectedDate}" : controller.startDate !="" ?" No Data in between ${controller.startDate} to ${controller.endDate}" : "Please Select The Date To Get The Report",
                      style:const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                ],
              ); /*Center(
                child: Lottie.asset(ImageConstants.noDataJsonImg,
                    width: Get.width * 0.8,
                    repeat: true,
                    controller: controller.lottieController,
                    onLoaded: (composition) {
                      controller.lottieController
                        ..duration = composition.duration
                        ..forward();
                      controller.lottieController.repeat();
                    }),
              );*/
            }
            return Visibility(
              visible: controller.reportSelectedVal == true
                  ? controller.finalList1.isNotEmpty
                  ? true
                  : false
                  : false,
              child: ListView(
                controller: controller.scrollController,
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: loadingType == LoadingType.loading ||
                          loadingType == LoadingType.error ||
                          loadingType == LoadingType.completed
                          ? controller.finalList1.length + 1
                          : controller.finalList1.length,
                      itemBuilder: (BuildContext context, int index) {
                        final isLastItem =
                            index == controller.finalList1.length;

                        if (isLastItem && loadingType == LoadingType.loading) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (isLastItem &&
                            loadingType == LoadingType.error) {
                          return Text(
                              controller.loadingState.value.error.toString());
                        } else if (isLastItem &&
                            loadingType == LoadingType.completed) {
                          return Text(controller.loadingState.value.completed
                              .toString());
                        } else {
                          return controller.finalList1[index].flag != 1
                              ? dateWidget(controller, index)
                              : Card(
                            elevation: 5,
                            child: ListTile(
                              leading: _leadingImage(controller, index),
                              title: _titleWidget(controller, index),
                              subtitle:
                              subtitleAndDesWidget(controller, index),
                            ),
                          );
                        }
                      },
                      separatorBuilder: (context, index) => Container(),
                    ),
                  )
                ],
              ),
            );
          })
        ],
      ),
    );
  }

  Padding dateWidget(ClassTestController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 8.0, bottom: 5.0),
      child: Text(" ${controller.finalList1[index].date}",
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: AppColors.darkPinkColor,
          )),
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
                image: NetworkImage(
                    "${controller.finalList1[index].classTestPastSubject!.icon}"))));
  }

  Widget _titleWidget(ClassTestController classTestController, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10, bottom: 5),
      child: Text(
        "${controller.finalList1[index].classTestPastSubject!.subjectName}",
        //classTestData![index].subject![0].subjectName.toString()??""
        style: AppStyles.NunitoExtrabold.copyWith(
          fontSize: 14,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  Widget subtitleAndDesWidget(
      ClassTestController classTestController, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 5),
          child: Text(
            "${controller.finalList1[index].classTestPastSubject!.title}",
            style: AppStyles.arimoRegular.copyWith(
              fontSize: 13,
              color: AppColors.blackColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 10),
          child: Text(
              "${controller.finalList1[index].classTestPastSubject!.description}",
              style: AppStyles.normal
                  .copyWith(fontSize: 12, color: AppColors.greyColor)),
        ),
        SizedBox(
          height: 50,
          child: controller.finalList1[index].classTestPastSubject!.attachFile!
              .isNotEmpty
              ? //finalList1[index].classTestPastSubject!=null&&controller.finalList1[index].classTestPastSubject!.attachFile!=null&&controller.finalList1[index].classTestPastSubject!.attachFile!.isNotEmpty?
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.finalList1[index].classTestPastSubject!
                  .attachFile!.length,
              //controller.finalList1[index].classTestPastSubject?.attachFile!.length,//classTestData!.length
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index1) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.finalList1[index].classTestPastSubject!
                        .attachFile?[index1].attachExtension ==
                        "pdf"
                        ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        child: Image.asset(
                          "assets/pdf.png",
                          width: 30,
                          height: 30,
                        ),
                        onTap: () {
                          showAnyFileDownloaderBottomModelSheet(
                              context,
                              classTestController,
                              controller
                                  .finalList1[index]
                                  .classTestPastSubject!
                                  .attachFile?[index1]
                                  .attachFile ??
                                  "");
                        },
                      ),
                    )
                        : controller.finalList1[index].classTestPastSubject!
                        .attachFile?[index1].attachExtension ==
                        "doc"
                        ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        child: Image.asset(
                          "assets/doc_icon.png",
                          width: 30,
                          height: 30,
                        ),
                        onTap: () {
                          showAnyFileDownloaderBottomModelSheet(
                              context,
                              classTestController,
                              controller
                                  .finalList1[index]
                                  .classTestPastSubject!
                                  .attachFile?[index1]
                                  .attachFile ??
                                  "");
                        },
                      ),
                    )
                        : controller
                        .finalList1[index]
                        .classTestPastSubject!
                        .attachFile?[index1]
                        .attachExtension ==
                        "xlsx"
                        ? Padding(
                      padding:
                      const EdgeInsets.only(right: 10),
                      child: InkWell(
                        child: Image.asset(
                          "assets/xls.png",
                          width: 30,
                          height: 30,
                        ),
                        onTap: () {
                          showAnyFileDownloaderBottomModelSheet(
                              context,
                              classTestController,
                              controller
                                  .finalList1[index]
                                  .classTestPastSubject!
                                  .attachFile?[index1]
                                  .attachFile ??
                                  "");
                        },
                      ),
                    )
                        : Padding(
                      padding:
                      const EdgeInsets.only(right: 15),
                      child: InkWell(
                        child: Image.network(
                          controller
                              .finalList1[index]
                              .classTestPastSubject!
                              .attachFile?[index1]
                              .attachFile ??
                              "",
                          width: 30,
                          height: 30,
                        ),
                        onTap: () {
                          showImageViewerBottomModelSheet(
                              context,
                              controller,
                              controller
                                  .finalList1[index]
                                  .classTestPastSubject!
                                  .attachFile?[index1]
                                  .attachFile ??
                                  "",0);
                        },
                      ),
                    )
                  ],
                );
              })
              : Container(),
        ),
        controller.finalList1[index].classTestPastSubject?.resultData != null
            ? controller.finalList1[index].classTestPastSubject?.resultData
            ?.absent ==
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
                    "${controller.finalList1[index].classTestPastSubject?.resultData?.totalMark ?? ""}",
                    style: const TextStyle(
                        fontSize: 15,
                        color: AppColors
                            .blackColor), //${controller.finalList1[index].classTestPastSubject!.resultData!.totalMark??""}
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
                    "${controller.finalList1[index].classTestPastSubject?.resultData?.resultMax ?? ""}",
                    style: const TextStyle(
                        fontSize: 15,
                        color: AppColors
                            .blackColor), //${controller.finalList1[index].classTestPastSubject!.resultData!.resultMax??""}
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

  Padding titleAndDescription(ClassTestController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _leadingImage(controller, index),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                          child: Text(
                              "${controller.finalList1[index].classTestPastSubject!.subjectName}",
                              style: AppStyles.NunitoExtrabold.copyWith(
                                fontSize: 14,
                                color: AppColors.blackColor,
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 5.0),
                          child: Text(
                            "${controller.finalList1[index].classTestPastSubject!.title}",
                            style: AppStyles.normal.copyWith(
                                fontSize: 12, color: AppColors.blackColor),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 8.0),
                          child: Text(
                            "${controller.finalList1[index].classTestPastSubject!.description}",
                            style: AppStyles.normal
                                .copyWith(fontSize: 12, color: Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: controller.customTodayModel[index].classTestTodayData!.attachFile!.isNotEmpty ? 50 : 5,
                          child: controller.customTodayModel[index]
                              .classTestTodayData!.attachFile!.isNotEmpty
                              ? ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.customTodayModel[index]
                                  .classTestTodayData?.attachFile?.length,
                              //classTestData!.length
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder:
                                  (BuildContext context, int index1) {
                                return Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    controller
                                        .customTodayModel[index]
                                        .classTestTodayData!
                                        .attachFile![index1]
                                        .attachFile!
                                        .contains(".pdf")
                                        ? InkWell(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            right: 10),
                                        child: Image.asset(
                                          "assets/pdf.png",
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      onTap: () {
                                        showAnyFileDownloaderBottomModelSheet(
                                            context,
                                            controller,
                                            controller
                                                .customTodayModel[
                                            index]
                                                .classTestTodayData
                                                ?.attachFile?[
                                            index1]
                                                .attachFile ??
                                                "");
                                      },
                                    )
                                        : controller
                                        .customTodayModel[index]
                                        .classTestTodayData!
                                        .attachFile![index1]
                                        .attachFile!
                                        .contains(".doc")
                                        ? InkWell(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            right: 10),
                                        child: Image.network(
                                          "assets/doc_icon.png",
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      onTap: () {
                                        showAnyFileDownloaderBottomModelSheet(
                                            context,
                                            controller,
                                            controller
                                                .customTodayModel[
                                            index]
                                                .classTestTodayData
                                                ?.attachFile?[
                                            index1]
                                                .attachFile ??
                                                "");
                                      },
                                    )
                                        : controller
                                        .customTodayModel[index]
                                        .classTestTodayData!
                                        .attachFile![index1]
                                        .attachFile!
                                        .contains(".xlsx")
                                        ? InkWell(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets
                                            .only(
                                            right: 10),
                                        child: Image.network(
                                          "assets/xls.png",
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      onTap: () {
                                        showAnyFileDownloaderBottomModelSheet(
                                            context,
                                            controller,
                                            controller
                                                .customTodayModel[
                                            index]
                                                .classTestTodayData
                                                ?.attachFile?[
                                            index1]
                                                .attachFile ??
                                                "");
                                      },
                                    )
                                        : InkWell(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets
                                            .only(
                                            right: 10),
                                        child: Image.network(
                                          controller
                                              .customTodayModel[
                                          index]
                                              .classTestTodayData
                                              ?.attachFile?[
                                          index1]
                                              .attachFile ??
                                              "",
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      onTap: () {
                                        showImageViewerBottomModelSheet(
                                            context,
                                            controller,
                                            controller
                                                .customTodayModel[
                                            index]
                                                .classTestTodayData
                                                ?.attachFile?[
                                            index1]
                                                .attachFile ??
                                                "",0);
                                      },
                                    ),
                                  ],
                                );
                              })
                              : Container(),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            controller.finalList1[index].classTestPastSubject?.resultData !=
                null
                ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 10.0,
                    percent: 0.41,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${controller.finalList1[index].classTestPastSubject?.resultData!.totalMark ?? ""}",
                          style: const TextStyle(
                              fontSize: 15,
                              color: AppColors
                                  .blackColor), //${controller.finalList1[index].classTestPastSubject!.resultData!.totalMark??""}
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
                          "${controller.finalList1[index].classTestPastSubject?.resultData!.resultMax ?? ""}",
                          style: const TextStyle(
                              fontSize: 15,
                              color: AppColors
                                  .blackColor), //${controller.finalList1[index].classTestPastSubject!.resultData!.resultMax??""}
                        ),
                      ],
                    ),
                    progressColor: AppColors.shadeOfIndianRed,
                  ),
                ),
              ],
            )
                : Container()
          ],
        ),
      ),
    );
  }
}
