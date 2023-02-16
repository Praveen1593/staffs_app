import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/apihelper/api_helper.dart';
import '../../../../common/enums/loading_enums.dart';
import '../../../../common/common_controller/base_controller.dart';
import '../../../model/class_test_model.dart';
import '../../../model/class_test_past_model.dart';
import '../../../model/custom_classTest_model.dart';
import '../../../model/custom_class_test_today_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../view/dialogs/dialog_helper.dart';
import '../../../../storage.dart';

class ClassTestController extends BaseController with GetSingleTickerProviderStateMixin {
  DateTime currentDate = DateTime.now();
  String startDate = "";
  String endDate = "";
  List combineListData = [];
  List<CustomClassTestModel> customModel = [];
  List<CustomClassTestTodayModel> customTodayModel = [];
  // List<String> customTodayModelAttach = [];
  ClassTestModel? classTestModel;
  List<CustomClassTestModel> finalList = <CustomClassTestModel>[].obs;
  List<CustomClassTestModel> finalList1 = <CustomClassTestModel>[].obs;
  List dateList = [];
  List todayDateList = [];
  final arguments = Get.arguments;
  String selectedDate = "";
  ScrollController scrollController = ScrollController();
  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState = CustomClassTestLoadingState(loadingType: LoadingType.stable).obs;
  bool? reportSelectedVal;
  late AnimationController lottieController;
  int dateSelectedFlag = 0;
  int currentTab = 0;

  @override
  void onInit() {
    super.onInit();
    lottieController = AnimationController(
      vsync: this,
    );
    fetchClassTestTodayData();
    _getData();
    scrollController.addListener(_scrollListener);
  }

  /*@override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }*/

  void _getData() async {
    List<CustomClassTestModel> listOfData = [];
    listOfData = await fetchData(
        url:
            "${ApiHelper.classTestPastUrl}student_id=${LocalStorage.getValue('studentId')}&page=$_pageNo");
    finalList.clear();
    finalList.assignAll(listOfData);
    isLoading.value = false;
  }

  //Past
  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value =
          CustomClassTestLoadingState(loadingType: LoadingType.loading);
      try {
        List<CustomClassTestModel> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await fetchData(
            url:
                "${ApiHelper.classTestPastUrl}student_id=${LocalStorage.getValue('studentId')}&page=${++_pageNo}");
        if (listOfData.isEmpty) {
          loadingState.value = CustomClassTestLoadingState(
              loadingType: LoadingType.completed,
              completed: "");
        } else {
          finalList.addAll(listOfData);
          loadingState.value =
              CustomClassTestLoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value = CustomClassTestLoadingState(
            loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  updateTabIndex(int index) {
    currentTab = index;
    if(currentTab==2){
      dateSelectedFlag = 0;
    }
    update();
  }

  Future<List<CustomClassTestModel>> fetchData({String? url}) async {
    customModel = [];
    dateList = [];
    try {
      final result = await BaseService().getMethod(url ?? "");
      if (result != null) {
        if (result.statusCode == 200) {
          ClassTestPastModel classTestPast =
          ClassTestPastModel.fromJson(result.data);
          List<ClassTestPastData> classTestPastData = classTestPast.data;
          if (classTestPastData.isNotEmpty) {
            for (int i = 0; i < classTestPastData.length; i++) {
              if(classTestPastData[i].subject!.isNotEmpty){
                dateList.add(classTestPastData[i].date);
              }
            }
            LinkedHashSet set = LinkedHashSet();
            set.addAll(dateList);
            dateList.clear();
            dateList.addAll(set);
            for (int i = 0; i < dateList.length; i++) {
              if(classTestPastData[i].subject!.isNotEmpty){
                customModel.add(CustomClassTestModel(dateList[i], -1, null));
                for (int j = 0; j < classTestPastData.length; j++) {
                  if (classTestPastData[j].date == dateList[i]) {
                    for (int k = 0; k < classTestPastData[j].subject!.length; k++) {
                      if(classTestPastData[j].subject!=null&&classTestPastData[j].subject!.isNotEmpty) {
                        customModel.add(CustomClassTestModel(
                            "", 1, classTestPastData[j].subject![k]));
                      }
                    }
                  }
                }
              }

            }
          } else {
            customModel = [];
            dateList = [];
          }
        }
      }
    } catch (e) {
      print('Fetch News / Circular / Event  $e');
    }
    update();
    return customModel;
  }

  void reportUpdate(bool selectedValue) {
    reportSelectedVal = selectedValue;
    update();
  }



  //Today
  Future fetchClassTestTodayData() async {
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.classTestUrl}student_id=${LocalStorage.getValue("studentId")}");
      if (result != null) {
        if (result.statusCode == 200) {
          classTestModel = ClassTestModel.fromJson(result.data);
          List<ClassTestTodayData>? classTestTodayData = classTestModel!.data;
          if (classTestTodayData!=null&&classTestTodayData.isNotEmpty) {
            for (int i = 0; i < classTestTodayData.length; i++) {
              if(classTestTodayData[i].subject!.isNotEmpty){
                todayDateList.add(classTestTodayData[i].date);
              }
            }
            if(todayDateList.isNotEmpty){
              LinkedHashSet set = LinkedHashSet();
              set.addAll(todayDateList);
              todayDateList.clear();
              todayDateList.addAll(set);
              for (int i = 0; i < todayDateList.length; i++) {
                customTodayModel.add(CustomClassTestTodayModel(todayDateList[i], -1, null));
                for (int j = 0; j < classTestTodayData.length; j++) {
                  if (classTestTodayData[j].date == todayDateList[i]) {
                    for (int k = 0; k < classTestTodayData[j].subject!.length; k++) {
                      if(classTestTodayData[j].subject!=null&&classTestTodayData[j].subject!.isNotEmpty) {
                        customTodayModel.add(CustomClassTestTodayModel(
                            "", 1, classTestTodayData[j].subject![k]));

                      }
                   /*   customTodayModelAttach.clear();
                      for (int l = 0; l < classTestTodayData[j].subject![k].attachFile!.length; l++) {
                        customTodayModelAttach.add(classTestTodayData[j].subject![k].attachFile![l].attachFile??"");
                      }*/

                    }
                  }
                }
              }
            }
          } else {
            customTodayModel = [];
            todayDateList = [];
          }
        }
      }
    } catch (e) {
      print('Class Test  $e');
    }
    update();
  }

  clearData(){
    startDate = "";
    endDate ="";
    selectedDate = "";
  }

  //Report
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050),
        currentDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.darkPinkColor, // <-- SEE HERE
                onPrimary: AppColors.whiteColor, // <-- SEE HERE
                surface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        });
    if (pickedDate != null) {
      currentDate = pickedDate;
      selectedDate = currentDate.toString().split(' ')[0];
      print("selectedDate : $selectedDate");
     // reportUpdate(false);
      finalList1.clear();
      sendSingleDay(1, selectedDate);
      update();
    }
  }

  Future<void> dateRangeDialog(BuildContext context) async {
    DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000, 1, 1),
        lastDate: DateTime(2070, 12, 31),
        currentDate: DateTime.now(),
        saveText: 'SAVE',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme:  const ColorScheme.light(
                primary: AppColors.darkPinkColor, // <-- SEE HERE
                onPrimary: AppColors.whiteColor, // <-- SEE HERE
                surface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        });
    if (result != null) {
      startDate = result.start.toString().split(' ')[0];
      endDate = result.end.toString().split(' ')[0];
      //reportUpdate(false);
      finalList1.clear();
      sendMultipleDays(startDate, endDate, 2);
      update();
    }
  }

  Future sendMultipleDays(
      String startingDate, String endingDate, int type) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.classTestReportUrl}student_id=${LocalStorage.getValue('studentId')}&type=$type&start_date=$startingDate&end_date=$endingDate");
      if (result != null) {
        if (result.statusCode == 200) {
         // reportUpdate(true);
          reportDataProcess(result);
        }
      }
    } catch (e) {
      print('Multiple Days Selection in Circular / Event / News  $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  Future sendSingleDay(int type, String startingDate) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.classTestReportUrl}student_id=${LocalStorage.getValue('studentId')}&type=$type&start_date=$startingDate");
      if (result != null) {
        if (result.statusCode == 200) {
         // reportUpdate(true);
          print('Report status ${result.statusCode}');
          reportDataProcess(result);
         // dateSelectedFlag = 1;

        }
      }
    } catch (e) {
      print('Single Day Selection in Circular / Event / News  $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  void reportDataProcess(dynamic result) {
    List<CustomClassTestModel> customReportModel = [];
    List reportDateList = [];
    ClassTestPastModel classTestPast = ClassTestPastModel.fromJson(result.data);
    List<ClassTestPastData> classTestPastData = classTestPast.data;
    if (classTestPastData.isNotEmpty) {
      for (int i = 0; i < classTestPastData.length; i++) {
        reportDateList.add(classTestPastData[i].date);
      }
      LinkedHashSet set = LinkedHashSet();
      set.addAll(reportDateList);
      reportDateList.clear();
      reportDateList.addAll(set);
      for (int i = 0; i < reportDateList.length; i++) {
        customReportModel
            .add(CustomClassTestModel(reportDateList[i], -1, null));
        for (int j = 0; j < classTestPastData.length; j++) {
          if (classTestPastData[j].date == reportDateList[i]) {
            for (int k = 0; k < classTestPastData[j].subject!.length; k++) {
              if(classTestPastData[j].subject!=null&&classTestPastData[j].subject!.isNotEmpty) {
                customReportModel.add(CustomClassTestModel(
                  "", 1, classTestPastData[j].subject![k]));
              }
           /*   customTodayModelAttach.clear();
              for (int l = 0; l < classTestPastData[j].subject![k].attachFile!.length; l++) {
                customTodayModelAttach.add(classTestPastData[j].subject![k].attachFile![l].attachFile??"");
              }*/
            }
          }
        }
      }
      finalList1.clear();
      finalList1.assignAll(customReportModel);
    } else {
      customReportModel = [];
      finalList1.clear();
      finalList1.assignAll(customReportModel);
      reportDateList = [];
      print("Report Data Empty");
     // dateSelectedFlag = 1;
    }
  }
}
