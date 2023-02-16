import 'package:get/get.dart';

import 'material_bill_controller.dart';

class MaterialBillBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MaterialBillController());
  }

}