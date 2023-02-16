import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/apihelper/api_helper.dart';

import '../../../model/class_time_table_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../view/dialogs/dialog_helper.dart';
import '../../../../storage.dart';

class ClassTimeTableController extends GetxController {
  ClassTimeTableModel? classTimeTableModel;

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    Future.delayed(const Duration(seconds: 1), () {
      fetchClassTimeTable();
    });
  }

  Future fetchClassTimeTable() async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.classTmeTableUrl}student_id=${LocalStorage.getValue("studentId")}");
      if (result != null) {
        if (result.statusCode == 200) {
          classTimeTableModel = ClassTimeTableModel.fromJson(result.data);
          if (classTimeTableModel?.cttData?.periodSchedule != "") {}
        } else {
          classTimeTableModel = ClassTimeTableModel(
              code: 403,
              status: "error",
              error: classTimeTableModel?.error ?? "");
        }
      }
    } catch (e) {
      print('Exam List $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }
}
