import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/apihelper/api_helper.dart';
import '../../../common/enums/loading_enums.dart';
import '../../model/library_invoice_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../storage.dart';

class FineInvoiceController extends GetxController{

  RxBool showPaymentDetails = false.obs;
  RxBool showBookDetails = false.obs;
  ScrollController scrollController = ScrollController();
  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState = InvoiceListLoadingState(loadingType: LoadingType.stable).obs;
  List<InvoiceData> finalList = <InvoiceData>[].obs;
  List<InvoiceData> invoiceListData = [];

  void checkView(int type){

    if(type==1){

      showPaymentDetails.value = !showPaymentDetails.value;

    }else if(type==2){

      showBookDetails.value = !showBookDetails.value;

    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _getData();
    scrollController.addListener(_scrollListener);
  }

  void _getData() async {
    List<InvoiceData> listOfData = [];
    listOfData = await fetchData(url: "${ApiHelper.libraryInvoiceList}student_id=${LocalStorage.getValue('studentId')}&page=$_pageNo");
    finalList.clear();
    finalList.assignAll(listOfData);
    isLoading.value = false;
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value = InvoiceListLoadingState(loadingType: LoadingType.loading);
      try {
        List<InvoiceData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await fetchData(url: "${ApiHelper.libraryInvoiceList}student_id=${LocalStorage.getValue('studentId')}&page=${++_pageNo}");
        if (listOfData.isEmpty) {
          loadingState.value = InvoiceListLoadingState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          finalList.addAll(listOfData);
          loadingState.value = InvoiceListLoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            InvoiceListLoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  Future<List<InvoiceData>> fetchData({String? url}) async {
    invoiceListData = [];
    try {
      final result = await BaseService().getMethod(url??"");
      if (result != null) {
        if (result.statusCode == 200) {
          InvoiceModel invoiceModel = InvoiceModel.fromJson(result.data);
          invoiceListData = invoiceModel.data!;

        }
      }
    } catch (e) {
      print('Fetch News / Circular / Event  $e');
    }
    update();
    return invoiceListData;
  }


}