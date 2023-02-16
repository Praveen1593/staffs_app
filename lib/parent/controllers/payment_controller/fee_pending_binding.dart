import 'package:get/get.dart';

import 'fee_pending_controller.dart';

class FeePendingBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => FeePendingController());
  }
}

