import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/contsants.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../controller/daily_activities/classtest_controller/classtest_class_teacher_controller.dart';
import '../../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';

class StaffClassTestAttachmentScreen extends GetView<StaffClassTeacherClasstestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(Constants.HOMEWRKSUBMISSIONTEXT,
              style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18)),
          actions: [
            InkWell(
                onTap: () {
                   showModalBottomSheet(
                                context: context,
                                builder: (context) => buildSheet(controller));
                },
                child: const Icon(
                  Icons.add,
                  color: AppColors.whiteColor,
                  size: 27,
                ).paddingOnly(right: 10))
          ],
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.whiteColor,
                size: 28,
              )),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: <Color>[AppColors.indigo1Color, AppColors.indigo2Color],
            )),
          )),
      body: GetBuilder<StaffClassTeacherClasstestController>(builder: (homeController) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: homeController.filesList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    homeController.filesList[index].fileName.contains(".pdf")
                        ? const SMSImageAsset(
                            image: ImageConstants.pdfImg,
                            height: 25,
                            width: 40,
                          )
                        : (homeController.filesList[index].fileName
                                .contains(".doc"))
                            ? const SMSImageAsset(
                                image: ImageConstants.docsImg,
                                height: 25,
                                width: 40,
                              )
                            : (homeController.filesList[index].fileName
                                    .contains(".x"))
                                ? const SMSImageAsset(
                                    image: ImageConstants.xlsImg,
                                    height: 25,
                                    width: 40,
                                  )
                                : (controller.image != null)
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: Image.file(
                                            File(controller.image!.path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: Image.file(
                                            controller.filesList[index].file!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                    InkWell(
                      onTap: () {
                        homeController.removeItem(index);
                      },
                      child: const Icon(
                        Icons.delete_outline_outlined,
                        color: AppColors.redColor,
                        size: 30,
                      ),
                    )
                  ],
                ).paddingAll(8),
              );
            });
      }),
    );
  }

  Widget buildSheet(StaffClassTeacherClasstestController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Upload Image",
              style:
              nunitoExtraBoldTextStyle(fontSize: 15, color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          Text(
              "Upload the homework Image View below option like Gallery or Camera",
              style:
              nunitoRegularTextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                  controller.filePicker();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/gallery_pick_icon.png",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Gallery",
                          style: nunitoExtraBoldTextStyle(
                              fontSize: 14, color: Colors.black)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  controller.captureImage();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/camera_picker_icon.png",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Camera",
                          style: nunitoExtraBoldTextStyle(
                              fontSize: 14, color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
