import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/staff_common_widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/contsants.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../../../model/home_work_model.dart';
import '../../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../dialogs/dialog_helper.dart';
import '../../view_and_download/download_anyfile.dart';
import 'homework_submission_screen.dart';

class TodayAndPastScreen extends GetView<HomeworkController> {
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

  Padding _dateWidget(HomeWorkData homewrkData) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10.0, bottom: 10.0),
      child: Text(homewrkData.date.toString(),
          style: AppStyles.PoppinsBold.copyWith(
            fontSize: 14,
            color: Color(0XFF252525),
          )),
    );
  }

  Widget _buildCardWidget(BuildContext context, List<Subject> subjectList,
      int index1, int index, HomeworkController controller) {
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
                    statusIconWidget(subjectList[index1]),
                  ],
                ),
                subtitleAndDesWidget(subjectList[index1]),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0XFF407BFF),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            if(subjectList[index1].homeworkReply == null){
                              Get.to(HomeWorkSubmissionScreen(subjectList: subjectList[index1]));
                              controller.homeworkController.text = "";
                              controller.filesList.clear();
                            }else{
                                controller.exploreView(index,index1);
                            }
                          },
                          child: Container(
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(subjectList[index1].homeworkReply != null?
                                    "Student Submission":"Submit Homework",
                                    style: AppStyles.PoppinsBold.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                subjectList[index1].homeworkReply != null?

                                Row(
                                  children: [
                                    Text("Explore",
                                      style: AppStyles.PoppinsBold.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    subjectList[index1].checkVisible==true?
                                    SMSImageAsset(image: "assets/campuseasy/arrow_down.png",width: 15,height: 15,):
                                    SMSImageAsset(image: "assets/campuseasy/arrow_forward.png",width: 15,height: 15,)
                                  ],
                                ):
                                SMSImageAsset(image: "assets/campuseasy/arrow_icon.png",)

                              ],
                            ),
                          ),
                        ),

                        ((subjectList[index1].homeworkReply != null)?
                            Visibility(
                              visible: subjectList[index1].checkVisible!?true:false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  subjectList[index1].homeworkReply?.studentReply
                                      ?.stuHomeworkFile?.length!=0?
                                  Text(subjectList[index1].homeworkReply?.studentReply
                                      ?.stuHomeworkFile?.length==1?"${subjectList[index1].homeworkReply?.studentReply
                                      ?.stuHomeworkFile?.length} file":"${subjectList[index1].homeworkReply?.studentReply
                                      ?.stuHomeworkFile?.length} files",
                                    style: AppStyles.PoppinsBold.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0XFFFFC100),
                                    ),
                                  ):Container(),
                                  SizedBox(height: 5,),
                                  Wrap(
                                    children: [
                                      Text(subjectList[index1].homeworkReply?.studentReply?.stuDescription ?? "",
                                        style: AppStyles.PoppinsRegular.copyWith(
                                          fontSize: 14,
                                          color: Color(0XFFF5F5F5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      subjectList[index1]
                                          .homeworkReply!=null&&subjectList[index1]
                                          .homeworkReply!.studentReply!.stuHomeworkFile!.isNotEmpty
                                          ? SizedBox(
                                        height: 50,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(),
                                          itemCount: subjectList[index1].homeworkReply?.studentReply
                                              ?.stuHomeworkFile?.length ??
                                              0,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                subjectList[index1].homeworkReply!.studentReply!
                                                    .stuHomeworkFile![index].attachFile!
                                                    .contains(".pdf")
                                                    ? GestureDetector(
                                                    onTap: () {
                                                      showAnyFileDownloaderBottomModelSheet(
                                                          context,
                                                          controller,
                                                          subjectList[index1]
                                                              .homeworkReply
                                                              ?.studentReply
                                                              ?.stuHomeworkFile?[index]
                                                              .attachFile ??
                                                              "");
                                                    },
                                                    child: const SMSImageAsset(
                                                      image: ImageConstants.pdfImg,
                                                      height: 25,
                                                      width: 40,
                                                    ))
                                                    : subjectList[index1].homeworkReply!.studentReply!
                                                    .stuHomeworkFile![index].attachFile!
                                                    .contains(".x")
                                                    ? GestureDetector(
                                                    onTap: () {
                                                      showAnyFileDownloaderBottomModelSheet(
                                                          context,
                                                          controller,
                                                          subjectList[index1]
                                                              .homeworkReply
                                                              ?.studentReply
                                                              ?.stuHomeworkFile?[
                                                          index]
                                                              .attachFile ??
                                                              "");
                                                    },
                                                    child: const SMSImageAsset(
                                                      image: ImageConstants.xlsImg,
                                                      height: 25,
                                                      width: 40,
                                                    ))
                                                    : subjectList[index1]
                                                    .homeworkReply!
                                                    .studentReply!
                                                    .stuHomeworkFile![index]
                                                    .attachFile!
                                                    .contains(".doc")
                                                    ? GestureDetector(
                                                    onTap: () {
                                                      showAnyFileDownloaderBottomModelSheet(
                                                          context,
                                                          controller,
                                                          subjectList[index1]
                                                              .homeworkReply
                                                              ?.studentReply
                                                              ?.stuHomeworkFile?[
                                                          index]
                                                              .attachFile ??
                                                              "");
                                                    },
                                                    child: const SMSImageAsset(
                                                      image: ImageConstants.docsImg,
                                                      height: 25,
                                                      width: 40,
                                                    ))
                                                    : ((subjectList[index1]
                                                    .homeworkReply!
                                                    .studentReply!
                                                    .stuHomeworkFile![index]
                                                    .attachFile!
                                                    .toLowerCase()
                                                    .contains("jp")) ||
                                                    (subjectList[index1]
                                                        .homeworkReply!
                                                        .studentReply!
                                                        .stuHomeworkFile![index]
                                                        .attachFile!
                                                        .toLowerCase()
                                                        .contains("pn")))
                                                    ? GestureDetector(
                                                  onTap: () {
                                                    showImageViewerBottomModelSheet(
                                                        context,
                                                        controller,
                                                        subjectList[index1]
                                                            .homeworkReply
                                                            ?.studentReply
                                                            ?.stuHomeworkFile?[
                                                        index]
                                                            .attachFile ??
                                                            "",0);
                                                  },
                                                  child: subjectList[index1]
                                                      .homeworkReply
                                                      ?.studentReply!
                                                      .stuHomeworkFile![
                                                  index]
                                                      .attachFile !=
                                                      null
                                                      ? ClipRRect(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    child: Image.network(
                                                      subjectList[index1]
                                                          .homeworkReply
                                                          ?.studentReply
                                                          ?.stuHomeworkFile?[
                                                      index]
                                                          .attachFile ??
                                                          "",
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                      : Container(),
                                                )
                                                    : const SizedBox()
                                              ],
                                            );
                                          },
                                        ),
                                      ) : Container(),
                                      subjectList[index1].homeworkReply?.staffReply?.staffDescription ==
                                          null?
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              controller.filesList.clear();
                                              Get.to(
                                                  HomeWorkSubmissionScreen(subjectList: subjectList[index1]));
                                              controller.homeworkController.text = subjectList[index1]
                                                  .homeworkReply?.studentReply?.stuDescription
                                                  .toString() ??
                                                  "";
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Color(0XFFF5F5F5),
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Center(child: SMSImageAsset(image: "assets/campuseasy/homework_edit_pencil.png",width: 15,height: 15,)),
                                            ),
                                          ),
                                          /*SizedBox(width: 10,),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Color(0XFFF5F5F5),
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(child: SMSImageAsset(image: "assets/campuseasy/homework_download.png",width: 15,height: 15,)),
                                          )*/
                                        ],
                                      ):
                                      Container()

                                    ],
                                  ),
                                  subjectList[index1].homeworkReply?.staffReply?.staffDescription ==
                                      null?Container():
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Teacher review",
                                        style: AppStyles.PoppinsBold.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Wrap(
                                        children: [
                                          Text(subjectList[index1].homeworkReply?.staffReply?.staffDescription ?? "",
                                            style: AppStyles.PoppinsRegular.copyWith(
                                              fontSize: 14,
                                              color: Color(0XFFF5F5F5),
                                            ),
                                          ),
                                        ],
                                      )

                                    ],
                                  )
                                ],
                              ),
                            ):Container())
                      ],
                    ),
                  ),
                ),
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

  Widget _shownDataAttachements(
      List<Subject> subjectList, int index1, HomeworkController controller) {
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

  Widget subtitleAndDesWidget(Subject subject) {
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

  Widget _titleWidget(Subject subject) {
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

  Widget _leadingImage(Subject subject) {
    return Container(
        width: 50.0,
        height: 40.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(subject.icon.toString() ?? ""))));
  }

  Widget statusIconWidget(Subject subject) {
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

  Widget hiddenContainerOfViewmore(BuildContext context, Subject subjectList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 0.0, left: 5, right: 5),
          child: Divider(
            height: 1,
            color: AppColors.greyColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            homewrkSubmissionTxt(14, Constants.HOMEWRKSUBMISSIONTEXT)
                .paddingOnly(top: 10, bottom: 10),
            ((subjectList.homeworkReply != null) &&
                    (subjectList.homeworkReply?.staffReply?.staffDescription ==
                        null))
                ? InkWell(
                    onTap: () {
                      controller.filesList.clear();
                      Get.to(
                          HomeWorkSubmissionScreen(subjectList: subjectList));
                      controller.homeworkController.text = subjectList
                              .homeworkReply?.studentReply?.stuDescription
                              .toString() ??
                          "";
                    },
                    child: const Text(
                      "EDIT",
                      style: TextStyle(color: AppColors.redColor),
                    ).paddingOnly(right: 20),
                  )
                : Container()
          ],
        ),
        if (subjectList.homeworkReply == null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 14),
            child: SMSButtonWidget(
              onPress: () {
                Get.to(HomeWorkSubmissionScreen(subjectList: subjectList));
                controller.homeworkController.text = "";
                controller.filesList.clear();
              },
              text: Constants.SUBMITHOMEWORK,
              width: MediaQuery.of(context).size.width * 0.85,
              height: 40,
              borderRadius: 5,
              primaryColor: AppColors.darkGreenColor,
              fontSize: 13,
            ),
          )
        else if (subjectList.homeworkReply?.studentReply?.stuDescription !=
            null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  subjectList.homeworkReply?.studentReply?.stuDescription ?? "",
                  style: AppStyles.NunitoRegular.copyWith(
                    fontSize: 12,
                    color: AppColors.blackColor,
                  )).paddingOnly(left: 14, bottom: 3),
              subjectList
                      .homeworkReply!.studentReply!.stuHomeworkFile!.isNotEmpty
                  ? SizedBox(
                      height: 30,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: subjectList.homeworkReply?.studentReply
                                ?.stuHomeworkFile?.length ??
                            0,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              subjectList.homeworkReply!.studentReply!
                                      .stuHomeworkFile![index].attachFile!
                                      .contains(".pdf")
                                  ? GestureDetector(
                                      onTap: () {
                                        showAnyFileDownloaderBottomModelSheet(
                                            context,
                                            controller,
                                            subjectList
                                                    .homeworkReply
                                                    ?.studentReply
                                                    ?.stuHomeworkFile?[index]
                                                    .attachFile ??
                                                "");
                                      },
                                      child: const SMSImageAsset(
                                        image: ImageConstants.pdfImg,
                                        height: 25,
                                        width: 40,
                                      ))
                                  : subjectList.homeworkReply!.studentReply!
                                          .stuHomeworkFile![index].attachFile!
                                          .contains(".x")
                                      ? GestureDetector(
                                          onTap: () {
                                            showAnyFileDownloaderBottomModelSheet(
                                                context,
                                                controller,
                                                subjectList
                                                        .homeworkReply
                                                        ?.studentReply
                                                        ?.stuHomeworkFile?[
                                                            index]
                                                        .attachFile ??
                                                    "");
                                          },
                                          child: const SMSImageAsset(
                                            image: ImageConstants.xlsImg,
                                            height: 25,
                                            width: 40,
                                          ))
                                      : subjectList
                                              .homeworkReply!
                                              .studentReply!
                                              .stuHomeworkFile![index]
                                              .attachFile!
                                              .contains(".doc")
                                          ? GestureDetector(
                                              onTap: () {
                                                showAnyFileDownloaderBottomModelSheet(
                                                    context,
                                                    controller,
                                                    subjectList
                                                            .homeworkReply
                                                            ?.studentReply
                                                            ?.stuHomeworkFile?[
                                                                index]
                                                            .attachFile ??
                                                        "");
                                              },
                                              child: const SMSImageAsset(
                                                image: ImageConstants.docsImg,
                                                height: 25,
                                                width: 40,
                                              ))
                                          : ((subjectList
                                                      .homeworkReply!
                                                      .studentReply!
                                                      .stuHomeworkFile![index]
                                                      .attachFile!
                                                      .toLowerCase()
                                                      .contains("jp")) ||
                                                  (subjectList
                                                      .homeworkReply!
                                                      .studentReply!
                                                      .stuHomeworkFile![index]
                                                      .attachFile!
                                                      .toLowerCase()
                                                      .contains("pn")))
                                              ? GestureDetector(
                                                  onTap: () {
                                                    showImageViewerBottomModelSheet(
                                                        context,
                                                        controller,
                                                        subjectList
                                                                .homeworkReply
                                                                ?.studentReply
                                                                ?.stuHomeworkFile?[
                                                                    index]
                                                                .attachFile ??
                                                            "",0);
                                                  },
                                                  child: subjectList
                                                              .homeworkReply
                                                              ?.studentReply!
                                                              .stuHomeworkFile![
                                                                  index]
                                                              .attachFile !=
                                                          null
                                                      ? Image.network(
                                                          subjectList
                                                                  .homeworkReply
                                                                  ?.studentReply
                                                                  ?.stuHomeworkFile?[
                                                                      index]
                                                                  .attachFile ??
                                                              "",
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
                    ).paddingOnly(right: 10, bottom: 8)
                  : Container()
            ],
          ),
        if (subjectList.homeworkReply?.staffReply?.staffDescription != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              homewrkSubmissionTxt(
                12,
                "Staff Reply ",
              ),
              Text(
                  subjectList.homeworkReply?.staffReply?.staffDescription ?? "",
                  style: AppStyles.NunitoRegular.copyWith(
                    fontSize: 12,
                    color: AppColors.blackColor,
                  )).paddingOnly(left: 14, bottom: 5, top: 3),
            ],
          ).paddingOnly(top: 5, bottom: 5)
      ],
    );
  }

  Widget viewMoreButton(HomeworkController controller, Subject subject) {
    return Theme(
      data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: const Text(
          "",
        ),
        childrenPadding: EdgeInsets.zero,
        tilePadding: const EdgeInsets.only(right: 15),
        onExpansionChanged: (bool expanded) {
          controller.expandedView(expanded);
        },
        trailing: SizedBox(
          width: Get.width * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(Constants.VIEWMORE,
                  style: AppStyles.normal
                      .copyWith(fontSize: 12, color: AppColors.darkPinkColor)),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      controller.isExpanded
                          ? Icons.arrow_forward_ios_outlined
                          : Icons.arrow_back_ios,
                      size: 10,
                      color: AppColors.darkPinkColor,
                    )),
              ),
            ],
          ),
        ),
        children: [hiddenContainerOfViewmore(Get.context!, subject)],
      ),
    );
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
