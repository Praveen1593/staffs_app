import 'package:get/get.dart';

import 'home_screen_controller.dart';

class HomeBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}