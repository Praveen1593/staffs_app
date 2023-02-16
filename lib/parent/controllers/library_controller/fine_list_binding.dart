import 'package:get/get.dart';

import 'fine_list_controller.dart';

class FineListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FineListController());
  }

}