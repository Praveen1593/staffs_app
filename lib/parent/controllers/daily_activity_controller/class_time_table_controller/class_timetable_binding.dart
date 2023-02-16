import 'package:get/get.dart';

import 'class_time_table_controller.dart';

class ClassTimeTableBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ClassTimeTableController());
  }

}