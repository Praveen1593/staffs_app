import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/staff_common_widgets.dart';
import 'package:flutter_projects/staff/controller/payroll_controller/leave_list_controller/leave_list_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../common/const/colors.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../parent/themes/app_styles.dart';
import '../../custom_dropdown.dart';

class StaffLeaveList extends GetView<LeaveListController> {
  StaffLeaveList({Key? key}) : super(key: key);


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
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "From ${controller.finalList[index].startDate} To ${controller.finalList[index].endDate}",
                                  style: AppStyles.arimBold.copyWith(
                                      color: AppColors.blackColor,
                                      fontSize: 15),
                                ),
                                controller.finalList[index].status==0?
                                InkWell(
                                  onTap: (){
                                    controller.type=1;
                                    controller.leaveRequestId = controller.finalList[index].id;
                                    if(controller.finalList[index].total!=null&&controller.finalList[index].total!=""){
                                      double leaveCount = double.parse(controller.finalList[index].total!);
                                      controller.leaveCount = leaveCount;
                                    }

                                    if(controller.finalList[index].startDate==controller.finalList[index].endDate){
                                      controller.selectedDate = controller.finalList[index].startDate??"";
                                      controller.startDate = controller.finalList[index].startDate??"";
                                    }else{
                                      controller.selectedDate = "${controller.finalList[index].startDate} - ${controller.finalList[index].endDate}";
                                    }
                                    controller.leaveReasonController.text = controller.finalList[index].description.toString();
                                    controller.selectLeaveType = controller.finalList[index].leaveType!.name.toString();

                                    buildSheet1(context);
                                  },
                                  child:  const Icon(
                                    Icons.edit,
                                    color: AppColors.darkPinkColor,
                                  ),
                                ):Container()
                              ],
                            ).paddingOnly(top: 10, right: 10, left: 10),
                            Row(
                              children: [
                                Visibility(
                                  visible: controller.finalList[index].leaveType!=null?true:false,
                                  child: Text(
                                    "Leave Type : ${controller.finalList[index].leaveType?.name}",
                                    style: AppStyles.normal.copyWith(
                                        color: AppColors.greyColor, fontSize: 12),
                                  ).paddingOnly(top: 10, right: 10, left: 10),
                                ),
                                Text(
                                  "Total Days : ${controller.finalList[index].total}",
                                  style: AppStyles.normal.copyWith(
                                      color: AppColors.greyColor, fontSize: 12),
                                ).paddingOnly(top: 10, right: 10, left: 10),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Text(controller.finalList[index].description!=null?
                            "${controller.finalList[index].description}":"",
                              style: AppStyles.arimoRegular.copyWith(
                                  color: AppColors.blackColor, fontSize: 12),
                            ).paddingOnly(top: 10, right: 10, left: 10),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.finalList[index].statusName}",
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                      fontSize: 13, color:
                                  controller.finalList[index].status==0?
                                  AppColors.indianRedColor:AppColors.darkGreenColor),
                                ),
                                Text(
                                  "Applied on ${controller.finalList[index].applyDate}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 12,
                                      color: AppColors.greyColor),
                                )
                              ],
                            ).paddingOnly(
                                top: 10, right: 10, left: 10, bottom: 10)
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
      floatingActionButton: GetBuilder<LeaveListController>(
          init: LeaveListController(),
          builder: (attendanceDetailsController) {
            return ElevatedButton.icon(
              onPressed: () {
                controller.type=0;
                attendanceDetailsController.leaveReasonController.text = "";
                attendanceDetailsController.selectLeaveType = "Select Type";
                buildSheet1(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkPinkColor,
                foregroundColor: AppColors.whiteColor,
                minimumSize: const Size(10, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: const Icon(
                Icons.leaderboard,
                size: 25.0,
                color: AppColors.whiteColor,
              ),
              label: Text('LEAVE REQUEST'), // <-- Text
            );
          }),
    );
  }

  Widget leaveTypeWidget(LeaveListController controller,BuildContext context) {
    return AppDropdownInput(
        options: controller.leaveTypeListData,
        hintText: "Select Type",
      onChanged: (changedValue) {
        controller.updateSelectedLeaveType(changedValue);
        print("drop down : $changedValue");

    },);

  }


  Widget _buildBody1(BuildContext context) {
    return ListView.builder(
        itemCount: controller.leaveRequestList?.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: const LinearGradient(
                      colors: <Color>[AppColors.timetableColor1, AppColors.timetableColor2],
                    ),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.asset(
                            "assets/timetable_icons.png",
                            width: 30,
                            height: 30,
                          ),
                          title: Text("From 20/10/2022 To 20/10/2022",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 13, color: AppColors.blackColor)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Leave Type : LOP",
                                    style: nunitoRegularTextStyle(
                                        fontSize: 13,
                                        color: AppColors.blackColor)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Total Days : 1.0",
                                    style: nunitoRegularTextStyle(
                                        fontSize: 13,
                                        color: AppColors.blackColor)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Approved",
                                    style: nunitoExtraBoldTextStyle(
                                        fontSize: 15,
                                        color: AppColors.darkGreenColor)),
                              ],
                            ),
                          ),
                          trailing: InkWell(
                            onTap: (){
                              controller.typeUpdate(2);
                              buildSheet1(context);
                            },
                            child: Image.asset(
                              "assets/edit_icons.png",
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Applied on 20/10/2022",
                                  style: nunitoRegularTextStyle(
                                      fontSize: 12, color: Colors.grey))
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        });
  }

  Future buildSheet1(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => GetBuilder<LeaveListController>(
        init: LeaveListController(),
        builder: (leaveListController) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.7,
          maxChildSize: 0.8,
          expand: false,
          builder: (_, controllers) => Column(
            children: [
              Icon(
                Icons.remove,
                color: Colors.grey[600],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                  child: ListView(
                    controller: controllers,
                    children: [
                      Text(leaveListController.type!=1?"Create leave Request":"Edit leave Request",
                          style: nunitoExtraBoldTextStyle(
                              fontSize: 15, color: Colors.black)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "You can request for your leave to Admin by giving below information",
                          style: nunitoRegularTextStyle(
                              fontSize: 13, color: Colors.black87)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("leave Date",
                          style: nunitoExtraBoldTextStyle(
                              fontSize: 15, color: Colors.black)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Please select your leave date",
                          style: nunitoRegularTextStyle(
                              fontSize: 13, color: Colors.black87)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 20, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/calendar_icon.png",
                                          width: 30,
                                          height: 30,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("Choose",
                                            style: nunitoExtraBoldTextStyle(
                                                fontSize: 14,
                                                color: Colors.black)),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            leaveListController.selectDate(context);

                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.whiteColor,
                                            foregroundColor: AppColors.whiteColor,
                                            minimumSize: const Size(35, 35),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text("Single Date",
                                              style: nunitoRegularTextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            leaveListController.dateRangeDialog(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.whiteColor,
                                            foregroundColor: AppColors.whiteColor,
                                            minimumSize: const Size(35, 35),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text("Multiple Date",
                                              style: nunitoRegularTextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 20, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(leaveListController.selectedDate.isNotEmpty?leaveListController.selectedDate:"Date not Selected",
                                        style: nunitoExtraBoldTextStyle(
                                            fontSize: 14,
                                            color: AppColors.darkPinkColor)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Number of Leaves",
                          style: nunitoExtraBoldTextStyle(
                              fontSize: 15, color: Colors.black)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(leaveListController.leaveCount==0?"Leave count has been displayed after selection of Date":leaveListController.type==1?"${leaveListController.leaveCount!}":"${leaveListController.leaveCount!}",//
                          style: nunitoRegularTextStyle(
                              fontSize: 13, color: Colors.black87)),
                      const SizedBox(
                        height: 15,
                      ),
                      Text("Leave Type",
                          style: nunitoExtraBoldTextStyle(
                              fontSize: 15, color: Colors.black)),
                      const SizedBox(
                        height: 10,
                      ),
                      //leaveTypeWidget(leaveListController,context),
                      InkWell(
                        onTap: (){
                          showDialog(
                            context: Get.context!,
                            builder: (ctx) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.all(5),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10),
                                      child: Text("Select Leave Type",
                                          style: AppStyles.arimBold.copyWith(
                                              fontSize: 18,
                                              color: AppColors.blackColor))
                                          .paddingOnly(bottom: 15, top: 15),
                                    ),
                                    const SizedBox(height: 10,),
                                    const Divider(
                                      height: 1,
                                      color: Colors.black38,
                                    ),
                                    const SizedBox(height: 10,),
                                    controller.leaveTypeListData.isNotEmpty
                                        ? SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: ListView.builder(
                                          itemCount: controller.leaveTypeListData.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                controller.selectedLeaveTypeId = controller.leaveTypeListData[index].id;
                                                controller.selectLeaveType = controller.leaveTypeListData[index].name??"";
                                                controller.update();
                                                Get.back();
                                              },
                                              child: Padding(padding: const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 20),
                                                child: Text(
                                                    "${controller.leaveTypeListData[index].name}",
                                                    style:
                                                    nunitoRegularTextStyle(
                                                        fontSize: 13,
                                                        color: Colors
                                                            .black)),
                                              ),
                                            );
                                          }),
                                    )
                                        : Container(),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Text(controller.selectLeaveType,
                            style: nunitoRegularTextStyle(
                                fontSize: 13, color: Colors.black87)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text("Leave Reason",
                          style: nunitoExtraBoldTextStyle(
                              fontSize: 15, color: Colors.black)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Please mention your leave reason if any",
                          style: nunitoRegularTextStyle(
                              fontSize: 13, color: Colors.black87)),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 80,
                        color: Colors.grey.shade300,
                        child: _textFormField(leaveListController,
                            leaveListController.leaveReasonController, 10, 10),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                child: Text("CANCEL",
                                    style: nunitoExtraBoldTextStyle(
                                        fontSize: 15, color: Colors.black)),
                                onTap: (){
                                  print("clicked");
                                  Get.back();
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if(controller.selectedDate==""){
                                    Get.snackbar("","choose Date" ,snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                                   // showStaffToastMsg("Choose Date");
                                  }else if(controller.leaveReasonController.text==""){
                                    Get.snackbar("","Enter leave reason" ,snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                                   // showStaffToastMsg("Enter leave reason");
                                  }else if(controller.selectLeaveType=="Select Type"){
                                    Get.snackbar("","Select leave type" ,snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                                   // showStaffToastMsg("Select leave type");
                                  }else{
                                    Get.back();
                                    if(controller.type==1){

                                      var inputFormat = DateFormat('dd/MM/yyyy');
                                      var date1 = inputFormat.parse(controller.startDate);
                                      var outputFormat = DateFormat('yyyy-MM-dd');
                                      var date2 = outputFormat.format(date1); // 201

                                      Map<String,dynamic> mapData = {
                                        "leave_type_id":controller.selectedLeaveTypeId,
                                        "leave_request_id":controller.leaveRequestId,
                                        "start_date": date2,
                                        "end_date":controller.endDate,
                                        "description":controller.leaveReasonController.text,
                                        "half_day_leave":0,
                                      };
                                      await controller.leaveRequestEdit(mapData);
                                      // if(controller.createResponce!=null){
                                      //   controller.fetchLeaveTypeListData();
                                      // //  Get.lazyPut(() => controller);
                                      //   // controller.update();
                                      // }

                                    }else{

                                      Map<String,dynamic> mapData = {
                                        "leave_type_id":controller.selectedLeaveTypeId,
                                        "start_date":controller.startDate,
                                        "end_date":controller.endDate,
                                        "description":controller.leaveReasonController.text,
                                        "half_day_leave":0,
                                      };

                                      await controller.leaveRequestCreate(mapData);
                                      if(controller.createResponce!=null){
                                        controller.fetchLeaveTypeListData();
                                        Get.lazyPut(() => controller);
                                        // controller.update();
                                      }


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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  TextFormField _textFormField(
      LeaveListController controller,
      TextEditingController textEditingController,
      double verticalPadding,
      double horizontalPadding) {
    return TextFormField(
        keyboardType: TextInputType.number,
        maxLines: null,
        textAlign: TextAlign.start,
        controller: textEditingController,
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
}
