import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/staff_common_widgets.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../../../common/apihelper/api_helper.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/routes/app_routes.dart';
import '../../../../controllers/attendance_controller/attendance_details_controller.dart';
import '../../../../model/leave_create_responce_model.dart';
import '../../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../storage.dart';

class CreateLeaveRequestScreen extends StatefulWidget {
  const CreateLeaveRequestScreen({Key? key}) : super(key: key);

  @override
  State<CreateLeaveRequestScreen> createState() =>
      _CreateLeaveRequestScreenState();
}

class _CreateLeaveRequestScreenState extends State<CreateLeaveRequestScreen> {
  int _currentValue = 1;
  @override
  void initState() {
    super.initState();
    _currentValue = 1;
   /* Get.put<AttendanceDetailsController>(AttendanceDetailsController()).editFlag!=1?
    _selectLeaveWidget():Container();*/
  }

  void _selectLeaveWidget() {
    Future.delayed(const Duration(seconds: 0), () {
      return  showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(title:
                  GetBuilder<AttendanceDetailsController>(
                      builder: (controller) {
                return Column(
                  children: [
                    Text(
                      "Select Leave",
                      style: AppStyles.NunitoExtrabold.copyWith(
                          fontSize: 15, color: AppColors.darkPinkColor),
                    ),
                    Text(
                      '''Scroll the Number to select the\n           Leave you need''',
                      style: AppStyles.NunitoRegular.copyWith(
                          fontSize: 13, color: AppColors.greyColor),
                    ),
                    _numberLeavesWidget(controller),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SMSButtonWidget(
                          onPress: () {
                            if (_currentValue > 1) {
                              controller.dateRangeDialog(context).then((value) {
                                if (value != null) {
                                  Get.back();
                                  controller.updateOpenDialogValue(true);
                                  controller.noOfLeaves.text = value.end
                                      .difference(value.start)
                                      .inDays
                                      .toString();
                                }
                              });
                            } else {
                              controller.selectDate(context).then((value) {
                                if (value != null) {
                                  Get.back();
                                  controller.updateOpenDialogValue(true);
                                  controller.noOfLeaves.text = "1";
                                }
                              });
                            }
                          },
                          text: " SET ",
                          width: 10,
                          height: 40,
                          borderRadius: 5,
                          primaryColor: AppColors.darkPinkColor,
                        ),
                        SMSButtonWidget(
                            onPress: () {
                              Get.toNamed(AppRoutes.LEAVESTATUS);
                            },
                            text: "CANCEL",
                            width: 10,
                            height: 40,
                            borderRadius: 5,
                            primaryColor: AppColors.darkPinkColor),
                      ],
                    )
                  ],
                );
              })));
    });
  }

  Widget _numberLeavesWidget(AttendanceDetailsController controller) {
    return StatefulBuilder(builder: (context4, setState2) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: NumberPicker(
          textStyle: AppStyles.NunitoRegular.copyWith(
              color: AppColors.greyColor, fontSize: 14),
          selectedTextStyle: AppStyles.NunitoRegular.copyWith(
              color: AppColors.blackColor, fontSize: 14),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              top: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          value: _currentValue,
          minValue: 1,
          maxValue: 100,
          onChanged: (value) {
            setState2(() {
              _currentValue = value;
              controller.noOfLeaves.text = _currentValue.toString();
              controller.update();
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
     String? endDateTxt;
     String? startDateTxt;
    return Scaffold(
        backgroundColor: Color(0XFFF5F5F5),
        appBar: smsAppbar("Leave Request"),
        body: GetBuilder<AttendanceDetailsController>(
            builder: (attendanceController) {
          return Visibility(//attendanceController.editFlag!=1?attendanceController.openDialogValue ? true : false:true
            visible: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      Text("Apply your leave request",
                          style: AppStyles.PoppinsBold.copyWith(
                              fontSize: 15, color: Color(0XFF252525))),
                      //_buildText("No of Leaves"),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          //attendanceController.dateRangeDialog(context);



                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0XFFF2F5FA),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text("No of Leaves",
                                    style: AppStyles.PoppinsRegular.copyWith(
                                        fontSize: 15, color: Color(0XFF252525))),
                              ),
                              /*SMSTextFieldWidget(
                                controller:
                                attendanceController.startDateController,
                                onTap: () {
                                  attendanceController.dateRangeDialog(context);
                                },
                              ),*/
                              Spacer(),
                              Row(
                                children: [
                                  InkWell(
                                      child: Icon(Icons.arrow_back_ios,size: 20,color: Color(0XFF252525),),
                                    onTap: (){
                                        int val = attendanceController.numLeave!;
                                        if(val>1){
                                          attendanceController.numLeave = attendanceController.numLeave!-1;
                                          attendanceController.update();
                                        }

                                    },
                                  ),
                                  SizedBox(width: 10,),
                                  Text("${attendanceController.numLeave.toString()}",
                                      style: AppStyles.PoppinsBold.copyWith(
                                          fontSize: 15, color: Color(0XFF252525))),
                                  SizedBox(width: 10,),
                                  InkWell(child: Icon(Icons.arrow_forward_ios,size: 20,color: Color(0XFF252525),),
                                    onTap: (){
                                      attendanceController.numLeave = attendanceController.numLeave!+1;
                                      attendanceController.update();
                                    },
                                  ),
                                  SizedBox(width: 10,),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){

                          if(attendanceController.numLeave!>1){
                            attendanceController.dateRangeDialog(context);
                          }else{
                            attendanceController.endDate = "";
                            attendanceController.selectDate(context);
                          }

                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0XFFF2F5FA),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text("Date",
                                    style: AppStyles.PoppinsRegular.copyWith(
                                        fontSize: 15, color: Color(0XFF252525))),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text(attendanceController.endDate.isEmpty?"${attendanceController.startDate}": "${attendanceController.startDate} - ${attendanceController.endDate}",
                                      style: AppStyles.PoppinsRegular.copyWith(
                                          fontSize: 15, color: Color(0XFF5F89DB))),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SMSImageAsset(image: "assets/campuseasy/leave_calendar.png"),
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          if(attendanceController.numLeave!>1){
                            attendanceController.dateRangeDialog(context);
                          }else{
                            attendanceController.selectDate(context);
                          }

                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0XFFF2F5FA),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text("Type",
                                    style: AppStyles.PoppinsRegular.copyWith(
                                        fontSize: 15, color: Color(0XFF252525))),
                              ),
                              Spacer(),
                              leaveTypeWidget1(attendanceController),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: Color(0XFFF2F5FA),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,top: 10),
                          child: TextFormField(
                            minLines: 5,
                            // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            controller: attendanceController.descriptionController,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Reason",
                              border: InputBorder.none,
                              errorStyle:
                              const TextStyle(height: 0, color: AppColors.redColor),
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF252525),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      InkWell(
                        onTap: ()async{
                          Map<String, dynamic> mapData1={};
                          Map<String, dynamic> mapData2={};

                          if(attendanceController.editFlag!=1){

                            String startDate;
                            String? endDate;//attendanceController.numLeave
                            if(attendanceController.numLeave!>1){

                              startDate = attendanceController.startDate;
                              endDate = attendanceController.endDate;

                            }else{
                              startDate = attendanceController.startDate;
                            }


                            mapData1 = {
                              "student_id": LocalStorage.getValue("studentId"),
                              "start_date": startDate,
                              "end_date": endDate??"",
                              "description": attendanceController.descriptionController.text,
                              "half_day_leave": attendanceController.selectedLeaveTypeValue.toString(),
                            };
                            LeaveCreateResponceModel? leaveCreateData = await attendanceController.leaveRequestCreate(ApiHelper.leaveCreateUrl,1,mapData1);
                            if (leaveCreateData != null && leaveCreateData.code == 200) {//
                              Get.back();
                              Get.snackbar("Success","Leave Created Successfully", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                              //showStaffToastMsg("Leave Created Successfully");
                              attendanceController.getLeaveListData();
                            } else {
                              print("Leave Create Response : fail");
                            }
                          }else{

                            String startDate;
                            String? endDate;
                            if(attendanceController.numLeave!>1){

                              startDate = attendanceController.startDate;
                              endDate = attendanceController.endDate;

                            }else{
                              startDate = attendanceController.startDate;
                              endDate = startDate;
                            }

                            /* DateTime tempStartDate = DateFormat("dd/mm/yyyy").parse(attendanceController.startDateController.text);
                            String temp = double.parse(attendanceController.noOfLeaves.text).toInt()>1? attendanceController.endDateController.text:"";
                            if(temp.isNotEmpty){
                              DateTime tempEndDate = DateFormat("dd/mm/yyyy").parse(temp);
                              endDate = DateFormat('yyyy-mm-dd').format(tempEndDate);
                            }
                            startDate = DateFormat('yyyy-mm-dd').format(tempStartDate);*/

                            print("student_id : ${LocalStorage.getValue("studentId")}");
                            print("leave_request_id : ${attendanceController.leaveRequestId}");
                            print("start_date : $startDate");
                            print("end_date : $endDate");
                            print("description : ${attendanceController.descriptionController.text}");
                            print("half_day_leave : ${attendanceController.selectedLeaveTypeValue.toString()}");


                            mapData2 = {
                              "student_id": LocalStorage.getValue("studentId"),
                              "leave_request_id": attendanceController.leaveRequestId,
                              "start_date": startDate,
                              "end_date": endDate ?? "",
                              "description": attendanceController.descriptionController.text,
                              "half_day_leave": attendanceController.selectedLeaveTypeValue.toString(),//
                            };

                            LeaveCreateResponceModel? leaveCreateData = await attendanceController.leaveRequestCreate("${ApiHelper.leaveEditUrl}",2,mapData2);
                            if (leaveCreateData != null && leaveCreateData.code == 200) {
                              Get.back();
                              Get.snackbar("Updated", "", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                            //  showStaffToastMsg("Updated");
                              attendanceController.getLeaveListData();
                              print("Leave Edit Response : pass");
                            } else {
                              print("Leave Edit Response : fail");
                            }
                          }
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0XFF407BFF),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: Text("Submit Leave",
                                style: AppStyles.PoppinsBold.copyWith(
                                    fontSize: 15, color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),

                     /* SMSTextFieldWidget(
                        controller: attendanceController.noOfLeaves,
                        onTap: () {
                          attendanceController.noOfLeaves.text = "";
                          attendanceController.startDateController.text = "";
                          attendanceController.endDateController.text = "";
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  title:
                                      _numberLeavesWidget(attendanceController)));
                        },
                      ).paddingOnly(bottom: 20),
                        //double.parse(attendanceController.noOfLeaves.text).toInt()
                        1 > 1 //_currentValue
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildText("Start Date"),
                                SMSTextFieldWidget(
                                  controller:
                                      attendanceController.startDateController,
                                  onTap: () {
                                    attendanceController.dateRangeDialog(context);
                                  },
                                ).paddingOnly(bottom: 20),
                                _buildText("End Date"),
                                SMSTextFieldWidget(
                                  controller:
                                      attendanceController.endDateController,
                                  onTap: () {
                                    attendanceController.dateRangeDialog(context);
                                  },
                                ).paddingOnly(bottom: 20),
                              ],
                            ) : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildText("Leave Date"),
                                SMSTextFieldWidget(
                                  controller:
                                      attendanceController.leaveDateController,
                                  onTap: (){
                                    attendanceController.selectDate(context);
                                  },
                                ).paddingOnly(bottom: 20),
                              ],
                            ),*/
                     // _buildText("Leave Type"),
                     // leaveTypeWidget(attendanceController).paddingOnly(bottom: 20),
                     // _buildText("Leave Reason"),
                     /* TextFormField(
                        minLines: 5,
                        // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        controller: attendanceController.descriptionController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Reason for Leave",
                          errorStyle:
                              const TextStyle(height: 0, color: AppColors.redColor),
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF969A9D),
                            fontWeight: FontWeight.w300,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.blackColor, width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.blackColor, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.blackColor, width: 1)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: AppColors.redColor, width: 1),
                          ),
                        ),
                      ).paddingOnly(bottom: 20),*/
                      // SMSButtonWidget(
                      //   onPress: () async {
                      //
                      //     Map<String, dynamic> mapData1={};
                      //     Map<String, dynamic> mapData2={};
                      //
                      //     if(attendanceController.editFlag!=1){
                      //
                      //       String startDate;
                      //       String? endDate;
                      //       if(double.parse(attendanceController.noOfLeaves.text).toInt()>1){
                      //
                      //         startDate = attendanceController.startDateController.text;
                      //         endDate = attendanceController.endDateController.text;
                      //
                      //       }else{
                      //         startDate = attendanceController.leaveDateController.text;
                      //       }
                      //
                      //
                      //       mapData1 = {
                      //         "student_id": LocalStorage.getValue("studentId"),
                      //         "start_date": startDate,
                      //         "end_date": endDate??"",
                      //         "description": attendanceController.descriptionController.text,
                      //         "half_day_leave": attendanceController.selectedLeaveTypeValue.toString(),
                      //       };
                      //       LeaveCreateResponceModel? leaveCreateData = await attendanceController.leaveRequestCreate(ApiHelper.leaveCreateUrl,1,mapData1);
                      //       if (leaveCreateData != null && leaveCreateData.code == 200) {//
                      //         Get.back();
                      //         showStaffToastMsg("Leave Created Successfully");
                      //         attendanceController.getLeaveListData();
                      //       } else {
                      //         print("Leave Create Response : fail");
                      //       }
                      //     }else{
                      //
                      //       String startDate;
                      //       String? endDate;
                      //       if(double.parse(attendanceController.noOfLeaves.text).toInt()>1){
                      //
                      //         startDate = attendanceController.startDateController.text;
                      //         endDate = attendanceController.endDateController.text;
                      //
                      //       }else{
                      //         startDate = attendanceController.leaveDateController.text;
                      //         endDate = startDate;
                      //       }
                      //
                      //      /* DateTime tempStartDate = DateFormat("dd/mm/yyyy").parse(attendanceController.startDateController.text);
                      //       String temp = double.parse(attendanceController.noOfLeaves.text).toInt()>1? attendanceController.endDateController.text:"";
                      //       if(temp.isNotEmpty){
                      //         DateTime tempEndDate = DateFormat("dd/mm/yyyy").parse(temp);
                      //         endDate = DateFormat('yyyy-mm-dd').format(tempEndDate);
                      //       }
                      //       startDate = DateFormat('yyyy-mm-dd').format(tempStartDate);*/
                      //
                      //       print("student_id : ${LocalStorage.getValue("studentId")}");
                      //       print("leave_request_id : ${attendanceController.leaveRequestId}");
                      //       print("start_date : $startDate");
                      //       print("end_date : $endDate");
                      //       print("description : ${attendanceController.descriptionController.text}");
                      //       print("half_day_leave : ${attendanceController.selectedLeaveTypeValue.toString()}");
                      //
                      //
                      //       mapData2 = {
                      //         "student_id": LocalStorage.getValue("studentId"),
                      //         "leave_request_id": attendanceController.leaveRequestId,
                      //         "start_date": startDate,
                      //         "end_date": endDate ?? "",
                      //         "description": attendanceController.descriptionController.text,
                      //         "half_day_leave": attendanceController.selectedLeaveTypeValue.toString(),//
                      //       };
                      //
                      //       LeaveCreateResponceModel? leaveCreateData = await attendanceController.leaveRequestCreate("${ApiHelper.leaveEditUrl}",2,mapData2);
                      //       if (leaveCreateData != null && leaveCreateData.code == 200) {
                      //         Get.back();
                      //         showStaffToastMsg("Updated");
                      //         attendanceController.getLeaveListData();
                      //         print("Leave Edit Response : pass");
                      //       } else {
                      //         print("Leave Edit Response : fail");
                      //       }
                      //     }
                      //   },
                      //   text: "SUBMIT LEAVE",
                      //   width: MediaQuery.of(context).size.width,
                      //   height: 50,
                      //   borderRadius: 5,
                      //   primaryColor: AppColors.darkPinkColor,
                      // ).paddingOnly(bottom: 20)
                    ],
                  ).paddingSymmetric(vertical: 10, horizontal: 10),
                ),
              ),
            ),
          );
        }));
  }

  Widget _buildText(String text) {
    return Text(text,
            style: AppStyles.NunitoRegular.copyWith(
                fontSize: 14, color: AppColors.darkPinkColor))
        .paddingOnly(bottom: 10);
  }

  Widget leaveTypeWidget1(AttendanceDetailsController attendanceController) {
    return Column(children: <Widget>[
      Container(
        width: 200,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: attendanceController.selectedLeaveType,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: AppColors.blackColor, fontSize: 18),
            onChanged: (data) {

              if(attendanceController.numLeave!>1){
                attendanceController.updateSelectedLeaveType(attendanceController.selectedLeaveList1,data!);
              }else{
                attendanceController.updateSelectedLeaveType(attendanceController.selectedLeaveList2,data!);
              }

              attendanceController.updateSelectedLeaveType(double.parse(attendanceController.noOfLeaves.text).toInt()>1?attendanceController.selectedLeaveList1:attendanceController.selectedLeaveList2,data!);
            },
             // double.parse(attendanceController.noOfLeaves.text).toInt()
            items: 2>1?attendanceController.selectedLeaveList1
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(value,
                      style: AppStyles.PoppinsRegular.copyWith(
                          fontSize: 14, color: Color(0XFF5F89DB)),
                ),
              ));
            }).toList():attendanceController.selectedLeaveList2
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(value,
                    style: AppStyles.PoppinsRegular.copyWith(
                        fontSize: 14, color: Color(0XFF5F89DB)),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ]);
  }

  Widget leaveTypeWidget(AttendanceDetailsController attendanceController) {
    return Column(children: <Widget>[
      Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.94,
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: attendanceController.selectedLeaveType,
            icon: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.arrow_drop_down),
            ),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: AppColors.blackColor, fontSize: 18),
            onChanged: (data) {
              // attendanceController.updateSelectedLeaveType(double.parse(attendanceController.noOfLeaves.text).toInt()>1?attendanceController.selectedLeaveList1:attendanceController.selectedLeaveList2,data!);
            },
            // double.parse(attendanceController.noOfLeaves.text).toInt()
            items: 2>1?attendanceController.selectedLeaveList1
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(value),
                ),
              );
            }).toList():attendanceController.selectedLeaveList2
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ]);
  }
}
