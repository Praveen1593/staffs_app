import 'package:flutter_projects/staff/controller/staff_calender_controller/staff_calender_controller.dart';
import 'package:get/get.dart';

class StaffCalenderBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => StaffCalenderController());
  }
}