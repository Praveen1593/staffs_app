import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/apihelper/api_helper.dart';
import '../../../common/enums/loading_enums.dart';
import '../../model/barrow_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../storage.dart';

class BarrowController extends GetxController{

  BarrowModel? barrowModel;
  ScrollController scrollController = ScrollController();
  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState = BarrowListLoadingState(loadingType: LoadingType.stable).obs;
  List<BarrowListData> finalList = <BarrowListData>[].obs;
  List<BarrowListData> barrowListData = [];

  @override
  void onInit() {
    super.onInit();
    _getData();
    scrollController.addListener(_scrollListener);
  }

  void _getData() async {
    List<BarrowListData> listOfData = [];
    listOfData = await fetchData(url: "${ApiHelper.libraryBarrowUrl}student_id=${LocalStorage.getValue('studentId')}&page=$_pageNo");
    print("barrow list size : ${listOfData.length}");

    finalList.clear();
    finalList.assignAll(listOfData);
    isLoading.value = false;
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value = BarrowListLoadingState(loadingType: LoadingType.loading);
      try {
        List<BarrowListData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await fetchData(url: "${ApiHelper.libraryBarrowUrl}student_id=${LocalStorage.getValue('studentId')}&page=${++_pageNo}");
        if (listOfData.isEmpty) {
          loadingState.value = BarrowListLoadingState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          finalList.addAll(listOfData);
          loadingState.value = BarrowListLoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            BarrowListLoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  Future<List<BarrowListData>> fetchData({String? url}) async {
    barrowListData = [];
    try {
      final result = await BaseService().getMethod(url??"");
      if (result != null) {
        if (result.statusCode == 200) {
          BarrowModel barrowModel = BarrowModel.fromJson(result.data);
          barrowListData = barrowModel.data!;
          print("barrow screen : ${result.statusCode}");
        }else{
          print("barrow screen : ${result.statusCode}");
        }
      }
    } catch (e) {
      print('Fetch News / Circular / Event  $e');
    }
    update();
    return barrowListData;
  }

}