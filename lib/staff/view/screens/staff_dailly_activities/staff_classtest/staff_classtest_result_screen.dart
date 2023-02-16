import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:get/get.dart';

import '../../../../../common/services/base_client.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../parent/themes/app_styles.dart';
import '../../../../../parent/view/dialogs/dialog_helper.dart';
import '../../../../controller/daily_activities/classtest_controller/classtest_controller.dart';
import '../../../../controller/daily_activities/classtest_controller/classtest_reply_controller.dart';

class StaffResultClasstest extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey.shade100,
        appBar: smsAppbar("Class Test Result"),
        body: GetBuilder<StaffClasstestController>(
          init: StaffClasstestController(),
          builder: (staffClasstestController) {
            print("StaffResultClasstest :result code ${staffClasstestController.studentResultDetailsModel?.code}");
            return staffClasstestController.studentResultDetailsModel?.code == 200
                  ? buildBody(staffClasstestController, context)
                  : SizedBox(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
          },
        ));
  }

  TextFormField _textFormField(
      StaffClasstestController controller,
      TextEditingController textEditingController,
      double verticalPadding,
      double horizontalPadding,
      String value,
      int type,
      int index) {
    return TextFormField(
        controller: type == 1
            ? controller.maxMarkEditController
            : controller.studentList?[index].markController,
        keyboardType: TextInputType.number,
        maxLines: null,
        inputFormatters: [
          LengthLimitingTextInputFormatter(3),
        ],
        onChanged: (value) {
          if (type == 1) {
            controller.studentResultDetailsModel?.data?.classTestDetail
                ?.resultMax = int.parse(value);
          } else {
            int val = value.isNotEmpty?int.parse(value):0;
            int? result = controller.studentResultDetailsModel?.data?.classTestDetail?.resultMax??0;

            print("val : $val");
            print("result : $result");
            if(val<=result){
              controller.studentList?[index].classTestResult?.totalMark = value;
              print("onchanged : Valid");
            }else{
              //showToastMsg("Invalid Mark");
              controller.studentList?[index].markController?.clear();
              print("onchanged : Invalid Mark");
            }




          }
        },
        textAlign: TextAlign.center,
        //  controller: textEditingController,
        cursorColor: AppColors.darkPinkColor,
        decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          fillColor: Colors.grey.shade300,
        ),
        style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 15, color: Colors.black));
  }

  Widget buildBody(StaffClasstestController controller, BuildContext context) {
    return Column(
      children: [
        Card(
          borderOnForeground: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Class test Details",
                        style: nunitoExtraBoldTextStyle(
                            fontSize: 13, color: Colors.black38)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        "${controller.studentResultDetailsModel?.data?.classTestDetail?.title}",
                        style: nunitoExtraBoldTextStyle(
                            fontSize: 13, color: Colors.black)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        "${controller.studentResultDetailsModel?.data?.classTestDetail?.description}",
                        style: nunitoRegularTextStyle(
                            fontSize: 12, color: Colors.black38)),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Max Result Mark",
                                style: nunitoExtraBoldTextStyle(
                                    fontSize: 13, color: Colors.black)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Enter maximum mark of the test Eg : 100",
                                style: nunitoRegularTextStyle(
                                    fontSize: 12, color: Colors.black38)),
                          ],
                        ),
                        Container(
                          width: 80,
                          color: Colors.grey.shade300,
                          child: Center(
                            child: _textFormField(
                                controller,
                                controller.maxMarkEditController,
                                10,
                                10,
                                controller.studentResultDetailsModel?.data
                                        ?.classTestDetail?.resultMax
                                        .toString() ??
                                    "",
                                1,
                                -1),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: ListView.builder(
                      itemCount: controller.studentList?.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        controller.studentList?[index].markController = TextEditingController(text: controller.studentList?[index].classTestResult?.totalMark.toString());
                        if(controller.studentList?[index].classTestResult?.absent==1){
                          controller.studentList?[index].classTestResult?.absentRef = "Absent Marked";
                        }else{
                          controller.studentList?[index].classTestResult?.absentRef = "Mark";
                        }
                        return Card(
                            borderOnForeground: false,
                            child: ListTile(
                              leading: const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: AppColors.darkPinkColor,
                                ),
                              ),
                              title: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 10),
                                child: Text(
                                    "${controller.studentList?[index].name} - ${controller.studentList?[index].code}",
                                    style: nunitoExtraBoldTextStyle(
                                        fontSize: 15, color: Colors.black)),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Text(
                                        "${controller.studentList?[index].classTestResult?.absentRef}",
                                        style: nunitoExtraBoldTextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade500)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: controller.studentList?[index]
                                                  .classTestResult?.absent ==
                                              0
                                          ? true
                                          : false,
                                      child: Container(
                                        width: 80,
                                        color: Colors.grey.shade300,
                                        child: Center(
                                          child: _textFormField(
                                              controller,
                                              controller.markEditController,
                                              10,
                                              10,
                                              controller.studentList?[index]
                                                      .markController?.text ??
                                                  "",
                                              2,
                                              index),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: controller
                                                        .studentList?[index]
                                                        .classTestResult
                                                        ?.absent ==
                                                    0
                                                ? false
                                                : true,
                                            onChanged: (value) {
                                              if (value!) {
                                                controller
                                                    .studentList?[index]
                                                    .classTestResult
                                                    ?.absent = 1;
                                                controller
                                                        .studentList?[index]
                                                        .classTestResult
                                                        ?.absentRef =
                                                    "Absent marked";
                                              } else {
                                                controller
                                                    .studentList?[index]
                                                    .classTestResult
                                                    ?.absent = 0;
                                                controller
                                                    .studentList?[index]
                                                    .classTestResult
                                                    ?.absentRef = "Mark";
                                              }
                                              controller.update();
                                              // controller.absentUpdate(
                                              //     value!, index);
                                            }),
                                        Text("Absent",
                                            style: nunitoRegularTextStyle(
                                                fontSize: 11,
                                                color: Colors.grey.shade500)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            AppColors.indigo1Color,
                            AppColors.indigo2Color
                          ],
                        )),
                    child: SMSButtonWidget(
                        onPress: () async {

                          int valid =0;
                          for(int i=0;i<controller.studentList!.length;i++){

                            if(controller.studentList![i].markController!=null&&controller.studentList![i].markController!.text.isEmpty){
                              //showToastMsg("Enter ${controller.studentList![i].name} Mark");
                              valid=2;
                              break;
                            }else{
                              valid=1;
                            }

                          }
                          print("value : $valid");
                          if(valid==1){
                            Map<String, dynamic> mapData = {
                              "result_max": controller.studentResultDetailsModel?.data
                                  ?.classTestDetail?.resultMax,
                              "student_result": controller.studentList,
                            };


                            int result =
                            await controller.studentResultSubmit(mapData);
                            if (result == 200) {
                              Get.back();
                            }
                          }
                        },
                        primaryColor: Colors.transparent,
                        text: "Submit",
                        width: Get.width,
                        height: 45,
                        borderRadius: 0),
                  ),
                )
                /*      InkWell(
                  onTap: ()async{
                    Map<String,dynamic> mapData = {
                      "result_max":controller.studentResultDetailsModel?.data?.classTestDetail?.resultMax,
                      "student_result":controller.studentList,
                    };
                    int result = await controller.studentResultSubmit(mapData);
                    if(result==200){
                      Get.back();
                    }
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: <Color>[
                          AppColors.indigo1Color,
                          AppColors.indigo2Color
                        ],
                      )),
                      height: 50,
                      child: Center(
                        child: Text("Submit",
                            style: nunitoExtraBoldTextStyle(
                                fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        )
      ],
    );
  }
}
