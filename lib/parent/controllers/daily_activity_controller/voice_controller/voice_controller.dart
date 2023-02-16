import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/apihelper/api_helper.dart';
import '../../../../common/enums/loading_enums.dart';
import '../../../model/VoiceTodayModel.dart';
import '../../../model/custom_voice_overall_model.dart';
import '../../../model/voiceOverallModel.dart';
import '../../../../common/services/base_client.dart';
import '../../../../storage.dart';

class VoiceController extends GetxController  with GetSingleTickerProviderStateMixin  {
  ScrollController scrollController = ScrollController();
  ScrollController specificScrollController = ScrollController();
  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState =
      CustomVoiceLoadingState(loadingType: LoadingType.stable).obs;
  List<VoiceOverallData> specificList = <VoiceOverallData>[].obs;
  List<VoiceOverallData> overallList = <VoiceOverallData>[].obs;
  List<VoiceTodayData> finalList = <VoiceTodayData>[].obs;
  List<VoiceOverallData> customModel = [];
  late AnimationController lottieController;

  @override
  void onInit() {
    super.onInit();
    lottieController = AnimationController(
      vsync: this,
    );
    fetchCVoiceTodayData();
    _getDataSpecific();
    _getDataOverall();
    scrollController.addListener(_scrollListener);
    scrollController.addListener(_specificScrollListener);
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  void _getDataOverall() async {
    List<VoiceOverallData> listOfData = [];
    listOfData = await fetchData(
        url:
            "${ApiHelper.voiceOverallUrl}student_id=${LocalStorage.getValue('studentId')}&page=$_pageNo");
    overallList.clear();
    overallList.assignAll(listOfData);
    isLoading.value = false;
  }

  void _getDataSpecific() async {
    List<VoiceOverallData> listOfData = [];
    listOfData = await fetchData(
        url:
            "${ApiHelper.voiceSpecificUrl}student_id=${LocalStorage.getValue('studentId')}&page=$_pageNo");
    specificList.clear();
    specificList.assignAll(listOfData);
    isLoading.value = false;
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value =
          CustomVoiceLoadingState(loadingType: LoadingType.loading);
      try {
        List<VoiceOverallData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await fetchData(
            url:
                "${ApiHelper.voiceOverallUrl}student_id=${LocalStorage.getValue('studentId')}&page=${++_pageNo}");
        if (listOfData.isEmpty) {
          loadingState.value = CustomVoiceLoadingState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          overallList.addAll(listOfData);
          loadingState.value =
              CustomVoiceLoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value = CustomVoiceLoadingState(
            loadingType: LoadingType.error, error: err.toString());
      }
    }
  }


  void _specificScrollListener() async {
    if (specificScrollController.offset >= specificScrollController.position.maxScrollExtent &&
        !specificScrollController.position.outOfRange) {
      loadingState.value =
          CustomVoiceLoadingState(loadingType: LoadingType.loading);
      try {
        List<VoiceOverallData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await fetchData(
            url:
                "${ApiHelper.voiceSpecificUrl}student_id=${LocalStorage.getValue('studentId')}&page=${++_pageNo}");
        if (listOfData.isEmpty) {
          loadingState.value = CustomVoiceLoadingState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          overallList.addAll(listOfData);
          loadingState.value =
              CustomVoiceLoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value = CustomVoiceLoadingState(
            loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  Future<List<VoiceOverallData>> fetchData({String? url}) async {
    customModel.clear();
    try {
      final result = await BaseService().getMethod(url ?? "");
      if (result != null) {
        if (result.statusCode == 200) {
          VoiceOverallModel? voiceOverallModel =
              VoiceOverallModel.fromJson(result.data);
          customModel = voiceOverallModel.data ?? [];
        }
      }
    } catch (e) {
      print('Fetch  $e');
    }
    update();
    return customModel;
  }

  Future fetchCVoiceTodayData() async {
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.voiceUrl}student_id=${LocalStorage.getValue('studentId')}");
      if (result != null) {
        if (result.statusCode == 200) {
          VoiceTodayModel voiceTodayModel =
              VoiceTodayModel.fromJson(result.data);
          finalList = voiceTodayModel.data ?? [];
        }
      }
    } catch (e) {
      print(" voice $e");
    }
    update();
  }
}
