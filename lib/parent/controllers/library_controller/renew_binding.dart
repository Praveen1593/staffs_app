import 'package:flutter_projects/parent/controllers/library_controller/renew_controller.dart';
import 'package:get/get.dart';


class RenewBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => RenewController());
  }

}