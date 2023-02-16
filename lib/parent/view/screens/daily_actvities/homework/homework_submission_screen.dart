import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_projects/storage.dart';
import 'package:get/get.dart';
import '../../../../../common/apihelper/api_helper.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/contsants.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../../../model/home_work_model.dart';
import '../../../../themes/app_styles.dart';
import '../../../dialogs/dialog_helper.dart';
import '../../../../../common/widgets/common_widgets.dart';
import 'homework_attachements_screen.dart';

class HomeWorkSubmissionScreen extends StatelessWidget {
  final Subject subjectList;

  const HomeWorkSubmissionScreen({Key? key, required this.subjectList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: smsAppbar(Constants.HOMEWRKSUBMISSIONTEXT),
      body: GetBuilder<HomeworkController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SMSImageAsset(image: "assets/campuseasy/homework_submission_image.png"),
                SizedBox(height: 20,),
                Text("Explain about your homework ?",
                    style: AppStyles.PoppinsRegular.copyWith(
                      fontSize: 16,
                      color: Color(0XFF252525),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: TextFormField(
                    minLines: 5,
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: controller.homeworkController,
                    decoration: InputDecoration(
                      hintText: "Enter Homework",
                      filled: true,
                      fillColor: Color(0XFFF9F9F9),
                      errorStyle:
                          const TextStyle(height: 0, color: AppColors.redColor),
                      hintStyle: AppStyles.PoppinsRegular.copyWith(
                        fontSize: 16,
                        color: Color(0xFF969A9D),
                        fontWeight: FontWeight.w300,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: Color(0XFFEEEEEE), width: 1.5)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: Color(0XFFEEEEEE), width: 1.5)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: Color(0XFFEEEEEE), width: 1.5)),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                            color: AppColors.redColor, width: 1.5),
                      ),
                    ),
                  ),
                ),
                Text("Attachments",
                    style: AppStyles.PoppinsRegular.copyWith(
                      fontSize: 16,
                      color: Color(0XFF252525),
                    )),
                SizedBox(height: 10,),
                Wrap(
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(HomeworkAttachmentScreen());
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Color(0XFFF9F9F9),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0XFFEEEEEE),width: 1)
                        ),
                        child: Center(child: Icon(Icons.add,color: Color(0XFF252525),)),
                      ),
                    ),
                    SizedBox(width: 10,),
                    ((subjectList.homeworkReply != null) &&
                        (subjectList.homeworkReply!.studentReply != null) &&
                        (subjectList.homeworkReply!.studentReply!
                            .stuHomeworkFile!.isNotEmpty))
                        ? Container(
                          height: 50,
                          width: 50,
                          child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: subjectList.homeworkReply?.studentReply
                              ?.stuHomeworkFile?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(width: 10,),
                                subjectList.homeworkReply!.studentReply!.stuHomeworkFile![index].attachFile!
                                    .contains(".pdf")
                                    ? _imageCardWidget(
                                    index,
                                    controller,
                                    ImageConstants.pdfImg,
                                    subjectList
                                        .homeworkReply
                                        ?.studentReply
                                        ?.stuHomeworkFile?[index]
                                        .attachFile ??
                                        "")
                                    : subjectList.homeworkReply!.studentReply!
                                    .stuHomeworkFile![index].attachFile!
                                    .contains(".doc")
                                    ? _imageCardWidget(
                                    index,
                                    controller,
                                    ImageConstants.docsImg,
                                    subjectList
                                        .homeworkReply
                                        ?.studentReply
                                        ?.stuHomeworkFile?[index]
                                        .attachFile ??
                                        "")
                                    : subjectList
                                    .homeworkReply!
                                    .studentReply!
                                    .stuHomeworkFile![index]
                                    .attachFile!
                                    .contains(".x")
                                    ? _imageCardWidget(
                                    index,
                                    controller,
                                    ImageConstants.xlsImg,
                                    subjectList
                                        .homeworkReply
                                        ?.studentReply
                                        ?.stuHomeworkFile?[index]
                                        .attachFile ??
                                        "")
                                    : ((subjectList
                                    .homeworkReply!
                                    .studentReply!
                                    .stuHomeworkFile![index]
                                    .attachFile!
                                    .toLowerCase()
                                    .contains(".jp")) ||
                                    (subjectList
                                        .homeworkReply!
                                        .studentReply!
                                        .stuHomeworkFile![index]
                                        .attachFile!
                                        .toLowerCase()
                                        .contains(".pn")))
                                    ? InkWell(
                                    onTap: () {
                                      showImageViewerBottomModelSheet(
                                          context,
                                          controller,
                                          subjectList
                                              .homeworkReply
                                              ?.studentReply
                                              ?.stuHomeworkFile?[
                                          index]
                                              .attachFile
                                              .toString() ??
                                              "",1,subjectList: subjectList,index: index,homeworkController: controller);
                                    },
                                    child:ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        subjectList
                                            .homeworkReply
                                            ?.studentReply
                                            ?.stuHomeworkFile?[
                                        index]
                                            .attachFile
                                            .toString() ??
                                            "",
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                )
                                    : Container(),
                              ],
                            );
                          }),
                        )
                        : Container(),

                  ],
                ),

                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "Attachment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    SMSButtonWidget(
                        onPress: () {
                          Get.to(HomeworkAttachmentScreen());
                        },
                        text: "ADD",
                        primaryColor: AppColors.darkPinkColor,
                        width: 10,
                        height: 30,
                        borderRadius: 5),
                    *//*Align(
                      alignment: Alignment.topRight,
                      child:
                    )*//*
                  ],
                ),*/
                /* controller.filesList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.filesList.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            if (controller.filesList[index].fileName
                                .contains(".pdf"))
                              CardWidget(
                                  index: index,
                                  homeController: controller,
                                  icon: ImageConstants.pdfImg)
                            else if (controller.filesList[index].fileName
                                .contains(".doc"))
                              CardWidget(
                                  index: index,
                                  homeController: controller,
                                  icon: ImageConstants.docsImg)
                            else if (controller.filesList[index].fileName
                                .contains(".x"))
                              CardWidget(
                                  index: index,
                                  homeController: controller,
                                  icon: ImageConstants.xlsImg)
                            else if ((controller.filesList[index].fileName
                                    .toLowerCase()
                                    .contains(".jp")) ||
                                (controller.filesList[index].fileName
                                    .toLowerCase()
                                    .contains(".pn")))
                              Card(
                                elevation: 5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        child: Image.file(
                                          controller.filesList[index].file!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    _fileName(controller, index),
                                    _deleteWidget(controller, index)
                                  ],
                                ).paddingOnly(
                                    left: 10, right: 10, top: 5, bottom: 5),
                              )
                            else
                              Container(),
                          ]);
                        })
                    : Container(),
                controller.filesList.length > 2
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, right: 20, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Get.to(HomeworkAttachmentScreen());
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(Constants.VIEWMORE,
                                  style: AppStyles.normal.copyWith(
                                      fontSize: 12,
                                      color: AppColors.darkPinkColor)),
                              const RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 10,
                                    color: AppColors.darkPinkColor,
                                  ))
                            ],
                          ).paddingAll(8),
                        ),
                      )
                    : Container(),*/
                SizedBox(height: 30,),
                InkWell(
                  onTap: ()async{
                    if (controller.homeworkController.text.isNotEmpty) {
                      await controller.sendHomeworkSubmission(
                          homewrkId: subjectList.id.toString(),
                          homewrkText: controller.homeworkController.text,
                          filesList: controller.filesList,
                          url: ApiHelper.homeworkSubmissionUrl);
                    } else {
                      Get.snackbar("Failure"," result.statusCode", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                      //showToastMsg("student description field is required");
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0XFF407BFF),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Submit",
                            style: AppStyles.PoppinsBold.copyWith(
                                fontSize: 14,
                                color: Colors.white)),
                        SizedBox(width: 10,),
                        SMSImageAsset(image: "assets/campuseasy/arrow_icon.png",width: 15,height: 15,)
                      ],
                    ),
                  ),
                )

               /* SMSButtonWidget(
                  onPress: () async {
                    if (controller.homeworkController.text.isNotEmpty) {
                      await controller.sendHomeworkSubmission(
                          homewrkId: subjectList.id.toString(),
                          homewrkText: controller.homeworkController.text,
                          filesList: controller.filesList,
                          url: ApiHelper.homeworkSubmissionUrl);
                    } else {
                      showToastMsg("student description field is required");
                    }
                  },
                  text: Constants.SUBMITHOMEWORK,
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 40,
                  borderRadius: 5,
                  primaryColor: AppColors.darkGreenColor,
                  fontSize: 13,
                )*/

              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _imageCardWidget(
      int index, HomeworkController controller, String icon, String file) {
    return GestureDetector(
      onTap: () {
        showAnyFileDownloaderBottomModelSheet(Get.context!, controller, file);
      },
      child:
      // Card(
      //   elevation: 5,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       SMSImageAsset(
      //         image: icon,
      //         height: 25,
      //         width: 40,
      //       ),
      //       _deleteItemFromApi(index, controller)
      //     ],
      //   ).paddingOnly(left: 10, right: 10, top: 10, bottom: 10),
      // ),
      SMSImageAsset(
        image: icon,
        height: 25,
        width: 40,
      ),
    );
  }

  Widget _deleteItemFromApi(int index, HomeworkController controller) {
    return InkWell(
      onTap: () async {
        Map<String, dynamic> mapData = {
          "student_id": LocalStorage.getValue("studentId"),
          "homework_id": subjectList.id,
          "stu_homework_file_id":
              "${subjectList.homeworkReply?.studentReply?.stuHomeworkFile![index].id ?? 0}",
          "homework_student_reply_id": subjectList.homeworkReply?.id ?? 0
        };
        await controller.deleteReplyImage(mapData);
        controller.removeIteFromList(subjectList, index);
      },
      child: const Icon(
        Icons.delete_outline_outlined,
        color: Colors.black54,
        size: 25,
      ),
    );
  }

}

class FilesUploadModel {
  File? file;
  String fileName;

  FilesUploadModel({required this.file, required this.fileName});
}
