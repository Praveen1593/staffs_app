import 'package:get/get.dart';

import 'attendance_details_controller.dart';


class AttendanceDetailsBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceDetailsController());
  }
}