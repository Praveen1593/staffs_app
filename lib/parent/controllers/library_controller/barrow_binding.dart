import 'package:get/get.dart';

import 'barrow_controller.dart';

class BarrowBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => BarrowController());
  }
}