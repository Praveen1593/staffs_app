import 'package:flutter/material.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controller/daily_activities/classtest_controller/classtest_controller.dart';
import '../../../../controller/daily_activities/classtest_controller/classtest_reply_controller.dart';


class StaffReportClasstest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: smsAppbar("Class Test Report"),
        body: GetBuilder<StaffClasstestController>(
            init: StaffClasstestController(),
            builder: (staffClasstestReplyController) =>
            staffClasstestReplyController.studentResultDetailsModel?.code == 200
                ? buildBody(staffClasstestReplyController, context)
                : SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),

        ));

  }

  Widget buildBody(StaffClasstestController controller,
      BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            borderOnForeground: false,
            child:  Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Class test Details",
                        style: nunitoExtraBoldTextStyle(
                            fontSize: 13, color: Colors.black38)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${controller.studentResultDetailsModel?.data?.classTestDetail?.title}",
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
                  ],
                ),
              ),
            )
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: controller.studentList?.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return  Card(
                      borderOnForeground: false,
                      child: Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                   CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor: AppColors.whiteColor,
                                    child: Image.network("${controller.studentList?[index].photo}"),
                                  ),
                                  const SizedBox(width: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(top:10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${controller.studentList?[index].name}",
                                            style: nunitoExtraBoldTextStyle(
                                                fontSize: 15, color: Colors.black)),
                                        const SizedBox(height: 10,),
                                        Text("${controller.studentList?[index].code}",
                                            style: nunitoRegularTextStyle(
                                                fontSize: 13, color: Colors.black)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Visibility(
                                  visible: controller.studentList?[index].classTestResult?.absent==1?false:true,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: CircularPercentIndicator(
                                      radius: 35.0,
                                      lineWidth: 10.0,
                                      percent: 0.41,
                                      center: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:  [
                                          Text(
                                            "${controller.studentList?[index].classTestResult?.totalMark}",
                                            style: const TextStyle(fontSize: 15, color: AppColors.blackColor),//${controller.finalList[index].classTestPastSubject!.resultData!.totalMark??""}
                                          ),
                                          const SizedBox(height: 2,),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 20,right: 20),
                                            child: Divider(
                                              height: 1,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 2,),
                                          Text(
                                            "${controller.studentResultDetailsModel?.data?.classTestDetail?.resultMax}",
                                            style: const TextStyle(fontSize: 15, color: AppColors.blackColor),//${controller.finalList[index].classTestPastSubject!.resultData!.resultMax??""}
                                          ),

                                        ],
                                      ),
                                      progressColor: AppColors.shadeOfIndianRed,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: controller.studentList?[index].classTestResult?.absent==1?true:false,
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text(
                                      "Absent",
                                      style: TextStyle(fontSize: 17, color: AppColors.indianRedColor,fontWeight: FontWeight.bold),//${controller.finalList[index].classTestPastSubject!.resultData!.resultMax??""}
                                    ),
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                      )
                  );
                }),
          ),
        ],
      ),
    );
  }
}
