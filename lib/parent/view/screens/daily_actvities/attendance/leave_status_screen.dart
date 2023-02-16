import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../controllers/attendance_controller/attendance_details_controller.dart';
import '../../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';
import 'create_leave_request_screen.dart';
import 'package:intl/intl.dart';

class LeaveStatusScreen extends GetView<AttendanceDetailsController> {
  const LeaveStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: smsAppbar("Leave Status"),
      body: Obx(() {
        final loadingType = controller.loadingState.value.loadingType;
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (controller.finalList.isEmpty) {
          return const Center(child: Text("No Data"));
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
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "From",
                                                  style: AppStyles.PoppinsRegular.copyWith(
                                                      color: Color(0XFF93A0A7),
                                                      fontSize: 14),
                                                ),
                                                Spacer(),
                                                Text(
                                                  ":",
                                                  style: AppStyles.PoppinsRegular.copyWith(
                                                      color: Color(0XFF93A0A7),
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            width: 50,
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "${controller.finalList[index].startDate}",
                                            style: AppStyles.PoppinsRegular.copyWith(
                                                color: Color(0XFF252525),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Row(
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "To",
                                                  style: AppStyles.PoppinsRegular.copyWith(
                                                      color: Color(0XFF93A0A7),
                                                      fontSize: 14),
                                                ),
                                                Spacer(),
                                                Text(
                                                  ":",
                                                  style: AppStyles.PoppinsRegular.copyWith(
                                                      color: Color(0XFF93A0A7),
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            width: 50,
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "${controller.finalList[index].endDate}",
                                            style: AppStyles.PoppinsRegular.copyWith(
                                                color: Color(0XFF252525),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0XFFF2F5FA),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child:  controller.finalList[index].status==0?
                                    InkWell(
                                      onTap: (){
                                        controller.editFlag  = 1;
                                        controller.leaveRequestId  = controller.finalList[index].id;
                                        controller.noOfLeaves.text = "${controller.finalList[index].total}";
                                        DateTime dateTime = DateFormat("dd/MM/yyyy").parse(controller.finalList![index].startDate.toString());
                                        controller.startDateController.text = DateFormat('yyyy-MM-dd').format(dateTime);
                                        controller.leaveDateController.text = DateFormat('yyyy-MM-dd').format(dateTime);
                                        controller.endDateController.text = "${controller.finalList[index].endDate}";
                                        controller.descriptionController.text = "${controller.finalList[index].description}";

                                        for(int i=0;i<controller.selectedLeaveList1.length;i++){

                                          if(i!=0){
                                            if(controller.finalList[index].halfDayLeave==0){
                                              controller.selectedLeaveType = "Full Day";
                                              break;
                                            }else if(controller.finalList[index].halfDayLeave==1){
                                              controller.selectedLeaveType = "AN leave Start date";
                                              break;
                                            }else if(controller.finalList[index].halfDayLeave==2){
                                              controller.selectedLeaveType = "MN leave to End date";
                                              break;
                                            }else if(controller.finalList[index].halfDayLeave==3){
                                              controller.selectedLeaveType = "AN leave in Start date & MN leave in End date";
                                              break;
                                            }
                                          }
                                        }
                                        print("Leave Type Value :  ${controller.selectedLeaveType}");
                                        print("Leave Type id in Api :  ${controller.finalList[index].halfDayLeave}");


                                        Get.to(const CreateLeaveRequestScreen());
                                      },
                                      child:  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SMSImageAsset(image: "assets/campuseasy/leave_status_edit_image.png",),
                                      ),
                                    ):Container(),
                                  )

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Text(
                                "${controller.finalList[index].description}",
                                style: AppStyles.PoppinsRegular.copyWith(
                                    color: Color(0XFF252525), fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Status :",
                                    style: AppStyles.PoppinsRegular.copyWith(
                                        color: Color(0XFF93A0A7), fontSize: 13),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    "${controller.finalList[index].statusName}",
                                    style: AppStyles.PoppinsRegular.copyWith(
                                        color:controller.finalList[index].status==0?Color(0XFF407BFF):controller.finalList[index].status==1?Color(0XFF5B9D00):Color(0XFFE93E3A), fontSize: 13),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      SMSImageAsset(image: "assets/campuseasy/leave_clock_image.png",width: 10,height: 10,),
                                      SizedBox(width: 5,),
                                      Text(
                                        "Applied on ${controller.finalList[index].applyDate}",
                                        style: AppStyles.PoppinsRegular.copyWith(
                                            fontSize: 12,
                                            color: Color(0XFF93A0A7)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
                separatorBuilder: (context, index) => Container(),
              ),
            )
          ],
        );
      }),
      floatingActionButton: GetBuilder<AttendanceDetailsController>(
          init: AttendanceDetailsController(),
          builder: (attendanceDetailsController) {
            return InkWell(
              onTap: (){
                attendanceDetailsController.startDate = "";
                attendanceDetailsController.endDate = "";
                attendanceDetailsController.descriptionController.text="";
                attendanceDetailsController.selectedLeaveType = "Select Leave Type";
                attendanceDetailsController.selectedLeaveTypeValue=-1;
                attendanceDetailsController.editFlag  = 0;
                attendanceDetailsController.openDialogValue = false;
                Get.to(const CreateLeaveRequestScreen());
              },
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0XFF407BFF),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Raise Leave Request',style: AppStyles.PoppinsBold.copyWith(fontSize: 16,color: Color(0XFFFFFFFF))),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SMSImageAsset(image: "assets/campuseasy/leave_request_raise.png"),
                    )
                  ],
                ),
              ),
            );
          }),
    );




  }
}
