import 'package:flutter_projects/staff/controller/staff_home_controller/staff_home_screen_controller.dart';
import 'package:get/get.dart';

class StaffHomeBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => StaffHomeController());
  }
}