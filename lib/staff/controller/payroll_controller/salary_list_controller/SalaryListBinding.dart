import 'package:get/get.dart';

import 'SalaryListController.dart';


class SalaryListBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => SalaryListController());
  }
}