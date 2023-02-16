import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/staff_common_widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/contsants.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../controllers/daily_activity_controller/class_test_controller1/classtest_controller1.dart';
import '../../../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../../../model/class_test_example.dart';
import '../../../../model/home_work_model.dart';
import '../../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../dialogs/dialog_helper.dart';
import '../../view_and_download/download_anyfile.dart';
import 'classtest_submission_screen1.dart';


class TodayAndPastScreen1 extends GetView<ClassTestController1> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Obx(() {
      final loadingType = controller.loadingState.value.loadingType;

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      if (controller.finalList.isEmpty) {
        return controller.currentTab == 2
            ? controller.dateSelectedFlag == 1
                ? Center(
                    child: Lottie.asset(ImageConstants.noDataJsonImg,
                        width: Get.width * 0.8,
                        height: MediaQuery.of(Get.context!).size.height / 1.3,
                        repeat: true,
                        controller: controller.lottieController,
                        onLoaded: (composition) {
                      controller.lottieController
                        ..duration = composition.duration
                        ..forward();
                      controller.lottieController.repeat();
                    }),
                  )
                : Center(
                    child: Text("Please Select the Date To Get the Report",
                        style: AppStyles.PoppinsBold.copyWith(
                            fontSize: 15, color: Colors.black)))
            : Center(
                child: Lottie.asset(ImageConstants.noDataJsonImg,
                    width: Get.width * 0.8,
                    height: MediaQuery.of(Get.context!).size.height / 1.3,
                    repeat: true,
                    controller: controller.lottieController,
                    onLoaded: (composition) {
                  controller.lottieController
                    ..duration = composition.duration
                    ..forward();
                  controller.lottieController.repeat();
                }),
              );
      }
      return ListView(controller: controller.scrollController, children: [
        Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: loadingType == LoadingType.loading ||
                        loadingType == LoadingType.error ||
                        loadingType == LoadingType.completed
                    ? controller.finalList.length + 1
                    : controller.finalList.length,
                itemBuilder: (BuildContext context, int index) {
                  final isLastItem = index == controller.finalList.length;

                  if (isLastItem && loadingType == LoadingType.loading) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: CircularProgressIndicator.adaptive(),
                    ));
                  } else if (isLastItem && loadingType == LoadingType.error) {
                    return Text(controller.loadingState.value.error.toString());
                  } else if (isLastItem &&
                      loadingType == LoadingType.completed) {
                    return Text(
                        controller.loadingState.value.completed.toString());
                  } else {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _dateWidget(controller.finalList[index]),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller.finalList[index].subject?.length ??
                                      0,
                              itemBuilder: (BuildContext context, int index1) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0,bottom: 10),
                                  child: _buildCardWidget(
                                      context,
                                      controller.finalList[index].subject ?? [],
                                      index1,
                                      index,
                                      controller),
                                );
                              })
                        ]);
                  }
                }))
      ]);
    });
  }

  Padding _dateWidget(ClassTestData homewrkData) {//ClassTestTodayData
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10.0, bottom: 10.0),
      child: Text(homewrkData.date.toString(),
          style: AppStyles.PoppinsBold.copyWith(
            fontSize: 14,
            color: Color(0XFF252525),
          )),
    );
  }

  Widget _buildCardWidget(BuildContext context, List<dynamic> subjectList,
      int index1, int index, ClassTestController1 controller) {
    if(subjectList[index1].resultData!=null){
      markPercentage(controller,subjectList[index1].resultData.totalMark,subjectList[index1].resultData.resultMax,subjectList,index1);
    }
    return subjectList.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _titleWidget(subjectList[index1]),
                   // statusIconWidget(subjectList[index1]),
                  ],
                ),
                subtitleAndDesWidget(subjectList[index1]),
                subjectList[index1].resultData!=null?
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Test Review",
                                  style: AppStyles.PoppinsBold.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF252525),
                                  ),
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down,color: Color(0XFF252525),)
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("",
                            style: AppStyles.PoppinsRegular.copyWith(
                              fontSize: 14,
                              color: Color(0XFF5F5F5F),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          color: Color(0XFFEEEEEE),
                          height: 1,
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Performance",
                                              style: AppStyles.PoppinsRegular.copyWith(
                                                fontSize: 14,
                                                color: Color(0XFF252525),
                                              ),
                                            ),
                                            Text(":",
                                              style: AppStyles.PoppinsRegular.copyWith(
                                                fontSize: 14,
                                                color: Color(0XFF252525),
                                              ),
                                            ),
                                          ],
                                        )
                                      ),
                                      SizedBox(width: 10,),
                                      Text(subjectList[index1].performance,
                                        style: AppStyles.PoppinsBold.copyWith(
                                          fontSize: 14,
                                          color: Color(subjectList[index].color!=null?subjectList[index].color:"0XFF252525"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Container(
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Mark",
                                                style: AppStyles.PoppinsRegular.copyWith(
                                                  fontSize: 14,
                                                  color: Color(0XFF252525),
                                                ),
                                              ),
                                              Text(":",
                                                style: AppStyles.PoppinsRegular.copyWith(
                                                  fontSize: 14,
                                                  color: Color(0XFF252525),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                      SizedBox(width: 10,),
                                      Text("${subjectList[index1].resultData!=null?subjectList[index1].resultData.totalMark:""}",
                                        style: AppStyles.PoppinsBold.copyWith(
                                          fontSize: 14,
                                          color: Color(0XFF5F5F5F),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: CircularPercentIndicator(
                                          radius: 50.0,
                                          lineWidth: 25.0,
                                          percent: 0.5,
                                          center: Text(
                                            "${subjectList[index].percentageText}",
                                            style: AppStyles.PoppinsBold.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: controller.percentageColor),
                                          ),
                                          progressColor: Color(subjectList[index].color!=null?subjectList[index].color:"0XFFF9F9F9"),
                                          backgroundColor: Color(0XFFF9F9F9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ):Container(),
                //hiddenContainerOfViewmore(Get.context!, subjectList[index1]),
                //viewMoreButton(controller, subjectList[index1]),
                /*Stack(
                  children: [
                    statusIconWidget(subjectList[index1]),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: _titleWidget(subjectList[index1]),
                          subtitle: subtitleAndDesWidget(subjectList[index1]),
                        ),
                        subjectList[index1].attachFile!.isNotEmpty
                            ? _shownDataAttachements(
                            subjectList, index1, controller)
                            : Container(),

                        //viewMoreButton(controller, subjectList[index1]),
                      ],
                    ),
                  ],
                ),*/
              ],
            ),
          )
        : Container();
  }

  String markPercentage(ClassTestController1 controller,int mark,int resultMax,List<dynamic> subjectList,int index){
    double value = (resultMax*mark)/100;
    int roundValue = value.toInt();
    subjectList[index].percentageText = "${roundValue.toString()}%";
    if(roundValue<=25){
      //Poor
      controller.performance = "Poor";
      controller.percentageColor = Color(0XFFFF5E5E);
      subjectList[index].color = 0XFFFF5E5E;
      subjectList[index].performance = "Poor";

    }else if(roundValue>25&&roundValue<=50){
      // Average
      controller.performance = "Average";
      controller.percentageColor = Color(0XFFFFA800);
      subjectList[index].color = 0XFFFFA800;
      subjectList[index].performance = "Average";

    }else if(roundValue>50&&roundValue<=75){
      // Good
      controller.performance = "Good";
      controller.percentageColor = Color(0XFF407BFF);
      subjectList[index].color = 0XFF407BFF;
      subjectList[index].performance = "Good";
    }else if(roundValue>75){
      // Excellent
      controller.performance = "Excellent";
      controller.percentageColor = Color(0XFF5B9D00);
      subjectList[index].color = 0XFF5B9D00;
      subjectList[index].performance = "Excellent";
    }
    return "${roundValue.toString()}%";
  }


  Widget _shownDataAttachements(
      List<dynamic> subjectList, int index1, HomeworkController controller) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: subjectList[index1].attachFile?.length ?? 0,
        itemBuilder: (BuildContext context, int index2) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              subjectList[index1]
                      .attachFile![index2]
                      .attachFile!
                      .contains(".pdf")
                  ? GestureDetector(
                      onTap: () {
                        showAnyFileDownloaderBottomModelSheet(
                            context,
                            controller,
                            subjectList[index1]
                                    .attachFile?[index2]
                                    .attachFile ??
                                "");
                      },
                      child: const SMSImageAsset(
                        image: ImageConstants.pdfImg,
                        height: 25,
                        width: 40,
                      ))
                  : subjectList[index1]
                          .attachFile![index2]
                          .attachFile!
                          .contains(".x")
                      ? GestureDetector(
                          onTap: () {
                            showAnyFileDownloaderBottomModelSheet(
                                context,
                                controller,
                                subjectList[index1]
                                        .attachFile?[index2]
                                        .attachFile ??
                                    "");
                          },
                          child: const SMSImageAsset(
                            image: ImageConstants.xlsImg,
                            height: 25,
                            width: 40,
                          ))
                      : subjectList[index1]
                              .attachFile![index2]
                              .attachFile!
                              .contains(".doc")
                          ? GestureDetector(
                              onTap: () {
                                showAnyFileDownloaderBottomModelSheet(
                                    context,
                                    controller,
                                    subjectList[index1]
                                            .attachFile?[index2]
                                            .attachFile ??
                                        "");
                              },
                              child: const SMSImageAsset(
                                image: ImageConstants.docsImg,
                                height: 25,
                                width: 40,
                              ))
                          : subjectList[index1]
                                  .attachFile![index2]
                                  .attachType!
                                  .contains("image")
                              ? GestureDetector(
                                  onTap: () {
                                    showImageViewerBottomModelSheet(
                                        context,
                                        controller,
                                        subjectList[index1]
                                                .attachFile?[index2]
                                                .attachFile ??
                                            "",0);
                                  },
                                  child: subjectList[index1]
                                              .attachFile?[index2]
                                              .attachFile !=
                                          null
                                      ? Image.network(
                                          "${subjectList[index1].attachFile?[index2].attachFile}",
                                          width: 40,
                                          height: 40,
                                        )
                                      : Container(),
                                )
                              : const SizedBox()
            ],
          ).paddingAll(5);
        },
      ),
    ).paddingOnly(left: 10, right: 10);
  }

  Widget subtitleAndDesWidget(dynamic subject) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: Text(
            subject.title ?? "",
            style: AppStyles.PoppinsBold.copyWith(
              fontSize: 13,
              color: Color(0XFF252525),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Text(subject.description ?? "",
              style: AppStyles.PoppinsRegular.copyWith(
                  fontSize: 12, color: Color(0XFF252525))),
        ),
      ],
    );
  }

  Widget _titleWidget(dynamic subject) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Text(
        subject.subjectName ?? "",
        style: AppStyles.PoppinsBold.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0XFF407BFF),
        ),
      ),
    );
  }

/*  Widget _leadingImage(Subject subject) {
    return Container(
        width: 50.0,
        height: 40.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(subject.icon.toString() ?? ""))));
  }*/

  Widget statusIconWidget(dynamic subject) {
    return IconButton(
        icon: Icon(
          Icons.verified,
          size: 24,
          color: ((subject.homeworkReply != null) &&
                  (subject.homeworkReply?.studentReply?.stuDescription !=
                      null) &&
                  (subject.homeworkReply?.staffReply?.staffDescription !=
                      null))
              ? AppColors.darkGreenColor
              : AppColors.orangeColor,
        ),
        onPressed: () {
          print("Pressed");
        });
  }





  Widget homewrkSubmissionTxt(double fontSize, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 10),
      child: Text(text,
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: fontSize,
            color: AppColors.blackColor,
          )),
    );
  }
}
