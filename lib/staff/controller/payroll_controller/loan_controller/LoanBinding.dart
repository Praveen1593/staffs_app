import 'package:get/get.dart';
import 'LoanController.dart';


class LoanBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => LoanController());
  }
}