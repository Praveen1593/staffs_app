import 'package:get/get.dart';

import 'voice_controller.dart';

class VoiceBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => VoiceController());
  }
}