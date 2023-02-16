import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controllers/daily_activity_controller/class_test_controller/class_test_controller.dart';
import '../../../../themes/app_styles.dart';

class PastClassTestScreen extends GetView<ClassTestController> {
  const PastClassTestScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loadingType = controller.loadingState.value.loadingType;
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      if (controller.finalList.isEmpty) {
        return Center(
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
        );
      }
      return ListView(
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
                  ? controller.finalList.length + 1
                  : controller.finalList.length,
              itemBuilder: (BuildContext context, int index) {
                final isLastItem = index == controller.finalList.length;

                if (isLastItem && loadingType == LoadingType.loading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (isLastItem && loadingType == LoadingType.error) {
                  return Text(controller.loadingState.value.error.toString());
                } else if (isLastItem && loadingType == LoadingType.completed) {
                  return Text(
                      controller.loadingState.value.completed.toString());
                } else {
                  return controller.finalList[index].flag != 1 ? dateWidget(controller, index)
                      : Card(elevation: 5,
                    child: ListTile(
                      leading: _leadingImage(controller, index),
                      title: _titleWidget(controller, index),
                      subtitle: subtitleAndDesWidget(controller, index),
                    ),
                  );
                }
              },
              separatorBuilder: (context, index) => Container(),
            ),
          )
        ],
      );
    });
    //_buildBody(context);
  }

  Widget _leadingImage(ClassTestController classTestController, int index) {
    return Container(
        width: 50.0,
        height: 40.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("${controller.finalList[index].classTestPastSubject!.icon}"))));
  }

  Widget _titleWidget(ClassTestController classTestController, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10,top: 10,bottom: 5),
      child: Text(
        "${controller.finalList[index].classTestPastSubject!.subjectName}",
        //classTestData![index].subject![0].subjectName.toString()??""
        style: AppStyles.NunitoExtrabold.copyWith(
          fontSize: 14,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  Padding dateWidget(ClassTestController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 8.0),
      child: Text(" ${controller.finalList[index].date}",
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: AppColors.darkPinkColor,
          )),
    );
  }

  Widget subtitleAndDesWidget(ClassTestController classTestController, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10,bottom: 5),
          child: Text(
            "${controller.finalList[index].classTestPastSubject!.title}",
            style: AppStyles.arimoRegular.copyWith(
              fontSize: 13,
              color: AppColors.blackColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10,bottom: 10),
          child: Html(data:controller.finalList[index].classTestPastSubject!.description
              .toString()??""),
        ),
        Visibility(
          visible: controller.finalList[index].classTestPastSubject!.attachFile!.isNotEmpty?true:false,
          child: SizedBox(
            height: 50,
            child:  controller.finalList[index].classTestPastSubject!.attachFile!.isNotEmpty?  //finalList[index].classTestPastSubject!=null&&controller.finalList[index].classTestPastSubject!.attachFile!=null&&controller.finalList[index].classTestPastSubject!.attachFile!.isNotEmpty?
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.finalList[index].classTestPastSubject!.attachFile!.length,        //controller.finalList[index].classTestPastSubject?.attachFile!.length,//classTestData!.length
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index1) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.finalList[index].classTestPastSubject!.attachFile?[index1].attachExtension=="pdf"?
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          child: Image.asset("assets/pdf.png",width: 30,height: 30,),
                          onTap: (){
                            showAnyFileDownloaderBottomModelSheet(
                                context,
                                classTestController,
                                controller.finalList[index].classTestPastSubject!.attachFile?[index1].attachFile??"");
                          },
                        ),
                      ):controller.finalList[index].classTestPastSubject!.attachFile?[index1].attachExtension=="doc"?
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          child: Image.asset("assets/doc_icon.png",width: 30,height: 30,),
                          onTap: (){
                            showAnyFileDownloaderBottomModelSheet(
                                context,
                                classTestController,
                                controller.finalList[index].classTestPastSubject!.attachFile?[index1].attachFile??"");
                          },
                        ),
                      ):controller.finalList[index].classTestPastSubject!.attachFile?[index1].attachExtension=="xlsx"?
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          child: Image.asset("assets/xls.png",width: 30,height: 30,),
                          onTap: (){
                            showAnyFileDownloaderBottomModelSheet(
                                context,
                                classTestController,
                                controller.finalList[index].classTestPastSubject!.attachFile?[index1].attachFile??"");
                          },
                        ),
                      ):Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: InkWell(
                          child: Image.network(controller.finalList[index].classTestPastSubject!.attachFile?[index1].attachFile??"",width: 30,height: 30,),
                          onTap: (){
                            showImageViewerBottomModelSheet(
                                context,
                                controller,
                                controller.finalList[index].classTestPastSubject!.attachFile?[index1].attachFile??"",0);
                          },
                        ),
                      )
                    ],
                  );
                }):Container(),
          ),
        ),
        controller.finalList[index].classTestPastSubject?.resultData!=null?
        controller.finalList[index].classTestPastSubject?.resultData?.absent==1?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
          child: Text(
              "Absent",
              style: AppStyles.arimBold
                  .copyWith(fontSize: 15, color: AppColors.darkPinkColor)),
        ):
        Stack(
          children: [
            CircularPercentIndicator(
              radius: 40.0,
              lineWidth: 10.0,
              percent: 0.41,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "${controller.finalList[index].classTestPastSubject?.resultData?.totalMark??""}",
                    style: const TextStyle(fontSize: 15, color: AppColors.blackColor),//${controller.finalList[index].classTestPastSubject!.resultData!.totalMark??""}
                  ),
                  const SizedBox(height: 2,),
                  const Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Divider(
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2,),
                  Text(
                    "${controller.finalList[index].classTestPastSubject?.resultData?.resultMax??""}",
                    style: const TextStyle(fontSize: 15, color: AppColors.blackColor),//${controller.finalList[index].classTestPastSubject!.resultData!.resultMax??""}
                  ),

                ],
              ),
              progressColor: AppColors.shadeOfIndianRed,
            ),
          ],
        ):Container(),

      ],
    );
  }


}

