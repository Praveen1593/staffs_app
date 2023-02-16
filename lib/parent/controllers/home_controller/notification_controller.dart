import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/staff_common_widgets.dart';
import 'package:get/get.dart';
import '../../../../common/apihelper/api_helper.dart';
import '../../model/notification_model.dart';
import '../../model/notification_read_model.dart';
import '../../../../common/services/base_client.dart';
import 'package:flutter_projects/common/const/colors.dart';

class NotificationController extends GetxController {
  NotificationModel? notificationModel;
  NotificationReadModel? notificationReadModel;
  bool statusUpdate = false;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void onInit() {
    super.onInit();
    getNotification();
  }

  Future refreshData() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      getNotification();
      update();
      Get.snackbar("Success","updated" ,snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
     // showStaffToastMsg("Updated");
    });
  }


  void getNotification() async {
    try {
      final result =
          await BaseService().getMethod(ApiHelper.notificationUrl);
      if (result != null && result.statusCode == 200) {
        notificationModel = NotificationModel.fromJson(result.data);
      }
    } catch (e) {
      print("Notification : $e");
    }
    update();
  }

  void getUpdate(bool val) {
    statusUpdate = val;
    update();
  }

  void getNotificationRead(int id) async {
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.notificationReadUrl}notification_id=$id");
      if (result != null && result.statusCode == 200) {
        notificationReadModel = NotificationReadModel.fromJson(result.data);
      }
    } catch (e) {
      print("Notification : $e");
    }
    update();
  }
}
