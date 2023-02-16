import 'package:get/get.dart';

import '../../../../common/apihelper/api_helper.dart';

import '../../../model/fee_invoice_model.dart';
import '../../../model/fee_invoice_single_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../../storage.dart';

class FeeInvoiceController extends GetxController {
  FeeInvoiceModel? feeInvoiceModel;
  FeeInvoiceSingleModel? feeInvoiceSingleModel;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future getData() async {
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.feeInvoice}student_id=${LocalStorage.getValue("studentId")}");
      if (result != null) {
        if (result.statusCode == 200) {
          feeInvoiceModel = FeeInvoiceModel.fromJson(result.data);
        }
      }
    } catch (e) {
      print("Fee Invoice $e");
    } finally {}
    update();
  }

  Future getInvoiceSingleData(int id) async {
    //feeInvoiceSingleModel = FeeInvoiceSingleModel(status: "Failed", code: 403);
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.feeSingleInvoice}$id?student_id=${LocalStorage.getValue("studentId")}");
      if (result != null) {
        if (result.statusCode == 200) {
          feeInvoiceSingleModel = FeeInvoiceSingleModel.fromJson(result.data);
        } else {
          print("Fee Invoice Single Code: ${result.statusCode}");
        }
      }
    } catch (e) {
      print("Fee Invoice $e");
    } finally {}
    update();
  }
}
