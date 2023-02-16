import 'package:flutter_projects/staff/controller/staff_exam_manager_controller/staff_exam_result_controller.dart';
import 'package:get/get.dart';

class StaffExamResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StaffExamResultController());
  }
}
