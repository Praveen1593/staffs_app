import '../../../../common/common_controller/base_controller.dart';
import 'classtest_controller1.dart';
import 'package:get/get.dart';

class ClassTestBinding1 extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BaseController());
    Get.lazyPut(() => ClassTestController1());
  }
}
