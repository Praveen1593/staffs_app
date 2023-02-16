import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../controllers/daily_activity_controller/news_circular_event_controller/circular_event_news_controller.dart';
import '../../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';

class LatestScreen extends GetView<NewsCircularEventController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loadingType = controller.loadingState.value.loadingType;

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      if (controller.finalList.isEmpty) {
        return Center(
            // child:  Text(controller.selectedDate != "" ? " No Data in ${controller.selectedDate}" : controller.startDate !="" ?" No Data in between ${controller.startDate} to ${controller.endDate}" : "Please Select The Date To Get The Report",
            child: Text(
          controller.selectedDate != ""
              ? "No Data Found On This Particular Date."
              : controller.startDate != ""
                  ? " No Data Found On This Particular Dates."
                  : "Please Select The Date To Get The Report",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ) /* L
        ottie.asset(ImageConstants.noDataJsonImg,
              width: Get.width * 0.8,
              repeat: true,
              controller: controller.lottieController, onLoaded: (composition) {
            controller.lottieController!
              ..duration = composition.duration
              ..forward();
            controller.lottieController?.repeat();
          }),*/
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
                  return controller.finalList[index].flag != 1
                      ? dateWidget(controller, index)
                      : titleAndDescription(controller, index);
                }
              },
              separatorBuilder: (context, index) => Container(),
            ),
          )
        ],
      );
    });
  }

  Padding titleAndDescription(
      NewsCircularEventController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.zero,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 10, right: 10.0),
                    child: Text("General",
                        style: AppStyles.RedressedRegular.copyWith(
                          fontSize: 25,
                          color: AppColors.blackColor,
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 10, right: 10.0),
                    child: Text(
                        "${controller.finalList[index].customResponse?.title}",
                        style: AppStyles.PoppinsRegular.copyWith(
                          fontSize: 16,
                          color: Color(0XFFFF4E5A),
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 0),
                    child: Text(
                      "${controller.finalList[index].customResponse?.description}",
                      style: AppStyles.PoppinsRegular.copyWith(
                          fontSize: 12, color: Color(0XFF5F5F5F)),
                    ),
                  ),
                  controller.finalList[index].customResponse!.images!.isNotEmpty
                      ? SizedBox(
                          height: 40,
                          child: _displayAttachementsWidget(controller, index),
                        ).paddingOnly(left: 10.0, right: 10.0, bottom: 0)
                      : Container().paddingZero,
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Expanded(
                child: SMSImageAsset(
                    image: "assets/campuseasy/circular_image.png"))
          ],
        ),
      ),
    );
  }

  Widget _displayAttachementsWidget(
      NewsCircularEventController controller, int index) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount:
          controller.finalList[index].customResponse?.images?.length ?? 0,
      itemBuilder: (BuildContext context, int index1) {
        var imageList =
            controller.finalList[index].customResponse?.images ?? [];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ((imageList[index1].oldAttachFile != "") &&
                    (imageList[index1].oldAttachFile!.contains(".pdf")))
                ? GestureDetector(
                    onTap: () {
                      showAnyFileDownloaderBottomModelSheet(context, controller,
                          imageList[index1].oldAttachFile ?? "");
                    },
                    child: const SMSImageAsset(
                      width: 30,
                      image: ImageConstants.pdfImg,
                    ))
                : ((imageList[index1].oldAttachFile != "") &&
                        (imageList[index1].oldAttachFile!.contains(".x")))
                    ? GestureDetector(
                        onTap: () {
                          showAnyFileDownloaderBottomModelSheet(
                              context,
                              controller,
                              imageList[index1].oldAttachFile ?? "");
                        },
                        child: const SMSImageAsset(
                          image: ImageConstants.xlsImg,
                          width: 30,
                        ))
                    : ((imageList[index1].oldAttachFile != "") &&
                            (imageList[index1].oldAttachFile!.contains(".doc")))
                        ? GestureDetector(
                            onTap: () {
                              showAnyFileDownloaderBottomModelSheet(
                                  context,
                                  controller,
                                  imageList[index1].oldAttachFile ?? "");
                            },
                            child: const SMSImageAsset(
                              image: ImageConstants.docsImg,
                              width: 30,
                            ))
                        : ((imageList[index1].oldAttachFile != "") &&
                                (imageList[index1]
                                    .attachType!
                                    .contains("image")))
                            ? GestureDetector(
                                onTap: () {
                                  showImageViewerBottomModelSheet(
                                      context,
                                      controller,
                                      imageList[index1].oldAttachFile ?? "",
                                      0);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    "${imageList[index1].oldAttachFile}",
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ))
                            : const SizedBox(),
          ],
        ).paddingOnly(
          right: 5,
          top: 8,
        );
      },
    );
  }

  Padding dateWidget(NewsCircularEventController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 8.0),
      child: Text(" ${controller.finalList[index].date}",
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: Color(0XFF252525),
          )),
    );
  }
}
