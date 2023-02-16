import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/enums/loading_enums.dart';
import '../../../../common/services/base_client.dart';
import '../../../model/PayrollSalaryListModel.dart';

class SalaryListController extends GetxController {

  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState = SalaryListState(loadingType: LoadingType.stable).obs;
  List<SalaryData> finalList = <SalaryData>[].obs;
  ScrollController scrollController = ScrollController();
  PayrollSalaryListModel? payrollSalaryListModel;

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
          "https://test.schoolec.in/api/staff/v2/payroll/salary/list?page=$_pageNo");
      if (result != null) {
        if (result.statusCode == 200) {
          payrollSalaryListModel = PayrollSalaryListModel.fromJson(result.data);
          finalList.assignAll(payrollSalaryListModel?.data ?? []);
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
          SalaryListState(loadingType: LoadingType.loading);
      try {
        List<SalaryData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await getSalaryListData();

        if (listOfData.isEmpty) {
          loadingState.value = SalaryListState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          finalList.addAll(listOfData);
          loadingState.value =
              SalaryListState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value = SalaryListState(
            loadingType: LoadingType.error, error: err.toString());
      }
    }
  }


}
