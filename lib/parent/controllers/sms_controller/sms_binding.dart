import 'package:flutter_projects/parent/controllers/sms_controller/sms_all_controller.dart';
import 'package:get/get.dart';

class SmsBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => SmsController());
  }
}