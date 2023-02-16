import 'package:flutter/material.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_reply_entry_screen.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controller/daily_activities/homework_controller/homework_class_teacher_controller.dart';

class StaffReplyHomework extends StatelessWidget {
  int? hwId;

  StaffReplyHomework({this.hwId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: smsAppbar("Staff Reply"),
        body: GetBuilder<StaffClassTeacherHomeworkController>(
            init: StaffClassTeacherHomeworkController(),
            builder: (staffClassTeacherHomeworkController) {
              return staffClassTeacherHomeworkController
                              .staffHomeworkStudentReplyList !=
                          null &&
                      staffClassTeacherHomeworkController
                          .staffHomeworkStudentReplyList!.data!.isNotEmpty
                  ? buildBody(staffClassTeacherHomeworkController, context)
                  : SizedBox(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
            }));
  }

  Widget buildBody(
      StaffClassTeacherHomeworkController controller, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  controller.updateReplySelection(1);
                                  controller.staffReplyEntryList1=[];
                                },
                                child: Container(
                                  height: 50,
                                  color: controller.multiReplySelect
                                      ? AppColors.darkPinkColor
                                      : Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Multiple Reply",
                                          style: nunitoExtraBoldTextStyle(
                                              fontSize: 12,
                                              color: controller.multiReplySelect
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              width: 20,
                              color: Colors.black,
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  controller.updateReplySelection(2);
                                  controller.staffReplyEntryList1=[];
                                  for(int i=0;i<controller.studentReplyList!.length;i++){
                                    controller.staffReplyEntryList1?.add(controller.studentReplyList?[i].id??0);
                                  }

                                },
                                child: Container(
                                  height: 50,
                                  color: controller.overallReplySelect
                                      ? AppColors.darkPinkColor
                                      : Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Overall Reply",
                                          style: nunitoExtraBoldTextStyle(
                                              fontSize: 12,
                                              color:
                                                  controller.overallReplySelect
                                                      ? Colors.white
                                                      : Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              const Divider(
                height: 1,
                color: Colors.black87,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: controller.multiReplySelect == true ||
                          controller.overallReplySelect == true
                      ? Get.height * 0.7
                      : Get.height * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.studentReplyList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 25.0,
                              backgroundColor: AppColors.darkPinkColor,
                            ),
                            trailing: controller.multiReplySelect == true ||
                                    controller.overallReplySelect == true
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Checkbox(
                                      value: controller.multiReplySelect
                                          ? controller.studentReplyList![index]
                                              .checkboxClick
                                          : true,
                                      onChanged: (bool? value) {
                                        controller.studentReplyList?[index]
                                            .checkboxClick = value!;
                                        controller.multipleReplyCheckboxUpdate(
                                            controller.studentReplyList?[index]
                                                    .id ??
                                                0,value!);
                                      },
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      controller.staffReplyEditController.text =
                                          controller
                                                  .studentReplyList?[index]
                                                  .staffReply
                                                  ?.staffDescription ??
                                              "";
                                      Get.to(StaffReplyEntryHomework(
                                        hwId: hwId,
                                        replyId: controller
                                            .studentReplyList?[index].id,
                                      ));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text("Reply",
                                          style: nunitoExtraBoldTextStyle(
                                              fontSize: 15,
                                              color: AppColors.darkPinkColor)),
                                    ),
                                  ),
                            title: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${controller.studentReplyList?[index].studentReply?.studentName}",
                                      style: nunitoExtraBoldTextStyle(
                                          fontSize: 15, color: Colors.black87)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "${controller.studentReplyList?[index].studentReply?.date}",
                                      style: nunitoRegularTextStyle(
                                          fontSize: 10, color: Colors.black)),
                                ],
                              ),
                            ),
                            subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Student Reply",
                                        style: nunitoExtraBoldTextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        "${controller.studentReplyList?[index].studentReply?.stuDescription}",
                                        style: nunitoRegularTextStyle(
                                            fontSize: 10, color: Colors.black)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    controller.studentReplyList?[index]
                                                    .staffReply !=
                                                null &&
                                            controller
                                                    .studentReplyList?[index]
                                                    .staffReply
                                                    ?.staffDescription !=
                                                null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Staff Reply",
                                                  style:
                                                      nunitoExtraBoldTextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "${controller.studentReplyList?[index].staffReply?.staffDescription}",
                                                  style: nunitoRegularTextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black)),
                                            ],
                                          )
                                        : Container()
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        controller.multiReplySelect == true ||
                controller.overallReplySelect == true
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.staffReplyEditController.text = "";
                        Get.to(StaffReplyEntryHomework());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkPinkColor,
                        foregroundColor: AppColors.whiteColor,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Reply",
                          style: nunitoExtraBoldTextStyle(
                              fontSize: 15, color: Colors.white)),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  Widget buildSheet() {
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
              Container(
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
              const SizedBox(
                width: 20,
              ),
              Container(
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
            ],
          )
        ],
      ),
    );
  }
}
