import 'package:get/get.dart';
import '../../../../common/common_controller/base_controller.dart';
import 'circular_event_news_controller.dart';

class NewsCircularEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BaseController());
    Get.lazyPut(() => NewsCircularEventController());
  }
}
