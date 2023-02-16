import 'package:get/get.dart';

import 'staff_details_controller.dart';

class StaffBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => StaffDetailsController());
  }
}