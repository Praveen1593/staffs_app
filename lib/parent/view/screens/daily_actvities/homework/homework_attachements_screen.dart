import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_projects/parent/view/dialogs/dialog_helper.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/contsants.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';

class HomeworkAttachmentScreen extends GetView<HomeworkController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          title:
          Text("Homework Submission", style: AppStyles.PoppinsBold.copyWith(fontSize: 18,fontWeight: FontWeight.w500)),
          actions: [
            InkWell(
                onTap: () {
                  showBottomModelSheet(context, controller);
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Center(
                    child: SMSImageAsset(image: 'assets/campuseasy/back_arrow.png',width: 15,height: 15,),
                  ),
                ),
              )),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                colors: <Color>[
                    Color(0XFF407BFF),
                    Color(0XFF8FC4FF),]
            )),
          )),
      body: GetBuilder<HomeworkController>(builder: (homeController) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: homeController.filesList.length,
            itemBuilder: (context, index) {
              return Column(children: [
                if (homeController.filesList[index].fileName.contains(".pdf"))
                  CardWidget(
                      index: index,
                      homeController: homeController,
                      icon: ImageConstants.pdfImg)
                else if (homeController.filesList[index].fileName
                    .contains(".doc"))
                  CardWidget(
                      index: index,
                      homeController: homeController,
                      icon: ImageConstants.docsImg)
                else if (homeController.filesList[index].fileName
                    .contains(".x"))
                  CardWidget(
                      index: index,
                      homeController: homeController,
                      icon: ImageConstants.xlsImg)
                else if ((homeController.filesList[index].fileName
                        .toLowerCase()
                        .contains(".jp")) ||
                    (homeController.filesList[index].fileName
                        .toLowerCase()
                        .contains(".pn")))
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFEEF3FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            child: Image.file(
                              controller.filesList[index].file!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            controller.filesList[index].fileName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            homeController.removeItem(index);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Color(0XFF252525),
                            size: 30,
                          ),
                        )
                      ],
                    ).paddingOnly(left: 10, right: 10, top: 10, bottom: 10),
                  )
                else
                  Container(),
              ]).paddingAll(8);
            });
      }),
    );
  }
}

class CardWidget extends StatelessWidget {
  final int index;
  final HomeworkController homeController;
  final String icon;

  const CardWidget(
      {Key? key,
      required this.index,
      required this.homeController,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SMSImageAsset(
            image: icon,
            height: 25,
            width: 40,
          ),
          SizedBox(
            width: 150,
            child: Text(
              homeController.filesList[index].fileName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
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
      ).paddingOnly(left: 10, right: 10, top: 10, bottom: 10),
    );
  }
}
