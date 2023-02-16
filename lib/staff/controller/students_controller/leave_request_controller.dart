import 'package:flutter/material.dart';
import 'package:flutter_projects/common/apihelper/api_helper.dart';
import 'package:flutter_projects/parent/view/dialogs/dialog_helper.dart';
import 'package:get/get.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../parent/model/custom_model.dart';
import '../../../../common/services/base_client.dart';
import '../../model/standard_students_list_model.dart';
import '../../model/student_leave_request_model.dart';
import 'package:flutter_projects/common/const/colors.dart';

class LeaveRequestController extends GetxController {
  final isLoading = false.obs;
  final loadingState = LoadingState(loadingType: LoadingType.stable).obs;
  ScrollController scrollController = ScrollController();
  int pageNo = 1;
  List<StudentStandardListData> studentsStandardListData = [];
  List<StudentStandardListData> filterStudentsStandardListData = [];
  RxInt studentsListSelectedIndex = 0.obs;
  RxInt studentsListSectionIndex = 0.obs;
  List<StudentsLeaveRequestData> leaveRequestList =
      <StudentsLeaveRequestData>[].obs;
  String updateLeaveTypeValue = "Pending";

  @override
  void onInit() {
    super.onInit();
    filterStudentsStandardListData.insert(
        0,
        StudentStandardListData(
            fullName: "Select ", section: [Section(fullName: "Std")]));
    scrollController.addListener(_scrollListener);
  }

  void updateStudentListValue(int index, int index1) {
    studentsListSelectedIndex.value = index;
    studentsListSectionIndex.value = index1;
    getData();
  }

  updateLeaveType(updatedValue) {
    updateLeaveTypeValue = updatedValue;
    update();
  }

  Future fetchStandardStudentsList() async {
    try {
      final result = await BaseService().getMethod(ApiHelper.staffStandardList);
      if (result != null) {
        if (result.statusCode == 200) {
          StaffStandardListModel staffStandardListModel =
              StaffStandardListModel.fromJson(result.data);
          studentsStandardListData =
              staffStandardListModel.studentsStandardListData ?? [];
          filterStudentsStandardListData.addAll(studentsStandardListData);
        }
      }
    } catch (e) {
      print('Standard Students List Status $e');
    } finally {}
    update();
  }

  void filterStandardStudentsResults(String query) {
    List<StudentStandardListData> filterList = [];
    filterList.addAll(filterStudentsStandardListData);
    if (query.isNotEmpty) {
      List<StudentStandardListData> listData = [];
      for (var item in filterList) {
        if (item.fullName
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item.section![0].fullName
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
          listData.add(item);
        }
      }
      filterStudentsStandardListData.clear();
      filterStudentsStandardListData.addAll(listData);
    }
    update();
  }

  Future<List<StudentsLeaveRequestData>> fetchData({String? url}) async {
    List<StudentsLeaveRequestData> requestData = [];
    try {
      final result = await BaseService().getMethod(url ?? "");
      if (result != null) {
        if (result.statusCode == 200) {
          StudentLeaveRequestModel studentsListModel =
              StudentLeaveRequestModel.fromJson(result.data);
          requestData = studentsListModel.leaveRequestData ?? [];
        }
      }
    } catch (e) {
      print('Fetch Students List $e');
    }
    return requestData;
  }

  void getData() async {
    if (pageNo == 1) {
      isLoading.value = true;
    }
    leaveRequestList = [];
    List<StudentsLeaveRequestData> listOfData = [];
    listOfData = await fetchData(
        url:
            "${ApiHelper.studentsAttendanceLeaveRequestListUrl}?standard_id=${filterStudentsStandardListData[studentsListSelectedIndex.value].section?[studentsListSectionIndex.value].standardId ?? 0}&group_section_id=${filterStudentsStandardListData[studentsListSelectedIndex.value].section?[studentsListSectionIndex.value].id ?? 0}&page=$pageNo");
    leaveRequestList.clear();
    leaveRequestList.assignAll(listOfData);
    isLoading.value = false;
  }

  void _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadingState.value = LoadingState(loadingType: LoadingType.loading);
      try {
        List<StudentsLeaveRequestData> listOfData = [];
        await Future.delayed(const Duration(seconds: 3));
        listOfData = await fetchData(
            url:
                "${ApiHelper.studentsAttendanceLeaveRequestListUrl}?standard_id=${filterStudentsStandardListData[studentsListSelectedIndex.value].section?[studentsListSectionIndex.value].standardId ?? 0}&group_section_id=${filterStudentsStandardListData[studentsListSelectedIndex.value].section?[studentsListSectionIndex.value].id ?? 0}&page=${++pageNo}");
        if (listOfData.isEmpty) {
          loadingState.value =
              LoadingState(loadingType: LoadingType.completed, completed: "");
        } else {
          leaveRequestList.addAll(listOfData);
          loadingState.value = LoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            LoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
    update();
  }

  Future editLeaveRequest(Map<String, dynamic> mapData) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService()
          .postMethod(mapData, ApiHelper.leaveRequestEditUrl);
      if (result != null) {
        if (result.statusCode == 200) {
          Get.snackbar("","updated" ,snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
        //  showToastMsg("Updated");
          getData();
          Get.back();
        }
      }
    } catch (e) {
      print('Fetch Students List $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }
}
