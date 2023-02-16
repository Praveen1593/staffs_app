import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/enums/loading_enums.dart';
import '../../../../common/services/base_client.dart';
import '../../../model/PayrollAdvanceSalaryModel.dart';

class AdvanceSalaryListController extends GetxController {

  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState = AdvanceSalaryListState(loadingType: LoadingType.stable).obs;
  List<AdvanceSalarayData> finalList = <AdvanceSalarayData>[].obs;
  ScrollController scrollController = ScrollController();
  PayrollAdvanceSalaryModel? payrollAdvanceSalaryModel;

  @override
  void onInit() {
    super.onInit();
    getAdvanceSalaryListData();
    scrollController.addListener(_scrollListener);
  }

  Future getAdvanceSalaryListData() async {
    if (_pageNo == 1) {
      isLoading.value = true;
    }
    try {
      final result = await BaseService().getMethod(
          "https://test.schoolec.in/api/staff/v2/payroll/advance-salary-list?page=$_pageNo");
      if (result != null) {
        if (result.statusCode == 200) {
          payrollAdvanceSalaryModel = PayrollAdvanceSalaryModel.fromJson(result.data);
          finalList.clear;
          finalList.assignAll(payrollAdvanceSalaryModel?.data ?? []);
          print("getLeaveListData :finelist ${finalList.length}");
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
          AdvanceSalaryListState(loadingType: LoadingType.loading);
      try {
        List<AdvanceSalarayData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await getAdvanceSalaryListData();

        if (listOfData.isEmpty) {
          loadingState.value = AdvanceSalaryListState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          finalList.addAll(listOfData);
          loadingState.value =
              AdvanceSalaryListState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value = AdvanceSalaryListState(
            loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

}
