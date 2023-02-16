import 'package:flutter_projects/parent/controllers/profile_controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(),fenix: true);
  }

}