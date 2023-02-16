import 'package:get/get.dart';

import 'fine_invoice_controller.dart';

class FineInvoiceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FineInvoiceController());
  }

}