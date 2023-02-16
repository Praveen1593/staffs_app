import 'package:flutter/cupertino.dart';
import 'package:flutter_projects/common/apihelper/api_helper.dart';
import 'package:flutter_projects/staff/model/staff_dashbboard_model.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../common/services/base_client.dart';
import '../../../storage.dart';
import '../../model/staff_d_attendance_overall_model.dart';

class StaffHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController lottieController;
  PackageInfo? packageInfo;
  StaffDashboardData? sDashboarddata;
  DAttendanceAllData? dAttendanceOveralldata;

  @override
  void onInit() async {
    super.onInit();
    lottieController = AnimationController(
      vsync: this,
    );
    packageInfo = await PackageInfo.fromPlatform();
    LocalStorage.setValue("versionName", packageInfo?.version ?? "");
    fetchDashboardData();
    fetchDashboardAttendanceData();
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  Future fetchDashboardData() async {
    try {
      final result = await BaseService()
          .getMethod(ApiHelper.dashboardOverallUrl);
      if (result != null) {
        if (result.statusCode == 200) {
          StaffDashboardModel dashboardModel =
              StaffDashboardModel.fromJson(result.data);
          sDashboarddata = dashboardModel.sDashboarddata;
        }
      }
    } catch (e) {
      print('Homework screen  $e');
    }
    update();
  }

  Future fetchDashboardAttendanceData() async {
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.payrollAttendanceUrl}list?leave_type=1");
      if (result != null) {
        if (result.statusCode == 200) {
          StaffDashboardAttendanceOverallModel dashboardModel =
              StaffDashboardAttendanceOverallModel.fromJson(result.data);
          dAttendanceOveralldata = dashboardModel.dAttendanceOveralldata;
        }
      }
    } catch (e) {
      print('Homework screen  $e');
    }
    update();
  }
}
