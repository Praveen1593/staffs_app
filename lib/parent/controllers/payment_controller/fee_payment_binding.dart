import 'package:get/get.dart';

import 'fee_payment_controller.dart';

class FeePaymentBuinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => FeePaymentController);
  }
}