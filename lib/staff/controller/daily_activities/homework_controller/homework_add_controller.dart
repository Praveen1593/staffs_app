import 'package:flutter_projects/common/apihelper/api_helper.dart';
import 'package:get/get.dart';

import '../../../../common/services/base_client.dart';
import '../../../../parent/view/dialogs/dialog_helper.dart';
import '../../../model/BasicSettingsModel.dart';
import '../../../model/StaffAddHomeworkResponce.dart';

class StaffAddHomeworkController extends GetxController {
  // TextEditingController titleEditController = TextEditingController();
  // TextEditingController descriptionEditController = TextEditingController();
  BasicSettingsmodel? basicSettingsmodel;
  StaffAddHomeworkResponce? staffAddHomeworkResponce;
  int? permissionChecked = 0;
  int? radiotype = 2;

  @override
  void onInit() {
    super.onInit();
    checkSettings();
  }

  void permissionUpdate(int value) {
    radiotype = value;
    if (value == 1) {
      permissionChecked = 1;
    } else if (value == 2) {
      permissionChecked = 0;
    }
    update();
  }

  Future checkSettings() async {
    final result =
        await BaseService().getMethod("${ApiHelper.settingUrl}");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          basicSettingsmodel = BasicSettingsmodel.fromJson(result.data);
        } else {
          print("checkSettings : ${result.statusCode}");
        }
      }
    } catch (e) {
      print("checkSettings $e");
    } finally {}
    update();
  }

  Future<StaffAddHomeworkResponce?> homeworkSubmit(
      Map<String, dynamic> userData, int hwId) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService().postMethod(
          userData, "${ApiHelper.todayHomeworkSubmitUrl}$hwId");
      if (result != null) {
        if (result.statusCode == 200) {
          staffAddHomeworkResponce =
              StaffAddHomeworkResponce.fromJson(result.data);
        }
      }
    } catch (e) {
      print('staffAddHomeworkResponce $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return staffAddHomeworkResponce;
  }
}
