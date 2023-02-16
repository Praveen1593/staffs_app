import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/contsants.dart';
import '../../../../../common/routes/app_routes.dart';
import '../../../../controllers/attendance_controller/attendance_details_controller.dart';
import '../../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';
import 'leave_status_screen.dart';

class AttendanceDetailsScreen extends StatelessWidget {
  AttendanceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF5F5F5),
        appBar: smsAppbar("Attendance"),
        body: GetBuilder<AttendanceDetailsController>(
            init: AttendanceDetailsController(),
            builder: (attendanceDetailsController) {
              return attendanceDetailsController.attendanceModel?.data != null
                  ? SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Attendance Details',
                                  style: AppStyles.PoppinsRegular
                                      .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFF252525),
                                  )),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  color: Color(0XFFcbe3ff),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Stack(
                                  children: [
                                    SMSImageAsset(image: "assets/campuseasy/attendance_abstract.png"),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width: 80,
                                                    height: 80,
                                                    color: const Color(0xFFF3F3F3),
                                                  ),
                                                ),
                                                Center(
                                                  child: CircularPercentIndicator(
                                                    radius: 55.0,
                                                    lineWidth: 15.0,
                                                    percent: double.parse(attendanceDetailsController
                                                        .attendanceModel!.data!.percentage!
                                                        .replaceAll("%", "")) *
                                                        0.01,
                                                    center: Text("${attendanceDetailsController.attendanceModel?.data?.percentage}",
                                                      style: AppStyles.PoppinsBold.copyWith(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w800,
                                                          color: const Color(0xFF407BFF)),
                                                    ),
                                                    progressColor: const Color(0xFF407BFF),
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 23),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Working days",
                                                      style:
                                                      AppStyles.PoppinsRegular.copyWith(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          color: const Color(0xFF263238)),
                                                    ),
                                                    Text(
                                                      "${attendanceDetailsController.attendanceModel?.data?.noOfWorkingDays}",
                                                      style:
                                                      AppStyles.PoppinsRegular.copyWith(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          color: const Color(0xFF263238)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: LinearPercentIndicator(
                                                  width:
                                                  MediaQuery.of(Get.context!).size.width *
                                                      0.5,
                                                  lineHeight: 8.0,
                                                  percent: 1,
                                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                                  backgroundColor: Colors.white,
                                                  barRadius: const Radius.circular(5),
                                                  linearGradient: const LinearGradient(
                                                      colors: [
                                                        Color(0XFF407BFF),
                                                        Color(0XFF81B9F6)
                                                      ]),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 23),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Present",
                                                      style:
                                                      AppStyles.PoppinsRegular.copyWith(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          color: const Color(0xFF263238)),
                                                    ),
                                                    Text(
                                                      "${attendanceDetailsController.attendanceModel?.data?.present}",
                                                      style:
                                                      AppStyles.PoppinsRegular.copyWith(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          color: const Color(0xFF263238)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: LinearPercentIndicator(
                                                  width:
                                                  MediaQuery.of(Get.context!).size.width *
                                                      0.5,
                                                  lineHeight: 8.0,
                                                  percent: 1,
                                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                                  backgroundColor: Colors.white,
                                                  barRadius: const Radius.circular(5),
                                                  linearGradient: const LinearGradient(
                                                      colors: [
                                                        Color(0XFF97E032),
                                                        Color(0XFFC4F481)
                                                      ]),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 23),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Absent",
                                                      style:
                                                      AppStyles.PoppinsRegular.copyWith(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          color: const Color(0xFF263238)),
                                                    ),
                                                    Text(
                                                      "${attendanceDetailsController.attendanceModel?.data?.absent}",
                                                      style:
                                                      AppStyles.PoppinsRegular.copyWith(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          color: const Color(0xFF263238)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: LinearPercentIndicator(
                                                  width:
                                                  MediaQuery.of(Get.context!).size.width *
                                                      0.5,
                                                  lineHeight: 8.0,
                                                  percent: 1,
                                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                                  backgroundColor: Colors.white,
                                                  linearGradient: const LinearGradient(
                                                      colors: [
                                                        Color(0XFFFA5050),
                                                        Color(0XFFF19494)
                                                      ]),
                                                  barRadius: const Radius.circular(5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),


                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Absent Details',
                                  style: AppStyles.PoppinsRegular
                                      .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFF252525),
                                  )),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Color(0XFFffecec),
                                          border: Border.all(color: const Color(0xFFed6561)),
                                          borderRadius: BorderRadius.circular(30)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SMSImageAsset(
                                              image: "assets/campuseasy/absent_select.png",width: 10,height: 10,),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Full day',
                                              style: AppStyles.PoppinsRegular.copyWith(
                                                  fontSize: 11,
                                                  color: const Color(0xFf252525)),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${attendanceDetailsController
                                                  .attendanceModel!.data!.absentDetail?.fullDay}',
                                              style: AppStyles.PoppinsBold.copyWith(
                                                  fontSize: 11,
                                                  color: const Color(0xFf252525)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Color(0XFFffecec),
                                          border: Border.all(color: const Color(0xFFed6561)),
                                          borderRadius: BorderRadius.circular(30)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SMSImageAsset(
                                              image: "assets/campuseasy/absent_select.png",width: 10,height: 10,),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Morning',
                                              style: AppStyles.PoppinsRegular.copyWith(
                                                  fontSize: 11,
                                                  color: const Color(0xFf252525)),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${attendanceDetailsController
                                                  .attendanceModel!.data!.absentDetail!.morningHaftDay}',
                                              style: AppStyles.PoppinsBold.copyWith(
                                                  fontSize: 11,
                                                  color: const Color(0xFf252525)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Color(0XFFffecec),
                                          border: Border.all(color: const Color(0xFFed6561)),
                                          borderRadius: BorderRadius.circular(30)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SMSImageAsset(
                                              image: "assets/campuseasy/absent_select.png",width: 10,height: 10,),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Evening',
                                              style: AppStyles.PoppinsRegular.copyWith(
                                                  fontSize: 11,
                                                  color: const Color(0xFf252525)),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${attendanceDetailsController
                                                  .attendanceModel!.data!.absentDetail!.eveningHaftDay}',
                                              style: AppStyles.PoppinsBold.copyWith(
                                                  fontSize: 11,
                                                  color: const Color(0xFf252525)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Attendance Request',
                                  style: AppStyles.PoppinsRegular
                                      .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFF252525),
                                  )),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: InkWell(
                                onTap: (){
                                  Get.to(LeaveStatusScreen());
                                  attendanceDetailsController
                                      .getLeaveListData();
                                },
                                child: Card(
                                  elevation: 1,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Leave Request',
                                              style: AppStyles.PoppinsRegular
                                                  .copyWith(
                                                fontSize: 14,
                                                color: Color(0XFF407BFF),
                                              )),
                                          Icon(Icons.arrow_forward_ios,size:20,color: Color(0XFF407BFF))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: InkWell(
                                onTap: (){
                                  Get.toNamed(
                                      AppRoutes.ATTENDANCECALENDER);
                                },
                                child: Card(
                                  elevation: 1,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Month Wise Attendance',
                                              style: AppStyles.PoppinsRegular
                                                  .copyWith(
                                                fontSize: 14,
                                                color: Color(0XFF407BFF),
                                              )),
                                          Icon(Icons.arrow_forward_ios,size:20,color: Color(0XFF407BFF))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            /*Container(
                              height: 100,
                              width: double.infinity,
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                elevation: 10,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Get.to(LeaveStatusScreen());
                                        attendanceDetailsController
                                            .getLeaveListData();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.darkPinkColor,
                                        foregroundColor: AppColors.whiteColor,
                                        minimumSize: Size(10, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.leaderboard,
                                        size: 25.0,
                                      ),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('LEAVE REQUEST',
                                            style: AppStyles.NunitoExtrabold
                                                .copyWith(
                                              fontSize: 12,
                                              color: AppColors.whiteColor,
                                            )),
                                      ), // <-- Text
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Get.toNamed(
                                            AppRoutes.ATTENDANCECALENDER);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.darkPinkColor,
                                        foregroundColor: AppColors.whiteColor,
                                        minimumSize: Size(10, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.calendar_month,
                                        size: 25.0,
                                        color: AppColors.whiteColor,
                                      ),
                                      label: Text('MONTH WISE\nATTENDANCE',
                                          style: AppStyles.NunitoExtrabold
                                              .copyWith(
                                            fontSize: 12,
                                            color: AppColors.whiteColor,
                                          )), // <-- Text
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _attendanceDetails(
                                attendanceDetailsController, context),
                            _absentDetails(attendanceDetailsController, context)*/
                          ]),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
            }));
  }

  Widget _attendanceDetails(
      AttendanceDetailsController attendanceDetailsController,
      BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Attendance Details",
              style: AppStyles.NunitoExtrabold.copyWith(
                  fontSize: 17, color: AppColors.blackColor),
            ).paddingOnly(left: 20, top: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 10.0,
                  percent: double.parse(attendanceDetailsController
                          .attendanceModel!.data!.percentage!
                          .replaceAll("%", "")) *
                      0.01,
                  center: Text(
                    "${attendanceDetailsController.attendanceModel?.data?.percentage}",
                    style: const TextStyle(
                        fontSize: 20, color: AppColors.blackColor),
                  ),
                  progressColor: AppColors.darkPinkColor,
                ),
                Column(
                  children: [
                    attendanceLinearProgressBar(1, attendanceDetailsController,
                        containerColor: AppColors.lightOrange,
                        progressColor: AppColors.orangeColor,
                        percentage: 0.5,
                        width: MediaQuery.of(Get.context!).size.width * 0.35,
                        sizedBoxWidth:
                            MediaQuery.of(Get.context!).size.width * 0.3),
                    attendanceLinearProgressBar(2, attendanceDetailsController,
                        progressColor: AppColors.shadeOfPinkColor,
                        containerColor: AppColors.cornflowerBlueColor,
                        percentage: 0.6,
                        width: MediaQuery.of(Get.context!).size.width * 0.35,
                        sizedBoxWidth:
                            MediaQuery.of(Get.context!).size.width * 0.3),
                    attendanceLinearProgressBar(3, attendanceDetailsController,
                        containerColor: AppColors.DarkCyan,
                        progressColor: AppColors.DarkCyan,
                        percentage: 0.1,
                        width: MediaQuery.of(Get.context!).size.width * 0.35,
                        sizedBoxWidth:
                            MediaQuery.of(Get.context!).size.width * 0.3),
                  ],
                )
              ],
            ).paddingOnly(left: 25, top: 5),
          ],
        ),
      ).paddingAll(10),
    ).paddingAll(5);
  }

  Widget _absentDetails(AttendanceDetailsController attendanceDetailsController,
      BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Absent Details",
              style: AppStyles.NunitoExtrabold.copyWith(
                  fontSize: 17, color: AppColors.blackColor),
            ).paddingOnly(left: 20, top: 10, bottom: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: MediaQuery.of(Get.context!).size.width,
                    child: attendanceLinearProgressBar(
                        4, attendanceDetailsController,
                        containerColor: AppColors.lightOrange,
                        progressColor: AppColors.orangeColor,
                        percentage: 0.5,
                        width: MediaQuery.of(Get.context!).size.width * 0.7,
                        sizedBoxWidth:
                            MediaQuery.of(Get.context!).size.width * 0.65),
                  ),
                ),
                attendanceLinearProgressBar(5, attendanceDetailsController,
                    progressColor: AppColors.shadeOfPinkColor,
                    containerColor: AppColors.cornflowerBlueColor,
                    percentage: 0.6,
                    width: MediaQuery.of(Get.context!).size.width * 0.7,
                    sizedBoxWidth:
                        MediaQuery.of(Get.context!).size.width * 0.65),
                attendanceLinearProgressBar(6, attendanceDetailsController,
                    containerColor: AppColors.DarkCyan,
                    progressColor: AppColors.DarkCyan,
                    percentage: 0.1,
                    width: MediaQuery.of(Get.context!).size.width * 0.7,
                    sizedBoxWidth:
                        MediaQuery.of(Get.context!).size.width * 0.65),
              ],
            ).paddingOnly(top: 5),
          ],
        ),
      ).paddingAll(5),
    ).paddingAll(5);
  }
}

Widget attendanceLinearProgressBar(
    int type, AttendanceDetailsController attendanceDetailsController,
    {Color? containerColor,
    double? percentage,
    Color? progressColor,
    required double width,
    required double sizedBoxWidth}) {
  String? progressLabel;
  dynamic progressValue;
  dynamic progresslabelValue;
  double? loaderValue;
  double? present, absent;
  if (type == 1) {
    progressLabel = "Working Days";
    progressValue =
        attendanceDetailsController.attendanceModel?.data?.noOfWorkingDays;
    progresslabelValue = progressValue;
    loaderValue = 1.0;
  } else if (type == 2) {
    progressLabel = "Present";
    progressValue =
        attendanceDetailsController.attendanceModel?.data?.noOfWorkingDays;
    progresslabelValue =
        attendanceDetailsController.attendanceModel!.data!.present!.toDouble();
    loaderValue = (attendanceDetailsController.attendanceModel!.data!.present!
                .toDouble() /
            progressValue) *
        100 *
        0.01;
  } else if (type == 3) {
    progressLabel = "Absent";
    progressValue =
        attendanceDetailsController.attendanceModel?.data?.noOfWorkingDays;
    progresslabelValue =
        attendanceDetailsController.attendanceModel!.data!.absent!.toDouble();
    loaderValue =
        (attendanceDetailsController.attendanceModel!.data!.absent!.toDouble() /
                progressValue) *
            100 *
            0.01;
  } else if (type == 4) {
    progressLabel = "Full Day Absent";
    progressValue = attendanceDetailsController.attendanceModel?.data?.absent;
    progresslabelValue = attendanceDetailsController
        .attendanceModel!.data!.absentDetail!.fullDay!
        .toDouble();
    loaderValue = (((progressValue! -
                (attendanceDetailsController
                    .attendanceModel!.data!.absentDetail!.fullDay!
                    .toDouble())) /
            progressValue) *
        100 *
        0.01);
  } else if (type == 5) {
    progressLabel = "Today Morning Absent";
    progressValue = attendanceDetailsController.attendanceModel?.data?.absent;
    progresslabelValue = attendanceDetailsController
        .attendanceModel!.data!.absentDetail!.morningHaftDay!
        .toDouble();
    if (progresslabelValue == 0) {
      loaderValue = 0;
    } else {
      loaderValue = (((progressValue! -
                  (attendanceDetailsController
                          .attendanceModel!.data!.absentDetail!.morningHaftDay!
                          .toDouble() *
                      0.5)) /
              progressValue) *
          100 *
          0.01);
    }
  } else if (type == 6) {
    progressLabel = "Today Evening Absent";
    progressValue = attendanceDetailsController.attendanceModel?.data?.absent;
    progresslabelValue = attendanceDetailsController
        .attendanceModel!.data!.absentDetail!.eveningHaftDay!
        .toDouble();
    if (progresslabelValue == 0) {
      loaderValue = 0;
    } else {
      loaderValue = (((progressValue! -
                  (attendanceDetailsController
                          .attendanceModel!.data!.absentDetail!.eveningHaftDay!
                          .toDouble() *
                      0.5)) /
              progressValue) *
          100 *
          0.01);
    }
  }

  return Row(
    children: [
      Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: containerColor ?? AppColors.whiteColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ).paddingOnly(top: 5, bottom: 5, left: 20, right: 5),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: sizedBoxWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$progressLabel",
                    style: AppStyles.NunitoRegular.copyWith(
                      fontSize: 10,
                      color: AppColors.blackColor,
                    )),
                Text(
                  "$progresslabelValue",
                  style:
                      const TextStyle(fontSize: 8, color: AppColors.blackColor),
                ),
              ],
            ),
          ).paddingOnly(top: 5, bottom: 5, left: 10, right: 10),
          LinearPercentIndicator(
            width: width,
            lineHeight: 4.0,
            percent: loaderValue ?? 0.0,
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: progressColor ?? AppColors.whiteColor,
          ).paddingOnly(bottom: 5),
        ],
      ),
    ],
  );
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final int y;
  final Color? color;
}
