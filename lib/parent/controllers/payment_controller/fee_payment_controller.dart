import 'package:get/get.dart';
import 'package:flutter_projects/common/const/colors.dart';

import '../../../../common/apihelper/api_helper.dart';

import '../../../common/widgets/staff_common_widgets.dart';
import '../../model/fee_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../storage.dart';

class FeePaymentController extends GetxController {
  FeeModel? feeModel;
  bool? isLoading=false;
  int? tabIndex=0;
  @override
  void onInit() {
    super.onInit();
    getFeePayment();
  }

  void getFeePayment() async {
    isLoading=true;
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.feePayment}student_id=${LocalStorage.getValue('studentId')}");
      if (result != null && result.statusCode == 200) {
        isLoading=false;
        feeModel = FeeModel.fromJson(result.data);
      }else{

        Get.snackbar("Something went wrong", result.statusCode, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);

       // showStaffToastMsg("Something went wrong ${result.statusCode}");
      }
    } catch (e) {
      print("Fee Payment : $e");
    }finally{
      isLoading=false;
    }
    update();
  }
}
