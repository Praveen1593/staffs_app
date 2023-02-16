import 'package:flutter_projects/common/const/colors.dart';
import 'package:flutter_projects/common/widgets/staff_common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_projects/common/const/colors.dart';

import '../../../../common/apihelper/api_helper.dart';

import '../../model/fee_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../storage.dart';

class FeePendingController extends GetxController {
  FeeModel? feeModel;
  double totalAmt = 0;
  double selectedTotalAmt = 0;
  bool mainDisplay = false;
  bool subDisplay = false;
  int? tabIndex=0;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      getFeePending();
    });
  }

  Future getFeePending() async {
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.feePayment}student_id=${LocalStorage.getValue("studentId")}");
      if (result != null) {
        if (result.statusCode == 200) {
          feeModel = FeeModel.fromJson(result.data);
        }else{
          print("Fee Pending ${result.statusCode}");
          Get.snackbar("Something went wrong", result.statusCode, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
         // showStaffToastMsg("Something went wrong ${result.statusCode}");
        }
      }
    } catch (e) {
      print("Fee Pending $e");
    } finally {}
    update();
  }
}
