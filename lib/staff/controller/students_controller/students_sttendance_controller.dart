import 'package:flutter/material.dart';
import 'package:flutter_projects/common/apihelper/api_helper.dart';
import 'package:flutter_projects/parent/view/dialogs/dialog_helper.dart';
import 'package:get/get.dart';
import '../../../common/const/colors.dart';
import '../../../../common/services/base_client.dart';
import '../../model/standard_students_list_model.dart';
import '../../model/students_attendance_list_model.dart';

class StudentsAttendanceController extends GetxController {
  bool isLoading = false;
  int studentsListSelectedIndex = 0;
  int studentsListSectionIndex = 0;
  List<StudentStandardListData> studentsStandardListData = [];
  List<StudentStandardListData> filterStudentsStandardListData = [];
  List<StudentsAttendanceData> studentsAttendanceList = [];
  List<StudentsAttendanceData> newAttendanceList = [];
  int standardId = 0;
  int? remarkClicked = 0;
  int groupSectionId = 0;
  DateTime currentDate = DateTime.now();
  String selectedDate = "";
  String selectedTime = "ENTER TIME";

  @override
  void onInit() {
    super.onInit();
    filterStudentsStandardListData.insert(
        0,
        StudentStandardListData(
            fullName: "Select ", section: [Section(fullName: "Std")]));
  }

  void updateStudentListValue(int index, int index1) {
    studentsListSelectedIndex = index;
    studentsListSectionIndex = index1;
    update();
  }

  void clearData() {
    selectedDate = "Click to select";
    filterStudentsStandardListData.insert(
        0,
        StudentStandardListData(
            fullName: "Select ", section: [Section(fullName: "Std")]));
    studentsAttendanceList = [];
    update(["new"]);
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

  updateFlagInitState() {
    if (studentsAttendanceList.isNotEmpty) {
      for (int i = 0; i < studentsAttendanceList.length; i++) {
        if (studentsAttendanceList[i].attendance != null &&
            studentsAttendanceList[i].attendance!.leaveTypeId != null) {
          studentsAttendanceList[i].flag =
              studentsAttendanceList[i].attendance?.leaveTypeId ?? 1;
        } else {
          studentsAttendanceList[i].flag = 1;
        }
        if (studentsAttendanceList[i].attendance != null &&
            studentsAttendanceList[i].attendance!.lateTime != null) {
          studentsAttendanceList[i].time =
              studentsAttendanceList[i].attendance?.lateTime ?? "";
        } else {
          studentsAttendanceList[i].time = "ENTER TIME";
        }
      }
    }
    update();
  }

  Future fetchStudentsAttendanceData() async {
    isLoading = true;
    studentsAttendanceList = [];
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.singleDayStudentAttendanceListUrl}?standard_id=$standardId&group_section_id=$groupSectionId&date=$selectedDate");
      if (result != null) {
        if (result.statusCode == 200) {
          isLoading = false;
          StudentsAttendanceListModel studentsAttendanceListModel =
              StudentsAttendanceListModel.fromJson(result.data);
          studentsAttendanceList =
              studentsAttendanceListModel.studentsAttendanceData ?? [];
          updateFlagInitState();
        }
      }
    } catch (e) {
      print('Fetch Students Attendance List $e');
    } finally {
      isLoading = false;
    }
    update();
  }

  Future fetchNewAttendanceData(Map<String, dynamic> mapData) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService().postWithoutFormData(
          mapData, ApiHelper.singleDayStudentsAttendanceSubmitUrl);
      if (result != null) {
        if (result.statusCode == 200) {
          Get.snackbar("","updated" ,snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
         // showToastMsg("Updated");
          // StudentsAttendanceListModel studentsAttendanceListModel =
          //     StudentsAttendanceListModel.fromJson(result.data);
          // newAttendanceList =
          //     studentsAttendanceListModel.studentsAttendanceData ?? [];
          // fetchStudentsAttendanceData(false);
        } else {
          Get.snackbar("","Not updated" ,snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
         // showToastMsg("Not Updated");
        }
      }
    } catch (e) {
      print('Fetch Students Attendance List $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1800),
        lastDate: DateTime(3000),
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
      update();
    }
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

  Future<void> displayTimeDialog() async {
    final TimeOfDay? time = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
        helpText: "Select Late Comer Time",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.darkPinkColor, // <-- SEE HERE
                onPrimary: AppColors.whiteColor,
              ),
            ),
            child: child!,
          );
        });
    if (time != null) {
      selectedTime = time.format(Get.context!);
    }
    update();
  }
}

class RadioButtonsModel {
  String title;

  RadioButtonsModel({required this.title});
}
