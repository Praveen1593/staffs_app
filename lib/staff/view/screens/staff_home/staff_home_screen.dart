import 'package:flutter/material.dart';
import 'package:flutter_projects/staff/themes/app_styles.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../../common/const/image_constants.dart';
import '../../../../common/routes/app_routes.dart';
import '../../../../common/widgets/staff_common_widgets.dart';
import '../../../../common/widgets/utils.dart';
import '../../../../../common/widgets/common_widgets.dart';
import 'package:get/get.dart';
import '../../../../storage.dart';
import '../../../controller/staff_home_controller/staff_home_screen_controller.dart';
import '../../../../common/enums/staff_enum_navigation.dart';

class StaffHomeScreen extends StatelessWidget {
  StaffHomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        body: GetBuilder<StaffHomeController>(
            init: StaffHomeController(),
            builder: (homeController) {
              return _buildBody(context, homeController);
            }),
        drawer: _buildDrawer());
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _drawerHeaderWidget(),
          _homeworkWithMenuItems(),
          _payroll(),
          _examManagerWithMenuItems(),
          _onlineClassesWithMenuItems(),
          _library(),
          _inventoryWithMenuItems(),
          _students(),
          _schoolCalenderWidget(),
          _diverWidget(),
          _logoutWidget(),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, StaffHomeController homeController) {
    return SafeArea(
      child: Stack(
        children: [
          _homeBgColor(),
          _homeBgImage(),
          _rotatedHomeBg(context),
          _homeAppbarWidget(homeController),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
                child: Column(
              children: [
                _buildSizedBoxHeight(height: 60),
                _wishMsgWidget(context, homeController),
                _buildSizedBoxHeight(height: 30),
                (homeController.sDashboarddata != null)
                    ? Container(
                        width: double.infinity,
                        color: AppColors.toreaBayColor,
                        child: Column(
                          children: [
                            homeController.sDashboarddata!.rateDealData!
                                    .standardList!.isNotEmpty
                                ? studentOverallDetails(homeController)
                                : Container(),
                            _buildSizedBoxHeight(height: 10),
                            _salaryOverview(context, homeController),
                          ],
                        ),
                      )
                    : Container(
                        color: AppColors.chocolateColor,
                        child: const Text(
                          "Fetching Data",
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      ),
                _availableMenuItems(),
                homeController.dAttendanceOveralldata != null
                    ? overallAttendanceCard(context, homeController)
                    : Container()
              ],
            )),
          ),
        ],
      ),
    );
  }

  Widget _logoutWidget() {
    return ListTile(
      leading: const Icon(
        Icons.login,
        color: AppColors.darkPinkColor,
        size: 20,
      ),
      onTap: () {
        LocalStorage.setValue('login', false);
        LocalStorage.setValue('token', "");
        LocalStorage.setValue("studentId", "");
        Get.offAllNamed(AppRoutes.LOGINVIEW);
      },
      title: Text(
        Constants.LOGOUT,
        style: arimoBoldTextStyle(fontSize: 13, color: AppColors.blackColor),
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
        leading: const SMSImageAsset(
          image: ImageConstants.schoolCalnderImg,
          height: 20,
          width: 20,
        ),
        onTap: () {
          updateStaffStatus(StaffStatus.SCHOOLCALENDER);
        },
        title: Text(
          Constants.SCHOOLCALENDER,
          style: arimoBoldTextStyle(fontSize: 13, color: AppColors.blackColor),
        ));
  }

  Widget _students() {
    return SideMenu(
        headingText: Constants.students,
        imageLeading: ImageConstants.extraActivitiesImg,
        child: Column(
          children: [
            SubMenu(
              text: Constants.studentListDetails,
              image: ImageConstants.examResultImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.STUDENTLISTDETAILS);
              },
            ),
            SubMenu(
              text: Constants.studentAttendance,
              image: ImageConstants.examResultImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.STUDENTATTENDANCE);
              },
            ),
            SubMenu(
              text: Constants.studentLeaveRequest,
              image: ImageConstants.examResultImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.STUDENTLEAVEREQUEST);
              },
            ),
          ],
        ));
  }

  Widget _inventoryWithMenuItems() {
    return comingSoonWidget(Constants.INVENTORY, ImageConstants.inventoryImg);
  }

  Widget _onlineClassesWithMenuItems() {
    return comingSoonWidget(
        Constants.ONLINECLASS, ImageConstants.onlineClassImg);
  }

  Widget _library() {
    return comingSoonWidget(Constants.LIBRARY, ImageConstants.libraryImg);
  }

  Widget comingSoonWidget(String text, String image) {
    return Theme(
      data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        iconColor: AppColors.darkPinkColor,
        collapsedIconColor: AppColors.darkPinkColor,
        onExpansionChanged: (expansion) {
          //showStaffToastMsg("coming soon");
        },
        trailing: const RotatedBox(
                quarterTurns: 3,
                child: Icon(Icons.arrow_back_ios_new_rounded, size: 15))
            .paddingOnly(right: 5),
        leading: SMSImageAsset(
          image: image,
          height: 20,
          width: 20,
        ),
        title: Text(
          text,
          style: arimoBoldTextStyle(fontSize: 13, color: AppColors.blackColor),
        ),
      ),
    );
  }

  Widget _examManagerWithMenuItems() {
    return SideMenu(
        headingText: Constants.EXAMMANAGER,
        imageLeading: ImageConstants.examManagerImg,
        child: Column(
          children: [
            SubMenu(
              text: Constants.EXAMRESULT,
              image: ImageConstants.examResultImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.EXAMRESULT);
              },
            ),
            SubMenu(
              text: Constants.EXAMTIMETABLE,
              image: ImageConstants.examTimeTableImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.EXAMTIMETABLE);
              },
            ),
            SubMenu(
              text: Constants.classTeacher,
              image: ImageConstants.examTimeTableImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.CLASSTEACHEREXAMRESULT);
              },
            ),
          ],
        ));
  }

  Widget _payroll() {
    return SideMenu(
        headingText: Constants.PAYROLL,
        imageLeading: ImageConstants.paymentAndInvoiceImg,
        child: Column(
          children: [
            SubMenu(
              text: Constants.staffAttendance,
              image: ImageConstants.vehicleTrackImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.ATTENDANCE);
              },
            ),
            SubMenu(
              text: Constants.staffLeaveList,
              image: ImageConstants.vehicleTrackImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.LEAVELIST);
              },
            ),
            SubMenu(
              text: Constants.staffSalaryList,
              image: ImageConstants.vehicleTrackImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.SALARYLIST);
              },
            ),
            SubMenu(
              text: Constants.epfEsiManage,
              image: ImageConstants.vehicleTrackImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.EPFESIMANAGE);
              },
            ),
            SubMenu(
              text: Constants.staffAdvanceSalary,
              image: ImageConstants.vehicleTrackImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.ADAVANCESALARY);
              },
            ),
            SubMenu(
              text: Constants.loanDetails,
              image: ImageConstants.vehicleTrackImg,
              onTapped: () {
                updateStaffStatus(StaffStatus.LOANDETAILS);
              },
            ),
          ],
        ));
  }

  Widget _homeworkWithMenuItems() {
    return SideMenu(
      headingText: Constants.DAILYACTIVITIES,
      imageLeading: ImageConstants.dailyActivitesImg,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SubMenu(
            text: Constants.HOMEWRK,
            image: ImageConstants.homeworkImg,
            onTapped: () {
              updateStaffStatus(StaffStatus.HOMEWORK);
            },
          ),
          SubMenu(
            text: Constants.CLASSTEST,
            image: ImageConstants.classTestImg,
            onTapped: () {
              updateStaffStatus(StaffStatus.CLASSTEST);
            },
          ),
          SubMenu(
            text: Constants.CLASSTIMETABLE,
            image: ImageConstants.classTestImg,
            onTapped: () {
              updateStaffStatus(StaffStatus.CLASSTIMETABLE);
            },
          ),
          SubMenu(
            text: Constants.CIRCULAR,
            image: ImageConstants.circularImg,
            onTapped: () {
              updateStaffStatus(StaffStatus.CIRCULAR);
            },
          ),
          SubMenu(
            text: Constants.EVENT,
            image: ImageConstants.eventImg,
            onTapped: () {
              updateStaffStatus(StaffStatus.EVENT);
            },
          ),
          SubMenu(
            text: Constants.NEWS,
            image: ImageConstants.newsImg,
            onTapped: () {
              updateStaffStatus(StaffStatus.NEWS);
            },
          ),
          SubMenu(
            text: Constants.SMS,
            image: ImageConstants.smsImg,
            onTapped: () {
              updateStaffStatus(StaffStatus.SMS);
            },
          ),
          SubMenu(
            text: Constants.VOICE,
            image: ImageConstants.voiceImage,
            onTapped: () {
              updateStaffStatus(StaffStatus.VOICE);
            },
          ),
        ],
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
        "Version : ${LocalStorage.getValue("versionName")}      ",
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
          style: arimoBoldTextStyle(fontSize: 15, color: AppColors.whiteColor),
        ),
        Text(
          LocalStorage.getValue("code") ?? "",
          style: AppStyles.normal
              .copyWith(fontSize: 13, color: AppColors.whiteColor),
        ).paddingOnly(top: 5, bottom: 5),
        Text(
          LocalStorage.getValue("phoneNumber") ?? "",
          style: AppStyles.normal
              .copyWith(fontSize: 14, color: AppColors.whiteColor),
        ),
      ],
    );
  }

  Widget _profileDrawerImage() {
    return Container(
        width: 120.0,
        height: 70.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: AppColors.blackColor),
            image: DecorationImage(
                fit: BoxFit.fill,
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
          _fourthRow(),
        ],
      ),
    );
  }

  Widget _fourthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        StaffSelectCard(
          image: ImageConstants.voiceDash,
          text: Constants.VOICE,
          status: StaffStatus.VOICE,
        ),
        StaffSelectCard(
          image: ImageConstants.staffDash,
          text: Constants.studentsDetails,
          status: StaffStatus.STUDENTLISTDETAILS,
        ),
        StaffSelectCard(
          image: ImageConstants.schoolCalenderDash,
          text: Constants.CALENDER,
          status: StaffStatus.SCHOOLCALENDER,
        ),
      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20);
  }

  Widget _thirdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        StaffSelectCard(
          image: ImageConstants.eventDash,
          text: Constants.EVENT,
          status: StaffStatus.EVENT,
        ),
        StaffSelectCard(
          image: ImageConstants.newsDash,
          text: Constants.NEWS,
          status: StaffStatus.NEWS,
        ),
        StaffSelectCard(
          image: ImageConstants.smsDash,
          text: Constants.SMS,
          status: StaffStatus.SMS,
        ),
      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20);
  }

  Widget _secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        StaffSelectCard(
          image: ImageConstants.examResultDash,
          text: Constants.EXAMRESULT,
          status: StaffStatus.EXAMRESULT,
        ),
        StaffSelectCard(
          image: ImageConstants.examTimeTableDash,
          text: Constants.EXAMTIMETABLE,
          status: StaffStatus.EXAMTIMETABLE,
        ),
        StaffSelectCard(
          image: ImageConstants.circularDash,
          text: Constants.CIRCULAR,
          status: StaffStatus.CIRCULAR,
        ),
      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20);
  }

  Widget _firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        StaffSelectCard(
          image: ImageConstants.homeworkDashImg,
          text: Constants.HOMEWRK,
          status: StaffStatus.HOMEWORK,
        ),
        StaffSelectCard(
          image: ImageConstants.classTestDashImg,
          text: Constants.CLASSTEST,
          status: StaffStatus.CLASSTEST,
        ),
        StaffSelectCard(
          image: ImageConstants.classTimeTableDash,
          text: Constants.CLASSTIMETABLE,
          status: StaffStatus.CLASSTIMETABLE,
        ),
      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20, top: 10);
  }

  Widget _buildSizedBoxHeight({required double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget _wishMsgWidget(
      BuildContext context, StaffHomeController homeController) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: timeOfTheDayWidget(homeController),
    );
  }

  Widget timeOfTheDayWidget(StaffHomeController homeController) {
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
            subtitle: Text(text1,
                    style: AppStyles.NunitoRegular.copyWith(
                        fontSize: 15, color: AppColors.whiteColor))
                .paddingOnly(top: 5),
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

  Widget _homeAppbarWidget(StaffHomeController homeController) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          _key.currentState!.openDrawer();
        },
        child:
            const SMSImageAsset(image: ImageConstants.menuIcon).paddingAll(15),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
          },
        ),
        const SizedBox(
          width: 20,
        ), //IconButton
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.STAFFPROFILE);
          },
          child: Container(
                  width: 40.0,
                  height: 30.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(ImageConstants.examTimeTableImg))))
              .paddingOnly(right: 10),
        ), //IconButton
      ], //<W
    );
  }

  Widget studentOverallDetails(StaffHomeController homeController) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[AppColors.indigo1Color, AppColors.indigo2Color],
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Student Overall",
                style: AppStyles.NunitoExtrabold.copyWith(
                    fontSize: 17, color: AppColors.whiteColor),
              ).paddingOnly(left: 20, top: 10, bottom: 5),
              Text(
                "View all",
                style: AppStyles.NunitoExtrabold.copyWith(
                    fontSize: 15, color: AppColors.whiteColor),
              ).paddingOnly(left: 20, top: 10, bottom: 5, right: 20),
            ],
          ),
          Text(
            "Total Students ${homeController.sDashboarddata?.rateDealData?.totalStudent ?? "0.0"} | Total Standards ${homeController.sDashboarddata?.rateDealData?.standardList?.length ?? "0.0"}",
            style: AppStyles.NunitoRegular.copyWith(
                fontSize: 12, color: AppColors.whiteColor),
          ).paddingOnly(left: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  width: MediaQuery.of(Get.context!).size.width,
                  child: _studentsLinearProgressBar(
                      containerColor: AppColors.lightOrange,
                      progressColor: AppColors.shadeOfPinkColor,
                      percentage: 0.5,
                      width: MediaQuery.of(Get.context!).size.width * 0.7,
                      sizedBoxWidth:
                          MediaQuery.of(Get.context!).size.width * 0.65,
                      text: homeController.sDashboarddata?.rateDealData
                              ?.standardList?[0].standardName ??
                          "",
                      text1: homeController.sDashboarddata?.rateDealData
                              ?.standardList?[0].studentCount
                              .toString() ??
                          "0"),
                ),
              ),
              _studentsLinearProgressBar(
                  progressColor: Colors.lightGreenAccent[100],
                  containerColor: AppColors.cornflowerBlueColor,
                  percentage: 0.6,
                  width: MediaQuery.of(Get.context!).size.width * 0.7,
                  sizedBoxWidth: MediaQuery.of(Get.context!).size.width * 0.65,
                  text: homeController.sDashboarddata?.rateDealData
                          ?.standardList?[1].standardName ??
                      "",
                  text1: homeController.sDashboarddata?.rateDealData
                          ?.standardList?[1].studentCount
                          .toString() ??
                      "0"),
              _studentsLinearProgressBar(
                  containerColor: AppColors.DarkCyan,
                  progressColor: AppColors.DarkCyan,
                  percentage: 0.1,
                  width: MediaQuery.of(Get.context!).size.width * 0.7,
                  sizedBoxWidth: MediaQuery.of(Get.context!).size.width * 0.65,
                  text: homeController.sDashboarddata?.rateDealData
                          ?.standardList?[2].standardName ??
                      "",
                  text1: homeController.sDashboarddata?.rateDealData
                          ?.standardList?[2].studentCount
                          .toString() ??
                      "0"),
            ],
          ).paddingOnly(top: 5),
          Row(
            children: [
              const Icon(
                Icons.info,
                size: 15,
                color: AppColors.whiteColor,
              ).paddingOnly(right: 10),
              const Expanded(
                child: Text(
                  "Know more details about Standards or Students Click View all",
                  style: TextStyle(fontSize: 10, color: AppColors.whiteColor),
                ),
              )
            ],
          ).paddingAll(20)
        ],
      ),
    ).paddingAll(5).paddingAll(5);
  }

  Widget _studentsLinearProgressBar(
      {Color? containerColor,
      double? percentage,
      Color? progressColor,
      required double width,
      required double sizedBoxWidth,
      required String text,
      required String text1}) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: containerColor ?? AppColors.whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                  Text(text,
                      style: AppStyles.NunitoExtrabold.copyWith(
                        fontSize: 10,
                        color: AppColors.whiteColor,
                      )),
                  Text(text1,
                      style: AppStyles.NunitoExtrabold.copyWith(
                        fontSize: 10,
                        color: AppColors.whiteColor,
                      )),
                ],
              ),
            ).paddingOnly(top: 5, bottom: 5, left: 10, right: 10),
            LinearPercentIndicator(
              width: width,
              lineHeight: 4.0,
              percent: 1.0,
              progressColor: progressColor ?? AppColors.whiteColor,
            ).paddingOnly(bottom: 5),
          ],
        ),
      ],
    );
  }

  Widget _salaryOverview(
      BuildContext context, StaffHomeController homeController) {
    return Container(
      width: double.infinity,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Salary Overview",
                style: AppStyles.NunitoExtrabold.copyWith(
                    fontSize: 15, color: AppColors.whiteColor),
              ).paddingOnly(left: 20, top: 10),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "${Constants.RUPEESYMBOOL} ${homeController.sDashboarddata?.lastMonthSalary?.salary ?? ""}",
                      style: AppStyles.NunitoExtrabold.copyWith(
                          fontSize: 15, color: AppColors.whiteColor),
                    ).paddingOnly(left: 20, top: 10),
                    Text("Today Salary",
                            style: AppStyles.NunitoExtrabold.copyWith(
                                fontSize: 10, color: AppColors.whiteColor))
                        .paddingOnly(right: 5, top: 10)
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 12.0,
                  percent: 1,/*percentageCal(
                      "${homeController.sDashboarddata?.lastMonthSalary?.percentage?.toStringAsFixed(2) ?? 0.0}")*/
                  center: Text(
                    "${homeController.sDashboarddata?.lastMonthSalary?.percentage?.toPrecision(2)}%",
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
                          amount: homeController
                                  .sDashboarddata?.lastMonthSalary?.allowance ??
                              "0.0",
                          text: homeController.sDashboarddata?.lastMonthSalary
                                  ?.allowanceName ??
                              ""),
                      linearProgressBar(
                          progressColor: AppColors.shadeOfIndianRed,
                          containerColor: AppColors.shadeOfIndianRed,
                          percentage: 0,
                          amount: homeController
                                  .sDashboarddata?.lastMonthSalary?.deduction ??
                              "0.0",
                          text: homeController.sDashboarddata?.lastMonthSalary
                                  ?.deductionName ??
                              ""),
                      linearProgressBar(
                          containerColor: AppColors.cornflowerBlueColor,
                          progressColor: AppColors.cornflowerBlueColor,
                          percentage: 1,
                          amount: homeController
                                  .sDashboarddata?.lastMonthSalary?.lop
                                  .toString() ??
                              "0.0",
                          text: "Loss of pay"),
                    ],
                  ),
                )
              ],
            ).paddingOnly(left: 25, top: 5),
          ),
          Row(
            children: [
              const Icon(
                Icons.info_rounded,
                size: 14,
                color: AppColors.whiteColor,
              ).paddingOnly(right: 10),
              const Expanded(
                child: Text(
                  "Know more about Salary or Payroll,Swipe right ot Click menu Button on Top Left",
                  style: TextStyle(fontSize: 10, color: AppColors.whiteColor),
                ),
              ),
            ],
          ).paddingAll(10)
        ],
      ),
    ).paddingAll(10);
  }

  Widget overallAttendanceCard(
      BuildContext context, StaffHomeController controller) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          _buildText(text: Constants.home_key2, fontSize: 16)
              .paddingOnly(top: 20),
          Container(
            color: Colors.white10,
            child: Column(
              children: [
                _todayAttendance(context, controller),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: _decorationOverview(),
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: _cardOfAttendance(
                          "Working Days ",
                          controller.dAttendanceOveralldata?.noOfWorkingDays
                                  ?.toDouble() ??
                              0,
                          1,
                          controller,AppColors.lightOrange), //.attendanceOverviewData?.noOfWorkingDays.toString() ?? 0.toString()
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: _decorationOverview(),
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: _cardOfAttendance(
                          "Presents",
                          controller.dAttendanceOveralldata?.present
                                  ?.toDouble() ??
                              0,
                          2,
                          controller,AppColors.DarkCyan),
                    ),
                  ],
                ).paddingOnly(left: 10, right: 10, top: 10, bottom: 10),
                Container(
                  decoration: _decorationOverview(),
                  child: Column(
                    children: [
                      _cardOfAttendance(
                          "Absents",
                          controller.dAttendanceOveralldata?.absent
                                  ?.toDouble() ??
                              0,
                          3,
                          controller,AppColors.shadeOfPinkColor).paddingOnly(top: 7),
                      (controller.dAttendanceOveralldata != null &&
                              controller.dAttendanceOveralldata!.leaveList!
                                  .isNotEmpty)
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      child: _cardOfAttendance(
                                          "Medical Leave",
                                          (controller.dAttendanceOveralldata
                                                      ?.leaveList?[index].id ==
                                                  3)
                                              ? controller
                                                      .dAttendanceOveralldata!
                                                      .leaveList![index]
                                                      .absentDetail
                                                      ?.total
                                                      ?.toDouble() ??
                                                  0
                                              : 0,
                                          4,
                                          controller,AppColors.orangeColor),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      child: _cardOfAttendance(
                                          "Causal Leave",
                                          (controller.dAttendanceOveralldata
                                                      ?.leaveList?[index].id ==
                                                  2)
                                              ? controller
                                                      .dAttendanceOveralldata!
                                                      .leaveList![1]
                                                      .absentDetail
                                                      ?.total
                                                      ?.toDouble() ??
                                                  0
                                              : 0,
                                          5,
                                          controller,AppColors.shadeOfIndianRed),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        child: _cardOfAttendance(
                                            "LOP Leave (loss of pay)",
                                            controller.dAttendanceOveralldata!
                                                        .leaveList![index].id ==
                                                    1
                                                ? controller
                                                        .dAttendanceOveralldata!
                                                        .leaveList![index]
                                                        .absentDetail
                                                        ?.total
                                                        ?.toDouble() ??
                                                    0
                                                : 0,
                                            6,
                                            controller,AppColors.cornflowerBlueColor)).paddingOnly(bottom:10)
                                  ],
                                );
                              })
                          : Container(),
                    ],
                  ),
                ).paddingOnly(left: 10, right: 10),
                _buildSizedBoxHeight(height: 20)
              ],
            ),
          ).paddingAll(10),
          _cblazeInfotechText()
        ],
      ),
    );
  }

  Widget _todayAttendance(
      BuildContext context, StaffHomeController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 15.0,
          percent: percentageCalWithSymbol(
              controller.dAttendanceOveralldata?.percentage.toString() ??
                  "0.0%"),
          center:  Text(
            controller.dAttendanceOveralldata?.percentage.toString() ??
                "0.0%",
            style:const TextStyle(fontSize: 18, color: AppColors.whiteColor),
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
              _buildText(text: "Attendance \nnot taken", fontSize: 10)
                  .paddingOnly(left: 10),
            ],
          ),
        )
      ],
    ).paddingOnly(top: 10);
  }

  Widget _cardOfAttendance(
      String txt, double type, int refVal, StaffHomeController homeController,Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildText(text: txt, fontSize: 14),
            _buildText(text: type.toString(), fontSize: 14),
          ],
        ).paddingOnly(top: 5, bottom: 10, left: 10, right: 10),
        _attdanceLinearIndicator(getPercentageCalc(
          type,
          refVal,
          homeController
        ),color)
      ],
    );
  }

  double getPercentageCalc(
      double type, int refVal, StaffHomeController homeController) {
    double workingDay = double.parse(
        homeController.dAttendanceOveralldata?.noOfWorkingDays.toString() ??
            "0.0");
    double finalValue = 0.0;
    if (refVal == 1) {
      finalValue = 1.0;
    } else {
      finalValue = (type / workingDay * 100) * 0.01;
    }
    return finalValue;
  }

  Widget _attdanceLinearIndicator(double value,Color color) {
    return LinearPercentIndicator(
      lineHeight: 10.0,
      percent: value,
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: color,
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
      Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            gradient:const LinearGradient(
              colors: <Color>[
                Colors.white30,
                Colors.lightGreenAccent,
                Colors.lightGreenAccent
              ],
            ),
            borderRadius: BorderRadius.circular(10)),
      ).paddingOnly(top: 5, bottom: 5, left: 20, right: 5),
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
        iconColor: AppColors.darkPinkColor,
        collapsedIconColor: AppColors.darkPinkColor,
        leading: SMSImageAsset(
          image: imageLeading,
          height: 20,
          width: 20,
        ),
        title: Text(
          headingText,
          style: arimoBoldTextStyle(fontSize: 13, color: AppColors.blackColor),
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

class StaffSelectCard extends StatelessWidget {
  const StaffSelectCard(
      {Key? key, required this.image, required this.text, required this.status})
      : super(key: key);
  final String text;
  final String image;
  final StaffStatus status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updateStaffStatus(status);
      },
      child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 90,
                width: 90,
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
              const SizedBox(height: 5),
              Text(
                text,
                style: AppStyles.arimBold.copyWith(
                  fontSize: 12,
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
      leading: SMSImageAsset(
        height: 15,
        width: 15,
        image: image,
      ),
      title: Text(
        text,
        style: buildTextStyle(),
      ),
      onTap: onTapped,
    );
  }
}

TextStyle buildTextStyle() => const TextStyle(
    color: AppColors.blackColor, fontSize: 12, fontWeight: FontWeight.w400);
