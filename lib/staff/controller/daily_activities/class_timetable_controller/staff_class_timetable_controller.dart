import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common/apihelper/api_helper.dart';
import '../../../../common/services/base_client.dart';
import '../../../../parent/view/dialogs/dialog_helper.dart';
import '../../../../storage.dart';
import '../../../model/StaffClassTimetableModel.dart';

class StaffclassTimetableController extends GetxController{

  StaffClassTimetableModel? staffClassTimetableModel;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      fetchClassTimeTable();
    });
  }

  Future fetchClassTimeTable() async {
   // showLoadingDialog(Get.context!);
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.classTmeTableUrl}student_id=${LocalStorage.getValue("studentId")}");
      if (result != null) {
        if (result.statusCode == 200) {
          staffClassTimetableModel = StaffClassTimetableModel.fromJson(result.data);
          if (staffClassTimetableModel?.data?.periodSchedule != "") {
           /* SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeRight,
              DeviceOrientation.landscapeLeft
            ]);*/
          }
        } else {
          /*classTimeTableModel = ClassTimeTableModel(
              code: 403,
              status: "error",
              error: classTimeTableModel?.error ?? "");*/
        }
      }
    } catch (e) {
      print('Exam List $e');
    } finally {
      //closeLoadingDialog(Get.context!);
    }
    update();
  }

}