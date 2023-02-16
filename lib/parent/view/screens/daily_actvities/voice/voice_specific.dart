import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controllers/daily_activity_controller/voice_controller/voice_controller.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../model/voiceOverallModel.dart';
import '../../../../sample_audio_file.dart';
import '../../../../themes/app_styles.dart';

class VoiceSpecific extends GetView<VoiceController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loadingType = controller.loadingState.value.loadingType;

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      if (controller.specificList.isEmpty) {
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
        controller: controller.specificScrollController,
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
                  ? controller.specificList.length + 1
                  : controller.specificList.length,
              itemBuilder: (BuildContext context, int index) {
                final isLastItem = index == controller.specificList.length;

                if (isLastItem && loadingType == LoadingType.loading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (isLastItem && loadingType == LoadingType.error) {
                  return Text(controller.loadingState.value.error.toString());
                } else if (isLastItem && loadingType == LoadingType.completed) {
                  return Text(
                      controller.loadingState.value.completed.toString());
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dateWidget(controller.specificList[index]),
                      titleAndDescription(controller.specificList[index])
                    ],
                  );
                }
              },
              separatorBuilder: (context, index) => Container(),
            ),
          )
        ],
      );
    });
  }

  Padding titleAndDescription(VoiceOverallData overallData) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(Get.context!).size.width,
            child: Card(
              elevation: 5,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 80,
                        color: Color(0XFFF2F5FA),
                        height: MediaQuery.of(Get.context!)
                            .size
                            .height *
                            0.09,
                        child: Center(
                          child: SMSImageAsset(
                            image:
                            "assets/campuseasy/voice_image.png",
                            width: 45,
                            height: 45,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Voice",
                                style:
                                AppStyles.PoppinsRegular
                                    .copyWith(
                                  fontSize: 12,
                                  color: Color(0XFF93A0A7),
                                )),
                            SizedBox(height: 10,),
                            Text(
                                "${overallData.title}",
                                style:
                                AppStyles.PoppinsRegular
                                    .copyWith(
                                  fontSize: 15,
                                  color: Color(0XFF252525),
                                )),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    SMSImageAsset(image: "assets/campuseasy/voice_clock.png",width: 10,height: 10,),
                                    SizedBox(width: 5,),
                                    Text(
                                        "${overallData.timeStamp}",
                                        style:
                                        AppStyles.PoppinsRegular
                                            .copyWith(
                                          fontSize: 8,
                                          color: Color(0XFF93A0A7),
                                        )),
                                  ],
                                ),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SMSImageAsset(
                                      image: "assets/campuseasy/voice_play_image.png",
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  onTap: (){
                                    Get.to(
                                        SampleAudioPlayer(voiceTodayData: overallData));
                                  },
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                            ),
                            SizedBox(height: 5,),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding dateWidget(VoiceOverallData overallData) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 8.0),
      child: Text(" ${overallData.date}",
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: AppColors.darkPinkColor,
          )),
    );
  }
}
