import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_classtest/classtest_attachements_screen.dart';
import 'package:get/get.dart';

import '../../../../../common/const/contsants.dart';
import '../../../../../common/const/image_constants.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../parent/themes/app_styles.dart';
import '../../../../../parent/view/screens/daily_actvities/homework/homework_attachements_screen.dart';
import '../../../../controller/daily_activities/classtest_controller/classtest_class_teacher_controller.dart';




class StaffCTAddEntryClasstest extends StatelessWidget {

  int? type;
  int? classTestId;
  int? sectionSubjectItemId;
  String? selectedDate;
  int? classTestItemId = 0;
  int? approvalType = -1;
  String? title;
  String? description;
  List<dynamic>? attachmentList = [];

  GlobalKey<FormState> globalKey = GlobalKey();

  StaffCTAddEntryClasstest(
      {this.type,
        this.classTestId,
        this.sectionSubjectItemId,
        this.selectedDate,
        this.title,
        this.description,
        this.classTestItemId,
        this.approvalType,
      this.attachmentList});

  @override
  Widget build(BuildContext context) {
    print("attachmentList2 : ${attachmentList?.length}");
    return GetBuilder<StaffClassTeacherClasstestController>(
        init: StaffClassTeacherClasstestController(),
        builder: (staffClasstestController) => Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: smsAppbar(type==1?"Add Class Test":type==2?"Edit Class Test":""),
            body: buildBody(staffClasstestController, context)));
  }

  TextFormField _textFormField(
      StaffClassTeacherClasstestController controller,
      TextEditingController textEditingController,
      double verticalPadding,
      double horizontalPadding) {
    return TextFormField(
        keyboardType: TextInputType.text,
        maxLines: null,
        controller: textEditingController,
        cursorColor: AppColors.darkPinkColor,
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }

  Widget buildBody(
      StaffClassTeacherClasstestController controller, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Title",
                style: nunitoExtraBoldTextStyle(
                    fontSize: 15, color: Colors.black)),
            const SizedBox(
              height: 10,
            ),
            _textFormField(controller, controller.titleEditController, 10, 10),
            const SizedBox(
              height: 30,
            ),
            Text("Description",
                style: nunitoExtraBoldTextStyle(
                    fontSize: 15, color: Colors.black)),
            const SizedBox(
              height: 10,
            ),
            _textFormField(
                controller, controller.descriptionEditController, 50, 10),
            const SizedBox(
              height: 30,
            ),
            controller.basicSettingsModel?.data?.staffClassTestApprovalType ==
                1 ||
                controller.basicSettingsModel?.data
                    ?.classClassTestApprovalType ==
                    1
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Permission",
                    style: nunitoExtraBoldTextStyle(
                        fontSize: 15, color: Colors.black)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        value: 1,
                        groupValue: controller.radiotype,
                        onChanged: (value) {
                          controller.permissionUpdate(value!);
                        }),
                    Text("Approved",
                        style: nunitoRegularTextStyle(
                            fontSize: 13, color: Colors.black)),
                    const SizedBox(
                      width: 10,
                    ),
                    Radio(
                        value: 2,
                        groupValue: controller.radiotype,
                        onChanged: (value) {
                          controller.permissionUpdate(value!);
                        }),
                    Text("Not Approved",
                        style: nunitoRegularTextStyle(
                            fontSize: 13, color: Colors.black)),
                  ],
                )
              ],
            )
                : Container(),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Attachment",
                          style: nunitoExtraBoldTextStyle(
                              fontSize: 15, color: Colors.black87)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Click the Add button to choose image via Gallery or Camera",
                          style: nunitoRegularTextStyle(
                              fontSize: 12, color: Colors.black38))
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            controller.filesList.clear();
                            Get.to(StaffClassTestAttachmentScreen());
                           /* showModalBottomSheet(
                                context: context,
                                builder: (context) => buildSheet(controller));*/
                          },
                          child: const Icon(
                            Icons.add,
                            color: AppColors.darkPinkColor,
                          ),
                        ))),
              ],
            ),
          ]),
        ),
        controller.attachmentList!=null&&controller.attachmentList!.isNotEmpty
            ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.attachmentList?.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          controller.attachmentList?[index].oldAttachFile != null &&
                              controller.attachmentList![index]
                                  .oldAttachFile!
                                  .contains(".pdf")
                              ? const SMSImageAsset(
                            image: ImageConstants.pdfImg,
                            height: 25,
                            width: 40,
                          )
                              : (controller.attachmentList?[index].oldAttachFile !=
                              null &&
                              controller.attachmentList![index]
                                  .oldAttachFile!
                                  .contains(".doc"))
                              ? const SMSImageAsset(
                            image: ImageConstants.docsImg,
                            height: 25,
                            width: 40,
                          )
                              : (controller.attachmentList?[index].oldAttachFile !=
                              null &&
                              controller.attachmentList![index]
                                  .oldAttachFile!
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
                                File(
                                    controller.image!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                              : ClipRRect(
                            borderRadius:
                            BorderRadius.circular(30.0),
                            child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.network(
                                    "${controller.attachmentList?[index].oldAttachFile}") /*Image.file(
                                                      File(attachmentList?[index]
                                                              .oldAttachFile ??
                                                          ""),
                                                      fit: BoxFit.cover,
                                                    ),*/
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              controller.attachmentList?[index].file ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () async{
                            Map<String,dynamic> mapData = {
                              "class_test_id":classTestItemId,
                              "class_test_image_id":controller.attachmentList?[index].id,
                            };
                            print("class_test_id : $classTestItemId");
                            print("class_test_image_id : ${controller.attachmentList?[index].id}");
                            int result = await controller.imageDelete(mapData);
                            if(result==200){
                              controller.removeItem(index);
                            }

                          },
                          child: const Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.black54,
                            size: 25,
                          ),
                        ),
                      )
                    ],
                  ).paddingAll(8),
                );
              }),
            )
            : Container(),
        controller.filesList.length > 2
            ? Padding(
          padding: const EdgeInsets.only(top: 4.0, right: 20, bottom: 10),
          child: InkWell(
            onTap: () {
             // Get.to(HomeworkAttachmentScreen());
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(Constants.VIEWMORE,
                    style: AppStyles.normal.copyWith(
                        fontSize: 12, color: AppColors.darkPinkColor)),
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
            : Container(),
        const Divider(
          height: 1,
          color: Colors.black87,
        ),
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child: Text("CANCEL",
                                style: nunitoExtraBoldTextStyle(
                                    fontSize: 15, color: Colors.black)),
                            onTap: () {
                              print("clicked");
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (type == 1) {
                                classTestItemId = 0;
                                approvalType = -1;
                              }
                              print("Approval Type : ${controller.filesList}");
                              await controller.sendClassTestSubmission(
                                  classTestId: classTestItemId!,
                                  classTestTitle: controller.titleEditController.text,
                                  sectionSubjectItemId: sectionSubjectItemId!,
                                  classTestDesc: controller.descriptionEditController.text,
                                  approvalType: controller.permissionChecked!,
                                  classTestApprovalType: controller.basicSettingsModel!.data!.staffClassTestApprovalType!,
                                  filesList: controller.filesList,
                                  url: "https://test.schoolec.in/api/staff/v2/class-test/class-teacher/today-class-test-submit/$classTestId?date=${controller.selectedDate}");

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkPinkColor,
                              foregroundColor: AppColors.whiteColor,
                              minimumSize: const Size(100, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text("Submit",
                                style: nunitoExtraBoldTextStyle(
                                    fontSize: 15, color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
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

class StaffClassTestCTAttachment {
  File? file;
  String fileName;

  StaffClassTestCTAttachment({required this.file, required this.fileName});
}



