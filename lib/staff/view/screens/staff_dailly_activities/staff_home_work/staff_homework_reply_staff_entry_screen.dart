import 'package:flutter/material.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../parent/themes/app_styles.dart';
import '../../../../controller/daily_activities/homework_controller/homework_controller.dart';
import '../../../../model/StaffHomeworkStaffReplyResponce.dart';

class StaffReplyStaffEntryHomework extends StatelessWidget {
  int? hwId;
  int? replyId;
  int? initialRating;

  StaffReplyStaffEntryHomework({this.hwId,this.initialRating, this.replyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: smsAppbar("Staff Reply"),
        body: GetBuilder<StaffHomeworkController>(
            init: StaffHomeworkController(),
            builder: (staffClassTeacherHomeworkController) =>
                buildBody(staffClassTeacherHomeworkController, context)));
  }

  TextFormField _textFormField(
      StaffHomeworkController controller,
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

  Widget buildBody(StaffHomeworkController controller, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Staff Reply",
                style: nunitoExtraBoldTextStyle(
                    fontSize: 15, color: Colors.black)),
            const SizedBox(
              height: 10,
            ),
            _textFormField(
                controller, controller.staffReplyEditController, 50, 10),
            const SizedBox(
              height: 30,
            ),
            Text("Rating",
                style: nunitoExtraBoldTextStyle(
                    fontSize: 15, color: Colors.black)),
            const SizedBox(
                  height: 10,
                ),
            RatingBar(
              minRating: 1,
              maxRating: 5,
              allowHalfRating: false,
              initialRating: initialRating!.toDouble(),
              itemCount: 5,
              itemSize: 45,
              glow: false,
              updateOnDrag: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  half: const Icon(
                    Icons.star,
                    color: Colors.blue,
                  ),
                  empty: const Icon(
                    Icons.star,
                    color: Colors.grey,
                  )),
              onRatingUpdate: (double value) {
                controller.ratingValue = value.toInt();
                controller.update();
                //print("rating : ${value.toInt()}");
              },
            ),
            Visibility(
              visible: false,
              child: Row(
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
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => buildSheet());
                            },
                            child: const Icon(
                              Icons.add,
                              color: AppColors.darkPinkColor,
                            ),
                          ))),
                ],
              ),
            ),
          ]),
        ),
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
                              if (controller.overallReplySelect ||
                                  controller.multiReplySelect) {
                                Map<String, dynamic> mapData = {
                                  "student_reply_id":
                                      controller.staffReplyEntryList1,
                                  "staff_description": controller
                                      .staffReplyEditController.text, //
                                  "staff_rating": controller.ratingValue,
                                };
                                int result =
                                    await controller.staffReplyMultiSubmit(
                                        mapData, controller.replyId ?? 0);
                                if (result == 200) {
                                  Get.back();
                                  Get.put(StaffHomeworkController())
                                      .studentReplyData();
                                }
                              } else {
                                Map<String, dynamic> mapData = {
                                  "staff_description":
                                      controller.staffReplyEditController.text,
                                  "staff_rating": controller.ratingValue,
                                  "student_reply_id": replyId,
                                };
                                StaffHomeworkStaffReplyResponce?
                                    staffHomeworkStaffReplyResponce =
                                    await controller.staffReplySingleSubmit(
                                        mapData, replyId ?? 0);
                                if (staffHomeworkStaffReplyResponce != null &&
                                    staffHomeworkStaffReplyResponce.code ==
                                        200) {
                                  Get.back();
                                  Get.put(StaffHomeworkController())
                                      .studentReplyData();
                                }
                              }
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
