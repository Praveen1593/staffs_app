import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../../parent/model/sms_model.dart';
import '../../../../controller/daily_activities/Sms_Controller/Staff_sms_all_controller.dart';
import '../../../../themes/app_styles.dart';

class StaffSMSLatestSpecificOverAllScreen extends GetView<StaffSmsController> {
  final List<SmsData> listData;
  final ScrollController scrollController;

  StaffSMSLatestSpecificOverAllScreen(
      {required this.listData, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loadingType = controller.loadingState.value.loadingType;

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      if (listData.isEmpty) {
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
        );//const Center(child: Text("No Data"))
      }
      return ListView(
        controller: scrollController,
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
                  ? listData.length + 1
                  : listData.length,
              itemBuilder: (BuildContext context, int index) {
                final isLastItem = index == listData.length;

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dateWidget(controller, index),
                      titleAndDescription(controller, index)
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

  Padding titleAndDescription(StaffSmsController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
      child: SizedBox(
        width: Get.width,
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8.0),
                child: Text("${listData[index].title}",
                    style: AppStyles.NunitoExtrabold.copyWith(
                      fontSize: 14,
                      color: AppColors.blackColor,
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Text(
                  "${listData[index].smsDetail}",
                  style: AppStyles.normal
                      .copyWith(fontSize: 12, color: AppColors.greyColor),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding dateWidget(StaffSmsController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 8.0),
      child: Text(" ${listData[index].date}",
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: AppColors.darkPinkColor,
          )),
    );
  }
}
