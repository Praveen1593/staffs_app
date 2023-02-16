import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/enums/loading_enums.dart';
import '../../../../common/services/base_client.dart';
import '../../../model/PayrollLoanModel.dart';

class LoanController extends GetxController {
  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState = LoanListState(loadingType: LoadingType.stable).obs;
  List<LoanData> finalList = <LoanData>[].obs;
  ScrollController scrollController = ScrollController();
  PayrollLoanModel? payrollLoanModel;

  @override
  void onInit() {
    super.onInit();
    getSalaryListData();
    scrollController.addListener(_scrollListener);
  }

  Future getSalaryListData() async {
    if (_pageNo == 1) {
      isLoading.value = true;
    }
    try {
      final result = await BaseService().getMethod(
          "https://test.schoolec.in/api/staff/v2/payroll/loan-list?page=$_pageNo");
      if (result != null) {
        if (result.statusCode == 200) {
          payrollLoanModel = PayrollLoanModel.fromJson(result.data);
          finalList.assignAll(payrollLoanModel?.data ?? []);
          isLoading.value = false;
          print("getLeaveListData : ${result.statusCode}");
        } else {
          print("getLeaveListData : ${result.statusCode}");
        }
      }
    } catch (e) {
      print("getLeaveListData : error");
    } finally {}
    update();
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value =
          LoanListState(loadingType: LoadingType.loading);
      try {
        List<LoanData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await getSalaryListData();

        if (listOfData.isEmpty) {
          loadingState.value = LoanListState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          finalList.addAll(listOfData);
          loadingState.value =
              LoanListState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value = LoanListState(
            loadingType: LoadingType.error, error: err.toString());
      }
    }
  }
}
