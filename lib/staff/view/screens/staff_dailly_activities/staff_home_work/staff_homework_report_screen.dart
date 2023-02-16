import 'package:flutter/material.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:flutter_projects/staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_reply_entry_screen.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controller/daily_activities/homework_controller/homework_reply_controller.dart';

class StaffReportHomework extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffHomeworkReplyController>(
        init: StaffHomeworkReplyController(),
        builder: (staffHomeworkReplyController) => Scaffold(
            backgroundColor: Colors.white,
            appBar: smsAppbar("Staff Report"),
            body: buildBody(staffHomeworkReplyController, context)));
  }

  Widget buildBody(
      StaffHomeworkReplyController controller, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        controller.updateIndex(1);
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
                        controller.updateIndex(2);
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
                                    color: controller.overallReplySelect
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
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
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
                        value: controller.multiReplySelect ? false : true,
                        onChanged: (bool? value) {},
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Get.to(StaffReplyEntryHomework());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text("Reply",
                            style: nunitoExtraBoldTextStyle(
                                fontSize: 15, color: AppColors.darkPinkColor)),
                      ),
                    ),
              title: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tamil - HW9462",
                        style: nunitoExtraBoldTextStyle(
                            fontSize: 15, color: Colors.black87)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("UKG - A | 11/01/2016",
                        style: nunitoRegularTextStyle(
                            fontSize: 10, color: Colors.black)),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("test",
                        style: nunitoExtraBoldTextStyle(
                            fontSize: 15, color: Colors.black87)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("test",
                        style: nunitoRegularTextStyle(
                            fontSize: 10, color: Colors.black)),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: controller.multiReplySelect == true ||
                              controller.overallReplySelect == true
                          ? ElevatedButton(
                              onPressed: () {
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
                            )
                          : Container()),
                ),
              ],
            ),
          ),
        )
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
