import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/apihelper/api_helper.dart';
import '../../../common/enums/loading_enums.dart';
import '../../model/material_bill_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../storage.dart';

class MaterialBillController extends GetxController {
  MaterialBillModel? materialBillModel;
  ScrollController scrollController = ScrollController();
  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState =
      MaterialBillLoadingState(loadingType: LoadingType.stable).obs;
  List<MaterialListData> finalList = <MaterialListData>[].obs;
  List<MaterialListData> materialListData = [];

  @override
  void onInit() {
    super.onInit();
    _getData();
    scrollController.addListener(_scrollListener);
  }

  void _getData() async {
    List<MaterialListData> listOfData = [];
    listOfData = await fetchData(
        url:
            "${ApiHelper.inventoryMaterialBillUrl}student_id=${LocalStorage.getValue('studentId')}&page=$_pageNo");
    print("Inventory size : ${listOfData.length}");
    finalList.clear();
    finalList.assignAll(listOfData);
    isLoading.value = false;
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value =
          MaterialBillLoadingState(loadingType: LoadingType.loading);
      try {
        List<MaterialListData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await fetchData(
            url:
                "${ApiHelper.inventoryMaterialBillUrl}student_id=${LocalStorage.getValue('studentId')}&page=${++_pageNo}");
        if (listOfData.isEmpty) {
          loadingState.value = MaterialBillLoadingState(
              loadingType: LoadingType.completed,
              completed: "");
        } else {
          finalList.addAll(listOfData);
          loadingState.value =
              MaterialBillLoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value = MaterialBillLoadingState(
            loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  Future<List<MaterialListData>> fetchData({String? url}) async {
    materialListData = [];
    try {
      final result = await BaseService().getMethod(url ?? "");
      if (result != null) {
        if (result.statusCode == 200) {
          MaterialBillModel barrowModel =
              MaterialBillModel.fromJson(result.data);
          materialListData = barrowModel.data ?? [];
          print("Inventory screen : ${result.statusCode}");
        } else {
          print("Inventory screen : ${result.statusCode}");
        }
      }
    } catch (e) {
      print('Inventory  $e');
    }
    update();
    return materialListData;
  }
}
