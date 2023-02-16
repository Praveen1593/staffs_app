import 'package:get/get.dart';

import '../../../../common/apihelper/api_helper.dart';

import '../../../model/staff_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../../storage.dart';

class StaffDetailsController extends GetxController {
  StaffModel? staffModel;
  bool? isLoading=false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  Future getData() async {
    isLoading = true;
    try {
      final result = await BaseService().getMethod("${ApiHelper.staffUrl}student_id=${LocalStorage.getValue("studentId")}");
      if (result != null) {
        if (result.statusCode == 200) {
          isLoading = false;
          staffModel = StaffModel.fromJson(result.data);
        }
      }
    } catch (e) {
      print("Staff Details $e");

    } finally {
      isLoading = false;
    }
    update();
  }


}
