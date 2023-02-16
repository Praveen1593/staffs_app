import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../../common/const/image_constants.dart';
import '../../../../common/enums/enum_navigation.dart';
import '../../../../common/routes/app_routes.dart';
import '../../../../common/widgets/utils.dart';
import '../../../controllers/home_controller/home_screen_controller.dart';
import '../../../model/attendance_overview_model.dart';
import '../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';
import 'package:get/get.dart';
import '../payment/paymentscreen.dart';
import '../profile/profile_main.dart';
import '../../../../storage.dart';
import 'notification_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        key: _key,
        body: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (homeController) {
              return RefreshIndicator(
                  key: homeController.refreshIndicatorKey,
                  onRefresh: homeController.refreshData,
                  child: _buildBody(context, homeController));
            }),
        drawer: _buildDrawer());
  }

  Widget _buildDrawer() {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient:  LinearGradient(colors: [
                Color(0xFF525CFF),
                Color(0xFF5EAAFF),
              ]),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,right: 20,bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25,bottom: 25),
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            _profileDrawerImage(),
                            SizedBox(width: 20,),
                            _userData()
                          ],
                        ),
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    height: 620,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(20))
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _homeworkWithMenuItems(),
                          _paymentWithMentItems(),
                          _examMAnagerWithMenuItems(),
                          _libraryWithMenuItems(),
                          _inventoryWithMenuItems(),
                          _extraActivitiesWithMEnuItems(),
                          _schoolCalenderWidget(),
                          SizedBox(height: 30,),
                          _logoutWidget(),
                        ],
                      ),
                    )

                  ),
                ),
                //_drawerHeaderWidget(),
               // _homeworkWithMenuItems(),
                // _onlineClassesWithMenuItems(),
               // _paymentWithMentItems(),
                //_examMAnagerWithMenuItems(),

                //_libraryWithMenuItems(),
               // _inventoryWithMenuItems(),
                // _extraActivitiesWithMEnuItems(),
                //_schoolCalenderWidget(),
                //_diverWidget(),
                //_logoutWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeController homeController) {
    return SafeArea(
      child: Stack(
        children: [
          _homeAppbarWidget(homeController),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Today Attendance",
                          style: AppStyles.PoppinsBold.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF263238)),
                        ),),
                        homeController.attendanceOverviewModel?.attendanceOverviewData!=null&&
                            homeController.attendanceOverviewModel?.attendanceOverviewData.todayAttendance!=null?
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: homeController.attendanceOverviewModel?.attendanceOverviewData.todayAttendance.leaveTypeId==1? Color(0XFF72B01D):Color(0xFfD2D2D2)),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                     SMSImageAsset(
                                        image: homeController.attendanceOverviewModel?.attendanceOverviewData.todayAttendance.leaveTypeId==1?
                                            "assets/campuseasy/present_select.png":"assets/campuseasy/attendance_unselect.png",width: 10,height: 10,),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Present',
                                      style: AppStyles.PoppinsRegular.copyWith(
                                          fontSize: 11,
                                          color: homeController.attendanceOverviewModel?.attendanceOverviewData.todayAttendance.leaveTypeId==1? Color(0XFF72B01D):Color(0xFfD2D2D2)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: homeController.attendanceOverviewModel?.attendanceOverviewData.todayAttendance!=null&&homeController.attendanceOverviewModel!.attendanceOverviewData.todayAttendance.leaveTypeId>=2? Color(0xFfD35C40):Color(0xFfD2D2D2)),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                     SMSImageAsset(
                                        image:homeController.attendanceOverviewModel?.attendanceOverviewData.todayAttendance!=null&&homeController.attendanceOverviewModel!.attendanceOverviewData.todayAttendance.leaveTypeId>=2?
                                            "assets/campuseasy/absent_select.png":"assets/campuseasy/attendance_unselect.png",width: 10,height: 10,),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Absent',
                                      style: AppStyles.PoppinsRegular.copyWith(
                                          fontSize: 11,
                                          color: homeController.attendanceOverviewModel?.attendanceOverviewData.todayAttendance!=null&&homeController.attendanceOverviewModel!.attendanceOverviewData.todayAttendance.leaveTypeId>=2? Color(0xFfD35C40):Color(0xFfD2D2D2)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),):Container(
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: const Color(0xFfD2D2D2)),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                SMSImageAsset(
                                  image: "assets/campuseasy/attendance_unselect.png",width: 10,height: 10,),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Not Taken',
                                  style: AppStyles.PoppinsRegular.copyWith(
                                      fontSize: 11,
                                      color: const Color(0xFfD2D2D2)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Stack(
                      children: [
                        const SMSImageAsset(
                          image: "assets/campuseasy/dashboard_card_bg.png",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi Mr. Jack",
                                style: AppStyles.PlayBallItalic.copyWith(
                                    fontSize: 16, color: const Color(0xFFFAFAFF)),
                              ),
                              Text(
                                "Good Morning...",
                                style: AppStyles.PlayBallItalic.copyWith(
                                    fontSize: 20, color: const Color(0xFFFAFAFF)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  "Lorem ipsum,  as it is sometimes known, is dummy graphic or web designs.",
                                  style: AppStyles.PoppinsRegular.copyWith(
                                      fontSize: 12,
                                      height: 1.5,
                                      color: const Color(0xFFFAFAFF)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, right: 20),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: SMSImageAsset(
                                image: "assets/campuseasy/dashboard_toy_image.png",
                                width: 100,
                                height: 180,
                              )),
                        ),
                      ],
                    ),
                  ),
                  //Homework
                  homeController.subjectList.isNotEmpty?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              "Home Work",
                              style: AppStyles.PoppinsBold.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF263238)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Container(
                              height: 50,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homeController.subjectList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: (){
                                        Get.toNamed(AppRoutes.HOMEWORK,
                                            arguments: const {"tag": "Homework"});
                                      },
                                      child: Wrap(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              // color: Colors.black54
                                            ),
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(0XFFFFF8E8),
                                                        borderRadius:
                                                        BorderRadius.circular(30)),
                                                    child: Padding(
                                                        padding: const EdgeInsets.only(
                                                            right: 15,
                                                            left: 15,
                                                            top: 10,
                                                            bottom: 10),
                                                        child: Row(
                                                          children: [
                                                            const SMSImageAsset(
                                                              image:
                                                              "assets/campuseasy/dashboard_hw_book.png",
                                                              width: 20,
                                                              height: 20,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "${homeController.subjectList[index].subject?.name}",
                                                              style: AppStyles
                                                                  .PoppinsRegular
                                                                  .copyWith(
                                                                  fontSize: 10,
                                                                  color: const Color(
                                                                      0XFF263238)),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                                homeController.subjectList[index].subject?.homeWorkCount!=0?
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                      border:
                                                      Border.all(color: Colors.white),
                                                      shape: BoxShape.circle,
                                                      color: const Color(0xFFFA5050)),
                                                  child: Center(
                                                    child: Text(
                                                      "${homeController.subjectList[index].subject?.homeWorkCount}",
                                                      style:
                                                      AppStyles.PoppinsRegular.copyWith(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppColors.whiteColor),
                                                    ),
                                                  ),
                                                ):Container(),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ):Container(),
                  //Payment
                  homeController
                      .paymentOverviewModel
                      ?.paymentOverviewData!=null?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          "Payment Overview",
                          style: AppStyles.PoppinsBold.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF263238)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 130,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFFf8a6d4),
                                        Color(0xFFf8bbbe),
                                      ]),
                                      borderRadius: BorderRadius.circular(10)),
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
                                            lineWidth: 25.0,
                                            percent: homeController.paymentOverviewModel?.paymentOverviewData?.percentage?.toDouble()??0.0 * 0.01,
                                            center: Text("${homeController.paymentOverviewModel?.paymentOverviewData?.percentage ?? "0"}%",
                                              style: AppStyles.PoppinsBold.copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800,
                                                  color: const Color(0xFF525CFF)),
                                            ),
                                            progressColor: const Color(0xFF525CFF),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFFf8a6d4),
                                        Color(0xFFf8bbbe),
                                      ]),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total Fee",
                                              style:
                                              AppStyles.PoppinsRegular.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xFF263238)),
                                            ),
                                            Text(
                                              "${Constants.RUPEESYMBOOL}${homeController.paymentOverviewModel?.paymentOverviewData?.total ?? "0"}",
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
                                                Color(0XFF407BFF)
                                              ]),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Paid",
                                              style:
                                              AppStyles.PoppinsRegular.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xFF263238)),
                                            ),
                                            Text(
                                              "${Constants.RUPEESYMBOOL}${homeController.paymentOverviewModel?.paymentOverviewData?.paid ?? "0"}",
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
                                            left: 20, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Pending",
                                              style:
                                              AppStyles.PoppinsRegular.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xFF263238)),
                                            ),
                                            Text(
                                              "${Constants.RUPEESYMBOOL}${homeController.paymentOverviewModel?.paymentOverviewData?.pending ?? "0"}",
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
                              ),


                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ):Container(),

                  //Menu
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      "Menus",
                      style: AppStyles.PoppinsBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF263238)),
                    ),
                  ),
                  _availableMenuItems(),
                  const SizedBox(
                    height: 10,
                  ),
                  //Attendance
                  homeController.attendanceOverviewModel?.attendanceOverviewData!=null?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          "Attendance Overview",
                          style: AppStyles.PoppinsBold.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF263238)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 130,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFFf8a6d4),
                                        Color(0xFFf8bbbe),
                                      ]),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: const Color(0XFF615c66),
                                              borderRadius: BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Total Working Days",
                                                  style: AppStyles.PoppinsRegular
                                                      .copyWith(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                        const Color(0XFF525CFF),
                                                        borderRadius:
                                                        BorderRadius.circular(5)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      child: Center(
                                                        child: Text(
                                                          "${homeController.attendanceOverviewModel?.attendanceOverviewData.noOfWorkingDays}",
                                                          style: AppStyles.PoppinsBold
                                                              .copyWith(
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              color:
                                                              Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 21, right: 15),
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
                                              "${homeController.attendanceOverviewModel?.attendanceOverviewData.present ?? "0"} Days",
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
                                            left: 21, right: 15),
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
                                              "${homeController.attendanceOverviewModel?.attendanceOverviewData.absent ?? "0"} Days",
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
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFFf8a6d4),
                                        Color(0xFFf8bbbe),
                                      ]),
                                      borderRadius: BorderRadius.circular(10)),
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
                                            lineWidth: 25.0,
                                            percent: attendancePercentageCalculate(homeController.attendanceOverviewModel?.attendanceOverviewData.percentage ??
                                                "0.0"),
                                            center: Text(
                                              homeController.attendanceOverviewModel?.attendanceOverviewData.percentage ?? "0.0",
                                              style: AppStyles.PoppinsBold.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                  color: const Color(0xFF525CFF)),
                                            ),
                                            progressColor: const Color(0xFF525CFF),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ):Container(),
                  //Footer
                  Stack(
                    children: [
                      const SMSImageAsset(
                          image: "assets/campuseasy/dashboard_footer.png"),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            "Powered by Cblaze Infotech",
                            style: AppStyles.PoppinsRegular.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),

                  // _wishMsgWidget(context, homeController),
                  // _buildSizedBoxHeight(height: 30),
                  // _availableLanguages(context, homeController),
                  // _buildSizedBoxHeight(height: 15),
                  //_paymentCardView(context, homeController),
                 // overallAttendanceCard(context, homeController)
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }

  double attendancePercentageCalculate(String str){
    String percentageVal = str.replaceAll("%", "");
    double convertPercentage = double.parse(percentageVal) * 0.01;
    print("Percentage Value $str");
    print("Percentage Replace Value $percentageVal");
    print("Percentage Convert Value $convertPercentage");
    return convertPercentage;
  }

  double percentageCalculate(
      int total, int paid, int pending, int type) {
    double percentageValue = 0.0;
    if (type == 1) {
      //Paid
      int totalValue = total;
      int pendingValue = pending;
      int value = totalValue - pendingValue;
      double value1 = value / totalValue;
      double value2 = value1 * 100;
      percentageValue = value2 * 0.01;
    } else {
      //Pending
      int totalValue = total;
      int paidValue = paid;
      int value = totalValue - paidValue;
      double value1 = value / totalValue;
      double value2 = value1 * 100;
      percentageValue = value2 * 0.01;
    }
    return percentageValue;
  }


  Widget _logoutWidget() {
    return Container(
      color: Colors.white.withOpacity(0.2),
      child: ListTile(
        trailing: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: SMSImageAsset(
            image: "assets/campuseasy/logout_img.png",
            height: 20,
            width: 20,
          ),
        ),
        onTap: () {
          LocalStorage.setValue('login', false);
          LocalStorage.setValue('token', "");
          LocalStorage.setValue("studentId", "");
          Get.offAllNamed(AppRoutes.LOGINVIEW);
        },
        title: Text(
          Constants.LOGOUT,
          style: AppStyles.PoppinsRegular.copyWith(fontSize: 15, color: AppColors.whiteColor),
        ),
      ),
    );
  }

  Widget _diverWidget() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(
        height: 2,
        color: AppColors.greyColor,
      ),
    );
  }

  Widget _schoolCalenderWidget() {
    return ListTile(
        /*leading: const SMSImageAsset(
          image: ImageConstants.schoolCalnderImg,
          height: 20,
          width: 20,
        ),*/
        onTap: () {
          updateStatusOfTheRoute(Status.SCHOOLCALENDER);
        },
        title: Text(
          Constants.SCHOOLCALENDER,
          style: AppStyles.PoppinsRegular.copyWith(fontSize: 15, color: AppColors.whiteColor),
        ));
  }

  Widget _extraActivitiesWithMEnuItems() {
    return SideMenu(
        headingText: Constants.EXTRAACTIVITIES,
        imageLeading: ImageConstants.extraActivitiesImg,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.8),
          ),
          child: Column(
            children: [
              ListTile(
               // leading: const Icon(Icons.message_sharp),
                title: Text(
                  Constants.EXTRACURRICULAR,
                  style: AppStyles.PoppinsRegular.copyWith(fontSize: 15,color: AppColors.blackColor),
                ),
                onTap: () {
                  updateStatusOfTheRoute(Status.EXTRACURRICULAR);
                },
              ),
              ListTile(
                //leading: const Icon(Icons.message_sharp),
                title: Text(
                  Constants.REFRESHMENT,
                  style: AppStyles.PoppinsRegular.copyWith(fontSize: 15,color: AppColors.blackColor),
                ),
                onTap: () {
                  updateStatusOfTheRoute(Status.REFRESHMENT);
                },
              ),
            ],
          ),
        ));
  }

  Widget _inventoryWithMenuItems() {
    return SideMenu(
        headingText: Constants.INVENTORY,
        imageLeading: ImageConstants.inventoryImg,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.8),
          ),
          child: Column(
            children: [
              SubMenu(
                text: Constants.MATERIALBILL,
                image: ImageConstants.materialBill,
                onTapped: () {
                  updateStatusOfTheRoute(Status.MATERIALBILL);
                },
              ),
              /*    SubMenu(
                text: Constants.MATERIALBILLISSUED,
                image: ImageConstants.materialBill,
                onTapped: () {
                  updateStatusOfTheRoute(Status.MATERIALBILLISSUED);
                },
              ),*/
            ],
          ),
        ));
  }

  Widget _libraryWithMenuItems() {
    return SideMenu(
        headingText: Constants.LIBRARY,
        imageLeading: ImageConstants.libraryImg,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.8),
          ),
          child: Column(
            children: [
              SubMenu(
                text: Constants.BARROWLIST,
                image: ImageConstants.barrowImg,
                onTapped: () {
                  updateStatusOfTheRoute(Status.BARROWLIST);
                },
              ),
              SubMenu(
                text: Constants.RETURNLIST,
                image: ImageConstants.returnListImg,
                onTapped: () {
                  updateStatusOfTheRoute(Status.RENEWLIST);
                },
              ),
              SubMenu(
                text: Constants.FINELIST,
                image: ImageConstants.fineListImg,
                onTapped: () {
                  updateStatusOfTheRoute(Status.FINELIST);
                },
              ),
              SubMenu(
                text: Constants.FINEINVOICE,
                image: ImageConstants.fineInvoiceImg,
                onTapped: () {
                  updateStatusOfTheRoute(Status.FINEINVOICE);
                },
              ),
            ],
          ),
        ));
  }

  Widget _onlineClassesWithMenuItems() {
    return SideMenu(
        headingText: Constants.PROJECT,
        imageLeading: ImageConstants.onlineClassImg,
        child: Column(
          children: [
            SubMenu(
              text: Constants.LIVECLASSES,
              image: ImageConstants.liveClassImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.LIVECLASSES);
              },
            ),
            SubMenu(
              text: Constants.STUDYLAB,
              image: ImageConstants.studyLabImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.STUDYLAB);
              },
            ),
          ],
        ));
  }

  Widget _examMAnagerWithMenuItems() {
    return SideMenu(
        headingText: Constants.EXAMMANAGER,
        imageLeading: ImageConstants.examManagerImg,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.8),
          ),
          child: Column(
            children: [
              SubMenu(
                text: Constants.EXAMRESULT,
                image: ImageConstants.examResultImg,
                onTapped: () {
                  updateStatusOfTheRoute(Status.EXAMRESULT);
                },
              ),
              SubMenu(
                text: "Exam TimeTable",
                image: ImageConstants.examTimeTableImg,
                onTapped: () {
                  updateStatusOfTheRoute(Status.EXAMTIMETABLE);
                },
              ),
            ],
          ),
        ));
  }

  Widget _paymentWithMentItems() {
    return SideMenu(
        headingText: Constants.PAYMENTINVOICE,
        imageLeading: ImageConstants.paymentAndInvoiceImg,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.8),
          ),
          child: Column(
            children: [
              SubMenu(
                text: Constants.FEEPAYMENT,
                image: ImageConstants.vehicleTrackImg,
                onTapped: () {
                  updateStatusOfTheRoute(Status.FEEPAYMENT);
                },
              ),
              SubMenu(
                text: Constants.FEEINVOICE,
                image: ImageConstants.vehicleTrackImg,
                onTapped: () {
                  updateStatusOfTheRoute(Status.FEEINVOICE);
                },
              ),
              SubMenu(
                text: Constants.FEEPENDING,
                image: ImageConstants.vehicleTrackImg,
                onTapped: () {
                  updateStatusOfTheRoute(Status.FEEPENDING);
                },
              ),
            ],
          ),
        ));
  }

  Widget _homeworkWithMenuItems() {
    return SideMenu(
      headingText: Constants.DAILYACTIVITIES,
      imageLeading: ImageConstants.dailyActivitesImg,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SubMenu(
              text: Constants.HOMEWRK,
              image: ImageConstants.homeworkImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.HOMEWORK);
              },
            ),
            SubMenu(
              text: Constants.CLASSTEST,
              image: ImageConstants.classTestImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.CLASSTEST);
              },
            ),
            SubMenu(
              text: Constants.PROJECT,
              image: ImageConstants.homeworkImg,
              onTapped: () {
                // updateStatusOfTheRoute(Status.HOMEWORK);
              },
            ),
            SubMenu(
              text: Constants.ATTENDANCEDETAILS,
              image: ImageConstants.attendanceDetailsImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.ATTENDANCEDETAILS);
              },
            ),
            SubMenu(
              text: "Class TimeTable",
              image: ImageConstants.classTestImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.CLASSTIMETABLE);
              },
            ),
            SubMenu(
              text: Constants.CIRCULAR,
              image: ImageConstants.circularImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.CIRCULAR);
              },
            ),
            SubMenu(
              text: Constants.EVENT,
              image: ImageConstants.eventImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.EVENT);
              },
            ),
            SubMenu(
              text: Constants.NEWS,
              image: ImageConstants.newsImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.NEWS);
              },
            ),
            SubMenu(
              text: Constants.SMS,
              image: ImageConstants.smsImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.SMS);
              },
            ),
            SubMenu(
              text: Constants.VOICE,
              image: ImageConstants.voiceImage,
              onTapped: () {
                updateStatusOfTheRoute(Status.VOICE);
              },
            ),
            SubMenu(
              text: Constants.STAFFDETAILS,
              image: ImageConstants.staffImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.STAFFDETAILS);
              },
            ),
            /*SubMenu(
              text: Constants.VEHICLETRACKING,
              image: ImageConstants.vehicleTrackImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.VEHICLETRACKING);
              },
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _drawerHeaderWidget() {
    return DrawerHeader(
      margin: const EdgeInsets.only(bottom: 0.0),
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Stack(
        children: [
          _homeBgColor(),
          _homeBgImage(),
          Center(
            child: Row(
              children: [_profileDrawerImage(), _userData()],
            ),
          ),
          _version()
        ],
      ),
    );
  }

  Widget _version() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Text(
        LocalStorage.getValue("versionName") != null
            ? "Version : ${LocalStorage.getValue("versionName")}  "
            : "",
        style: AppStyles.normal
            .copyWith(fontSize: 13, color: AppColors.whiteColor),
      ).paddingOnly(bottom: 5),
    );
  }

  Widget _userData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalStorage.getValue("username") ?? "",
          style: AppStyles.PoppinsBold.copyWith(fontSize: 18, color: const Color(0XFF000999)),
        ),
        SizedBox(height: 3,),
        Text(
          LocalStorage.getValue("code") ?? "",
          style: AppStyles.PoppinsRegular
              .copyWith(fontSize: 13, color: AppColors.whiteColor),
        ),
        SizedBox(height: 5,),
        Text(
          LocalStorage.getValue("phoneNumber") ?? "",
          style: AppStyles.PoppinsRegular
              .copyWith(fontSize: 13, color: AppColors.whiteColor),
        ),
      ],
    );
  }

  Widget _profileDrawerImage() {
    return Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          //  shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: AppColors.whiteColor),
            image: DecorationImage(//
                fit: BoxFit.cover,
                image: NetworkImage(LocalStorage.getValue("photo") ?? ""))));
  }

  Widget _availableMenuItems() {
    return Container(
      color: AppColors.whiteColor,
      child: Column(
        children: [
          _firstRow(),
          _secondRow(),
          _thirdRow(),
         // _fourthRow(),
        ],
      ),
    );
  }

  Widget _fourthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [

      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20);
  }

  Widget _thirdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SelectCard(
          image: ImageConstants.smsDash,
          text: Constants.SMS,
          status: Status.SMS,
        ),
        SelectCard(
          image: ImageConstants.staffDash,
          text: Constants.STAFFDETAILS,
          status: Status.STAFFDETAILS,
        ),
        SelectCard(
          image: ImageConstants.newsDash,
          text: Constants.NEWS,
          status: Status.NEWS,
        ),
        SelectCard(
          image: ImageConstants.schoolCalenderDash,
          text: Constants.CALENDER,
          status: Status.SCHOOLCALENDER,
        ),

      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20);
  }

  Widget _secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SelectCard(
          image: ImageConstants.examResultDash,
          text: Constants.EXAMRESULT,
          status: Status.EXAMRESULT,
        ),
        SelectCard(
          image: ImageConstants.eventDash,
          text: Constants.EVENT,
          status: Status.EVENT,
        ),
        SelectCard(
          image: ImageConstants.circularDash,
          text: Constants.CIRCULAR,
          status: Status.CIRCULAR,
        ),
        SelectCard(
          image: ImageConstants.voiceDash,
          text: Constants.VOICE,
          status: Status.VOICE,
        ),
      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20);
  }

  Widget _firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SelectCard(
          image: ImageConstants.homeworkDashImg,
          text: Constants.HOMEWRK,
          status: Status.HOMEWORK,
        ),
        SelectCard(
          image: ImageConstants.classTestDashImg,
          text: Constants.CLASSTEST,
          status: Status.CLASSTEST,
        ),
        SelectCard(
          image: ImageConstants.classTimeTableDash,
          text: Constants.CLASSTIMETABLE,
          status: Status.CLASSTIMETABLE,
        ),
        SelectCard(
          image: ImageConstants.examTimeTableDash,
          text: Constants.EXAMTIMETABLE,
          status: Status.EXAMTIMETABLE,
        ),
      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20, top: 10);
  }

  Widget _buildSizedBoxHeight({required double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget _wishMsgWidget(BuildContext context, HomeController homeController) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: timeOfTheDayWidget(homeController),
    );
  }

  Widget timeOfTheDayWidget(HomeController homeController) {
    int timeOfTheDay = DateTime.now().hour;
    String text = "";
    String text1 = '';
    String image = "";
    if (timeOfTheDay >= 0 && timeOfTheDay < 12) {
      text = Constants.goodmorning;
      text1 = Constants.goodMorningMsg;
      image = ImageConstants.morningJsonImg;
    } else if (timeOfTheDay >= 12 && timeOfTheDay < 16) {
      text = Constants.goodAfternoon;
      text1 = Constants.goodAfternoonMsg;
      image = ImageConstants.afternoonJsonImg;
    } else if (timeOfTheDay >= 16 && timeOfTheDay < 21) {
      text = Constants.goodEvng;
      text1 = Constants.goodEvenungMsg;
      image = ImageConstants.eveningJsonImg;
    } else if (timeOfTheDay >= 21 && timeOfTheDay < 24) {
      text = Constants.goodnyt;
      image = ImageConstants.nightJsonImg;
      text1 = Constants.goodnytMsg;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ListTile(
            title: Text(
              text,
              style: AppStyles.NunitoExtrabold.copyWith(
                  fontSize: 18, color: AppColors.whiteColor),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today Attendance",
                        style: AppStyles.NunitoRegular.copyWith(
                            fontSize: 15, color: AppColors.whiteColor))
                    .paddingOnly(top: 5),
                homeController.attendanceOverviewModel?.attendanceOverviewData
                            .todayAttendance !=
                        null
                    ? Text(
                            homeController
                                        .attendanceOverviewModel
                                        ?.attendanceOverviewData
                                        .todayAttendance!
                                        .leaveTypeId ==
                                    1
                                ? "Present"
                                : "Absent",
                            style: AppStyles.NunitoExtrabold.copyWith(
                                fontSize: 15, color: AppColors.whiteColor))
                        .paddingOnly(top: 10, left: 30)
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Attendance not taken",
                                style: AppStyles.NunitoExtrabold.copyWith(
                                    fontSize: 15, color: AppColors.whiteColor))
                            .paddingOnly(top: 10, left: 30),
                      ),
                homeController.attendanceOverviewModel?.attendanceOverviewData
                            .todayAttendance!.leaveTypeId ==
                        1
                    ? //
                    Image.asset(
                        "assets/present_switch.png",
                        width: 120,
                        height: 60,
                      )
                    : Image.asset(
                        "assets/absent_switch.png",
                        width: 120,
                        height: 60,
                      )
              ],
            ),
          ),
        ),
        Lottie.asset(image,
            width: Get.width * 0.4,
            repeat: true,
            controller: homeController.lottieController,
            onLoaded: (composition) {
          homeController.lottieController
            ..duration = composition.duration
            ..forward();
          homeController.lottieController.repeat();
        })
      ],
    );
  }

  Widget _rotatedHomeBg(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: RotatedBox(
            quarterTurns: -2,
            child: SMSImageAsset(
              image: ImageConstants.dashMaskImg,
              width: MediaQuery.of(context).size.width,
            )));
  }

  Widget _homeBgImage() =>
      const SMSImageAsset(image: ImageConstants.dashMaskImg);

  Widget _homeBgColor() {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
      colors: <Color>[AppColors.indigo1Color, AppColors.indigo2Color],
    )));
  }

  Widget _availableLanguages(
      BuildContext context, HomeController homeController) {
    return homeController.isLoading
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            child: Shimmer(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.withOpacity(0.1),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey.withOpacity(0.1), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.5)),
                            child: Center(
                                child: Container(
                              color: Colors.white.withOpacity(0.5),
                            )),
                          ),
                          const Text("            ")
                              .paddingOnly(left: 5, right: 5),
                          Container(
                            width: 30.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.2)),
                            child: const Center(
                                child: Text(
                              "  ",
                            )),
                          ),
                        ],
                      ).paddingAll(5));
                },
              ),
            ),
          )
        : Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: homeController.subjectList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.HOMEWORK,
                          arguments: const {"tag": "Homework"});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: AppColors.whiteColor,
                          child: Row(
                            children: [
                              Container(
                                  width: 40.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(homeController
                                                  .subjectList[index]
                                                  .subject
                                                  ?.icon
                                                  .toString() ??
                                              ImageConstants
                                                  .networkSampleImg)))),
                              Text(
                                homeController.subjectList[index].subject?.name
                                        .toString() ??
                                    "",
                                style: const TextStyle(
                                    color: AppColors.blackColor, fontSize: 14),
                              ).paddingOnly(left: 5, right: 5),
                              homeController.subjectList[index].subject
                                          ?.homeWorkCount ==
                                      0
                                  ? Container()
                                  : Container(
                                      width: 30.0,
                                      height: 20.0,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.redColor),
                                      child: Center(
                                          child: Text(
                                              homeController.subjectList[index]
                                                      .subject?.homeWorkCount
                                                      .toString() ??
                                                  "",
                                              style: const TextStyle(
                                                  color:
                                                      AppColors.whiteColor))),
                                    ),
                            ],
                          ).paddingAll(10)),
                    ),
                  );
                }),
          ).paddingOnly(left: 15);
  }

  Widget _homeAppbarWidget(HomeController homeController) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFF525CFF)),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _key.currentState!.openDrawer();
             // homeController.attendanceOverview();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Get.to(const NotificationsScreen());
               /* Get.back();
                Get.to(Profile());
                homeController.fetchStudentDetails();*/
              },
            ),
            const SizedBox(
              width: 20,
            ), //IconButton
            InkWell(
              onTap: () {
                showDialog(
                  context: Get.context!,
                  builder: (ctx) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.all(5),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Select Children",
                                    style: AppStyles.arimBold.copyWith(
                                        fontSize: 18,
                                        color: AppColors.blackColor))
                                .paddingOnly(bottom: 25, top: 15),
                            homeController.studentData.isNotEmpty
                                ? ListView.builder(
                                    itemCount:
                                        homeController.studentData.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          LocalStorage.setValue(
                                              "studentId",
                                              homeController.studentData[index]
                                                  .studentId);
                                          LocalStorage.setValue(
                                              "studentPhoto",
                                              homeController
                                                  .studentData[index].photo
                                                  .toString());
                                          homeController
                                              .fetchAvailableLanguage();
                                          homeController.paymentOverview();
                                          homeController.attendanceOverview();
                                          homeController.update();
                                          Get.back();
                                        },
                                        child: ListTile(
                                          leading: Container(
                                              width: 45.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color:
                                                          AppColors.blackColor,
                                                      width: 1),
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          homeController
                                                              .studentData[
                                                                  index]
                                                              .photo
                                                              .toString())))),
                                          title: Text(
                                              "${homeController.studentData[index].studentName ?? ""} (${homeController.studentData[index].code ?? ""})",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                          subtitle: Text(
                                            homeController.studentData[index]
                                                .standardSection
                                                .toString(),
                                            style:
                                                AppStyles.NunitoLight.copyWith(
                                                    fontSize: 12),
                                          ),
                                        ),
                                      );
                                    })
                                : Container(),
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.to(Profile());
                                homeController.fetchStudentDetails();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0XFF407BFF),
                                    Color(0XFF525CFF),
                                    ],
                                  )
                                  ),
                                  child: Center(
                                    child: Text("View Profile",
                                            style: AppStyles.PoppinsBold.copyWith(
                                              fontSize: 13,color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                      width: 35.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "${LocalStorage.getValue("studentPhoto")}"))))
                  .paddingOnly(right: 10),
            ), //IconButton
          ], //<W
        ),
      ),
    );
  }

 /* Widget _paymentCardView(BuildContext context, HomeController homeController) {
    return *//*((homeController.paymentOverviewModel != null) &&
            (homeController.paymentOverviewModel!.error!.isEmpty))
        ?*//*
        Container(
      width: double.infinity,
      // height: MediaQuery.of(context).size.height * 0.26,
      color: AppColors.toreaBayColor,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              colors: <Color>[AppColors.indigo1Color, AppColors.indigo2Color],
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Constants.home_key1,
              style: AppStyles.NunitoExtrabold.copyWith(
                  fontSize: 17, color: AppColors.whiteColor),
            ).paddingOnly(left: 20, top: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 12.0,
                    percent: percentageCal(homeController.paymentOverviewModel
                            ?.paymentOverviewData?.percentage ??
                        "0.0"),
                    center: Text(
                      "${homeController.paymentOverviewModel?.paymentOverviewData?.percentage ?? "0.0"}%",
                      style: const TextStyle(
                          fontSize: 20, color: AppColors.whiteColor),
                    ),
                    progressColor: AppColors.shadeOfIndianRed,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        linearProgressBar(
                            containerColor: AppColors.orangeColor,
                            progressColor: AppColors.orangeColor,
                            percentage: 1,
                            amount: homeController.paymentOverviewModel
                                    ?.paymentOverviewData?.total ??
                                "0",
                            text: "Total Fee"),
                        linearProgressBar(
                            progressColor: AppColors.shadeOfIndianRed,
                            containerColor: AppColors.shadeOfIndianRed,
                            percentage: 0,
                            amount: homeController.paymentOverviewModel
                                    ?.paymentOverviewData?.paid ??
                                "0",
                            text: "Total Paid"),
                        linearProgressBar(
                            containerColor: AppColors.cornflowerBlueColor,
                            progressColor: AppColors.cornflowerBlueColor,
                            percentage: 1,
                            amount: homeController.paymentOverviewModel
                                    ?.paymentOverviewData?.pending ??
                                "0",
                            text: "Total Pending"),
                      ],
                    ),
                  )
                ],
              ).paddingOnly(left: 25, top: 5),
            ),
          ],
        ),
      ).paddingAll(10),
    ) *//* : Container()*//*;
  }*/

  Widget overallAttendanceCard(
      BuildContext context, HomeController homeController) {
    return /*((homeController.attendanceOverviewModel != null))
        ?*/
        Container(
      color: Colors.transparent,
      child: Column(
        children: [
          /* _buildText(text: Constants.home_key2, fontSize: 16)
                    .paddingOnly(top: 20),
                _todayAttendance(
                    context, homeController.attendanceOverviewModel),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: _decorationOverview(),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _cardOfAttendance(
                          "Working Days",
                          homeController,
                          1,
                          homeController.attendanceOverviewModel
                                  ?.attendanceOverviewData?.noOfWorkingDays ??
                              0.0), //.attendanceOverviewData?.noOfWorkingDays.toString() ?? 0.toString()
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: _decorationOverview(),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _cardOfAttendance(
                          "Presents",
                          homeController,
                          2,
                          homeController.attendanceOverviewModel
                                  ?.attendanceOverviewData?.present ??
                              0.0),
                    ),
                  ],
                ).paddingOnly(left: 20, right: 20, top: 20, bottom: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.11,
                  decoration: _decorationOverview(),
                  child: _cardOfAttendance(
                      "Absents",
                      homeController,
                      3,
                      homeController.attendanceOverviewModel
                              ?.attendanceOverviewData?.absent ??
                          0.0),
                ).paddingOnly(left: 20, right: 20),*/
          _cblazeInfotechText()
        ],
      ),
    ) /* : Container()*/;
  }

  Widget _todayAttendance(
      BuildContext context, AttendanceOverviewModel? attendanceModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 15.0,
          percent: percentageCalWithSymbol(
              attendanceModel?.attendanceOverviewData?.percentage ?? "0.0%"),
          center: Text(
            attendanceModel?.attendanceOverviewData?.percentage.toString() ??
                "",
            style: const TextStyle(fontSize: 18, color: AppColors.whiteColor),
          ),
          progressColor: Colors.blue,
        ).paddingOnly(right: 20),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: _decorationOverview(),
          child: Row(
            children: [
              _buildText(text: Constants.home_key3, fontSize: 14)
                  .paddingOnly(left: 10),
              const SMSImageAsset(
                image: ImageConstants.absentSwitch,
                height: 70,
                width: 70,
              )
            ],
          ),
        )
      ],
    ).paddingOnly(top: 10);
  }

  Widget _cardOfAttendance(
      String txt, HomeController homeController, int type, dynamic value) {
    //String txt, String txt2,int type
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildText(text: txt, fontSize: 14),
            _buildText(text: value.toString(), fontSize: 14),
          ],
        ).paddingOnly(top: 10, bottom: 10, left: 10, right: 10),
        _attdanceLinearIndicator(getPercentageCalc(type, homeController))
      ],
    );
  }

  double getPercentageCalc(int type, HomeController homeController) {
    double workingDay = double.parse(homeController
            .attendanceOverviewModel?.attendanceOverviewData?.noOfWorkingDays
            .toString() ??
        "0.0");
    double presentDay = double.parse(homeController
            .attendanceOverviewModel?.attendanceOverviewData?.present
            .toString() ??
        "0.0");
    double absentDay = double.parse(homeController
            .attendanceOverviewModel?.attendanceOverviewData?.absent
            .toString() ??
        "0.0");
    double finalValue = 0.0;
    if (type == 1) {
      finalValue = 1.0;
    } else if (type == 2 && presentDay != 0.0) {
      finalValue = (presentDay / workingDay * 100) * 0.01;
    } else {
      if (absentDay != 0.0) {
        finalValue = (absentDay / workingDay * 100) * 0.01;
      }
    }

    return finalValue;
  }

  Widget _attdanceLinearIndicator(double value) {
    return LinearPercentIndicator(
      lineHeight: 10.0,
      percent: value,
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: AppColors.darkPinkColor,
    ).paddingOnly(bottom: 5);
  }

  Widget _cblazeInfotechText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          Constants.home_key4,
          style: TextStyle(fontSize: 12, color: AppColors.whiteColor),
        ),
        _buildText(text: Constants.home_key5, fontSize: 12),
      ],
    ).paddingOnly(top: 20, bottom: 20.0);
  }

  BoxDecoration _decorationOverview() {
    return const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.indigo2Color,
            AppColors.indigo2Color,
          ],
        ));
  }

  Text _buildText({String? text, double? fontSize}) => Text(
        text ?? "",
        style: AppStyles.NunitoExtrabold.copyWith(
            color: AppColors.whiteColor, fontSize: fontSize ?? 15),
      );
}

Widget linearProgressBar(
    {Color? containerColor,
    double? percentage,
    Color? progressColor,
    String? amount,
    String? text}) {
  return Row(
    children: [
      /*   Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: containerColor ?? AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10)),
      ).paddingOnly(top: 5, bottom: 5, left: 20, right: 5),*/
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width * 0.35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text.toString() ?? "",
                  style:
                      const TextStyle(fontSize: 8, color: AppColors.whiteColor),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.currency_rupee,
                      color: AppColors.whiteColor,
                      size: 10,
                    ),
                    Text(
                      amount.toString() ?? "", //
                      style: const TextStyle(
                          fontSize: 8, color: AppColors.whiteColor),
                    ),
                  ],
                ),
              ],
            ),
          ).paddingOnly(top: 5, bottom: 5, left: 10, right: 10),
          LinearPercentIndicator(
            width: MediaQuery.of(Get.context!).size.width * 0.4,
            lineHeight: 4.0,
            percent: percentage ?? 0.0,
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: progressColor ?? AppColors.whiteColor,
          ).paddingOnly(bottom: 5),
        ],
      ),
    ],
  );
}

class SideMenu extends StatelessWidget {
  final String headingText;
  final Widget child;
  final String imageLeading;

  SideMenu(
      {Key? key,
      required this.headingText,
      required this.child,
      required this.imageLeading})
      : super(key: key);

  final theme =
      Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme,
      child: ExpansionTile(
        iconColor: Color(0XFFFFFFFF),
        collapsedIconColor: Color(0XFFFFFFFF),
        /*leading: SMSImageAsset(
          image: imageLeading,
          height: 20,
          width: 20,
        ),*/
        title: Text(
          headingText,
          style: AppStyles.PoppinsRegular.copyWith(fontSize: 15, color: AppColors.whiteColor),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectCard extends StatelessWidget {
  const SelectCard(
      {Key? key, required this.image, required this.text, required this.status})
      : super(key: key);
  final String text;
  final String image;
  final Status status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updateStatusOfTheRoute(status);
      },
      child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Card(
                    elevation: 5,
                    child: Center(
                      child: SMSImageAsset(
                        image: image,
                        width: 60,
                        height: 60,
                      ),
                    )),
              ),
              Container(
                height: 35,
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: AppStyles.PoppinsRegular.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                      color: const Color(0XFF253238),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

class SubMenu extends StatelessWidget {
  final String image;
  final String text;
  final Function()? onTapped;

  const SubMenu(
      {Key? key, required this.text, required this.image, this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      /*leading: SMSImageAsset(
        height: 15,
        width: 15,
        image: image,
      ),*/
      title: Text(
        text,
        style: AppStyles.PoppinsRegular.copyWith(fontSize: 15,color: AppColors.blackColor),
      ),
      onTap: onTapped,
    );
  }
}

TextStyle buildTextStyle() => const TextStyle(
    color: AppColors.whiteColor, fontSize: 12, fontWeight: FontWeight.w400);
