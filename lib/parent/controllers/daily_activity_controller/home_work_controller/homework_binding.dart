import '../../../../common/common_controller/base_controller.dart';
import 'homework_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BaseController());
    Get.lazyPut(() => HomeworkController());
  }
}
