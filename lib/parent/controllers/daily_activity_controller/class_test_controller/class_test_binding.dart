import 'package:flutter_projects/parent/controllers/daily_activity_controller/class_test_controller/class_test_controller.dart';
import 'package:get/get.dart';

class ClassTestBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ClassTestController());
  }

}