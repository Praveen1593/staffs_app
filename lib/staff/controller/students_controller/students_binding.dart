import 'package:flutter_projects/staff/controller/students_controller/students_details_controller.dart';
import 'package:flutter_projects/staff/controller/students_controller/students_sttendance_controller.dart';
import 'package:get/get.dart';

import 'leave_request_controller.dart';

class StudentsBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => StudentsDetailsController());
    Get.lazyPut(() => StudentsAttendanceController());
    Get.lazyPut(() => LeaveRequestController());
  }
}
