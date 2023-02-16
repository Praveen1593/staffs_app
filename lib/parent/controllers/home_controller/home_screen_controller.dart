import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../common/apihelper/api_helper.dart';
import '../../model/attendance_overview_model.dart';
import '../../model/dashboard_model.dart';
import '../../model/month_list_model.dart';
import '../../model/payment_overview_model.dart';
import '../../model/student_details_model.dart';
import '../../../../common/services/base_client.dart';
import '../../view/dialogs/dialog_helper.dart';
import '../../../storage.dart';
import 'package:flutter_projects/common/const/colors.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  PaymentOverviewModel? paymentOverviewModel;
  AttendanceOverviewModel? attendanceOverviewModel;
  List<SubjectList> subjectList = [];
  int? currentMonthId;
  late AnimationController lottieController;
  List<StudentData> studentData = [];
  PackageInfo? packageInfo;
  bool isLoading = false;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  double? paymentPercentage;
  double? paymentLoaderPaid;
  double? paymentLoaderPending;

  @override
  void onInit() async {
    super.onInit();
    lottieController = AnimationController(
      vsync: this,
    );
    packageInfo = await PackageInfo.fromPlatform();
    studentData = [];
    print("inti called");
    LocalStorage.setValue("versionName", packageInfo?.version ?? "");
    fetchStudentDetails();
    fetchAvailableLanguage();
    paymentOverview();
    attendanceOverview();
  }

  @override
  void dispose() {
    super.dispose();

    Future.delayed(const Duration(microseconds: 500), () async {
      lottieController.dispose();
    });
  }

  Future refreshData() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      fetchStudentDetails();
      fetchAvailableLanguage();
      paymentOverview();
      attendanceOverview();
      update();
    });
  }

  Future paymentGatway(
      String url, Map<String, dynamic> userData) async {
    try {
      final result = await BaseService().postMethod(userData, url);

      if (result != null) {
        if (result.statusCode == 200) {

        } else {
          print("leaveRequestEdit ${result.statusCode}");
        }
      }
    } catch (e) {
      print('leaveRequestEdit $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  Future fetchStudentDetails() async {
    try {
      final result = await BaseService().getMethod(ApiHelper.studentDetailsUrl);
      if (result != null) {
        if (result.statusCode == 200) {
          StudentDetailsModel studentDetailsModel =
              StudentDetailsModel.fromJson(result.data);
          studentData = studentDetailsModel.studentData;
          LocalStorage.setValue("studentDetails", studentData);
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    }
    update();
  }

  /*Future fetchMonthList() async {
    try {
      final result = await BaseService().getMethod(ApiHelper.monthListUrl);
      if (result != null) {
        if (result.statusCode == 200) {
          MonthListModel monthListModel = MonthListModel.fromJson(result.data);
          List<MonthListData> monthList = monthListModel.monthData;
          if (monthList.isNotEmpty) {
            for (var element in monthList) {
              if (element.commonName ==
                  DateFormat("MMMM").format(DateTime.now()).trim()) {
                currentMonthId = element.id;
                print("currentMonthId${element.commonName}  ${DateFormat("MMMM").format(DateTime.now()).trim()} ${DateTime.now()}   ----> $currentMonthId");
              }
            }
            if (currentMonthId != null) {
              attendanceOverview(id: currentMonthId);
            }
          }
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    }
    update();
  }*/

  Future fetchAvailableLanguage() async {
    isLoading = true;
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.dashboardUrl}student_id=${LocalStorage.getValue('studentId')}");
      if (result != null) {
        if (result.statusCode == 200) {
          isLoading = false;
          DashboardModel dashboardModel = DashboardModel.fromJson(result.data);
          DashboardData dashboardData = dashboardModel.dashboardData;
          subjectList = dashboardData.subjectList ?? [];
        } else {
          Get.snackbar("Something went wrong", result.statusCode, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
         // showToastMsg("Something went wrong");
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    } finally {
      isLoading = false;
    }
    update();
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


  Future paymentOverview() async {
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.feePayment}student_id=${LocalStorage.getValue('studentId')}");
      if (result != null) {
        if (result.statusCode == 200) {
          paymentOverviewModel = PaymentOverviewModel.fromJson(result.data);
          //Paid
          int totalValue = paymentOverviewModel?.paymentOverviewData?.total??0;
          int pendingValue = paymentOverviewModel?.paymentOverviewData?.pending??0;
          int value5 = totalValue - pendingValue;
          double value1 = value5 / totalValue;
          double value2 = value1 * 100;
          paymentLoaderPaid = value2 * 0.01;

          //Pending
          int pendingTotalValue = paymentOverviewModel?.paymentOverviewData?.total??0;
          int paidValue = paymentOverviewModel?.paymentOverviewData?.paid??0;
          int value6 = pendingTotalValue - paidValue;
          double value3 = value6 / pendingTotalValue;
          double value4 = value3 * 100;
          paymentLoaderPending = value4 * 0.01;

        } else {
          paymentOverviewModel = PaymentOverviewModel(
              status: "Failed",
              code: 400,);
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    }
    update();
  }

  Future attendanceOverview() async {
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.attendanceOverviewUrl}student_id=${LocalStorage.getValue('studentId')}"); //&month_list_id=$id
      if (result != null) {
        if (result.statusCode == 200) {
          attendanceOverviewModel = AttendanceOverviewModel.fromJson(result.data);
          print("attendance Success");
        } else {
          print("attendance fail : ${result.statusCode}");
          // attendanceOverviewModel = AttendanceOverviewModel(
          //     status: "Failed",
          //     code: 400,
          //     );//error: attendanceOverviewModel?.error ?? ""
        }
      }
    } catch (e) {
      print('attendance $e');
    }
    update();
  }
}
