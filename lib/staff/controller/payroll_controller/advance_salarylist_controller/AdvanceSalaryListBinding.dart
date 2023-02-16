import 'package:get/get.dart';

import 'AdvanceSalaryListController.dart';


class AdvanceSalaryBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => AdvanceSalaryListController());
  }
}