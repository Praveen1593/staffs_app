import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/common/apihelper/api_helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../common/const/colors.dart';
import '../../../../common/services/base_client.dart';
import '../../../../parent/view/dialogs/dialog_helper.dart';
import '../../../model/BasicSettingsModel.dart';
import '../../../model/ClassTeacherStandardListModel.dart';
import '../../../model/ClassTeacherViewHomeworkModel.dart';
import '../../../model/CustomSubjectTeacherStdListModel.dart';
import '../../../model/StaffAddHomeworkResponce.dart';
import '../../../model/StaffHomeworkReplyList.dart';
import '../../../model/StaffHomeworkStaffReplyResponce.dart';
import '../../../model/StaffHomeworkStudentReplyList.dart';
import '../../../model/SubjectTeacherStandardListModel.dart';
import '../../../view/screens/staff_dailly_activities/staff_home_work/staff_homework_add_entry_screen.dart';
import '../../../view/screens/staff_dailly_activities/staff_home_work/staff_homework_view_screen.dart';

class StaffHomeworkController extends GetxController with GetSingleTickerProviderStateMixin {
  int currentIndex = 0;
  DateTime? currentDate;
  String? selectedDate;
  String? startDate;
  String? endDate;
  int? ratingValue = 0;
  List<Widget> list = [
    BuildTodayBody(),
    BuildReplyBody(),
    BuildReportBody(),
  ];
  XFile? image;
  List<StaffHomeworkAttachment> filesList = <StaffHomeworkAttachment>[].obs;
  TextEditingController titleEditController = TextEditingController();
  TextEditingController descriptionEditController = TextEditingController();
  TextEditingController staffReplyEditController = TextEditingController();
  ClassTeacherStandardListModel? cTStandardList;
  StaffHomeworkReplyList? staffHomeworkReplyList;
  List<ReplyListData>? replyListData;
  StaffHomeworkStaffReplyResponce? staffHomeworkStaffReplyResponce;
  int? replyId;
  bool multiReplySelect = false;
  bool overallReplySelect = false;
  List<StudentReplyList> studentMultiReplyDataList = [];
  List<int>? staffReplyEntryList = [];
  List<int> staffReplyEntryList1 = [];
  StaffHomeworkStudentReplyList? staffHomeworkStudentReplyList;
  List<StudentReplyList>? studentReplyList;
  String? selectedStdTxt = "Select Standard";
  int? selectedStdValue = 0;
  int? selectedSectionValue = 0;
  BasicSettingsmodel? basicSettingsmodel;

  SubjectTeacherStandardListModel? subjectTeacherStandardListModel;
  List<CustomSubjectTeacherStdListModel> stdList = [];
  int subSelectFlag = 0;
  int? radiotype = 2;
  ClassTeacherViewHomeworkModel? subjectTeacherViewHomeworkModel;
  List<ClassTeacherViewHomeworkData>? subjectTeacherViewHomeworkData;
  List<dynamic>? attachmentList = [];
  int? permissionChecked = 0;
  StaffAddHomeworkResponce? staffAddHomeworkResponce;
  ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    cTStandardListData();
    viewHomeworkData();
  }

  Future filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path.toString());
      String filename = file.path.split('/').last;
      filesList.add(StaffHomeworkAttachment(file: file, fileName: filename));
    }

    update();
  }

  Future captureImage() async {
    image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    String filename = image!.path.split('/').last;
    filesList.add(StaffHomeworkAttachment(
        file: File(image!.path.toString()), fileName: filename));
    update();
  }

  Future sendHomeworkSubmission(
      {required int homeworkId,
      required String homeworkTitle,
      required String homeworkDate,
      required int sectionSubjectItemId,
      required String hwDesc,
      required int approvalType,
      required int staffHomeworkApprovalType,
      required List<StaffHomeworkAttachment> filesList,
      required String url}) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService().uploadStaffMultipleFiles(
          filesList: filesList,
          url: url,
          homeworkId: homeworkId,
          homeworkTitle: homeworkTitle,
          homeworkDate: homeworkDate,
          sectionSubjectItemId: sectionSubjectItemId,
          hwDesc: hwDesc,
          approvalType: approvalType,
          staffHomeworkApprovalType: staffHomeworkApprovalType);
      if (result != null) {
        if (result.statusCode == 200) {
          staffAddHomeworkResponce =
              StaffAddHomeworkResponce.fromJson(result.data);
          Get.back();
          viewHomeworkData();
        } else {}
      }
    } catch (e) {
      print('Homework Submission Screen  $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  Future<int> imageDelete(Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    dynamic result;
    try {
      result = await BaseService()
          .postMethod(userData, "${ApiHelper.homeworkImageDeleteUrl}");
      if (result != null) {
        if (result.statusCode == 200) {}
      }
    } catch (e) {
      print('staffReplySubmit $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return result.statusCode;
  }

  void permissionUpdate(int value) {
    radiotype = value;
    if (value == 1) {
      permissionChecked = 1;
    } else if (value == 2) {
      permissionChecked = 0;
    }
    print("permissionChecked : $permissionChecked");
    update();
  }

  removeItem(int index) {
    filesList.removeAt(index);
    update();
  }

  Future<int> checkSettings() async {
    showLoadingDialog(Get.context!);
    final result =
        await BaseService().getMethod("${ApiHelper.settingUrl}");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          basicSettingsmodel = BasicSettingsmodel.fromJson(result.data);
        }
      }
    } catch (e) {
      print("checkSettings $e");
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return result.statusCode;
  }

  Future viewHomeworkData() async {
    final result = await BaseService().getMethod(
        "${ApiHelper.overallTodayUrl}date=$selectedDate&homework=0");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          subjectTeacherViewHomeworkModel =
              ClassTeacherViewHomeworkModel.fromJson(result.data);
          subjectTeacherViewHomeworkData =
              subjectTeacherViewHomeworkModel?.data;
        }
      }
    } catch (e) {
      print("classTeacherViewHomeworkModel $e");
    } finally {}
    update();
  }

  void updateReplySelection(int type) {
    if (type == 1) {
      multiReplySelect = true;
      overallReplySelect = false;
    } else {
      overallReplySelect = true;
      multiReplySelect = false;
    }
    update();
  }

  Future<int> staffReplyMultiSubmit(
      Map<String, dynamic> userData, int hwId) async {
    showLoadingDialog(Get.context!);
    dynamic result;
    try {
      result = await BaseService().postWithoutFormData(
          userData, "${ApiHelper.multiStaffReplyUrl}$hwId");
      if (result != null) {
        if (result.statusCode == 200) {
          StaffHomeworkStudentReplyList homeworkReplyModel =
              StaffHomeworkStudentReplyList.fromJson(result.data);
          studentMultiReplyDataList = homeworkReplyModel.data ?? [];
        }
      }
    } catch (e) {
      print('staffReplyMultiSubmit $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return result.statusCode;
  }

  Future<StaffHomeworkStaffReplyResponce?> staffReplySingleSubmit(
      Map<String, dynamic> userData, int hwId) async {
    try {
      final result = await BaseService()
          .postMethod(userData, "${ApiHelper.singleStaffReplyUrl}$hwId");
      if (result != null) {
        if (result.statusCode == 200) {
          staffHomeworkStaffReplyResponce =
              StaffHomeworkStaffReplyResponce.fromJson(result.data);
        }
      }
    } catch (e) {
      print('staffReplySubmit $e');
    }
    update();
    return staffHomeworkStaffReplyResponce;
  }

  void selectedStandardUpdate(String std, int stdvalue, int secValue) {
    selectedStdTxt = std;
    selectedStdValue = stdvalue;
    selectedSectionValue = secValue;
    update();
  }

  Future<int> studentReplyData() async {
    final result = await BaseService()
        .getMethod("${ApiHelper.homeworkReplyUrl}/$replyId");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          staffHomeworkStudentReplyList =
              StaffHomeworkStudentReplyList.fromJson(result.data);
          studentReplyList = staffHomeworkStudentReplyList?.data;
        }
      }
    } catch (e) {
      print("studentReplyData $e");
    }
    update();
    return result.statusCode;
  }

  void multipleReplyCheckboxUpdate(int studentReplyId, bool isCheck) {
    if (isCheck) {
      staffReplyEntryList1.add(studentReplyId);
    }
    if (isCheck == false) {
      if (staffReplyEntryList1.isNotEmpty) {
        for (int i = 0; i < staffReplyEntryList1.length; i++) {
          if (staffReplyEntryList1[i].isEqual(studentReplyId)) {
            staffReplyEntryList1.remove(staffReplyEntryList1[i]);
          }
        }
      }
    }
    update();
  }

  void updateIndex(int index) {
    currentIndex = index;
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    selectedStdTxt = "Select Standard";
    selectedStdValue = 0;
    selectedSectionValue = 0;
    replyListData?.clear();
    subSelectFlag = 0;
    update();
  }

  Future cTStandardListData() async {
    final result = await BaseService()
        .getMethod(ApiHelper.subjectTeacherStndardList);
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          subjectTeacherStandardListModel =
              SubjectTeacherStandardListModel.fromJson(result.data);
          stdList.clear();
          for (int i = 0;
              i < subjectTeacherStandardListModel!.data!.length;
              i++) {
            for (int j = 0;
                j < subjectTeacherStandardListModel!.data![i].section!.length;
                j++) {
              stdList.add(CustomSubjectTeacherStdListModel(
                  subjectTeacherStandardListModel!
                          .data![i].section![j].standardId ??
                      0,
                  subjectTeacherStandardListModel!.data![i].section![j].id ?? 0,
                  "${subjectTeacherStandardListModel!.data![i].name} - ${subjectTeacherStandardListModel!.data![i].section![j].name}"));
            }
          }
        } else {
          print("Leave list : ${result.statusCode}");
        }
      }
    } catch (e) {
      print("Leave list $e");
    }
    update();
  }

  Future<DateTime?> selectDate(BuildContext context, int type) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate ?? DateTime.now(),
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
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
      if (type == 1) {
        startDate =
            DateFormat('yyyy-MM-dd').format(currentDate ?? DateTime.now());
      } else if (type == 2) {
        endDate =
            DateFormat('yyyy-MM-dd').format(currentDate ?? DateTime.now());
      } else {
        selectedDate =
            DateFormat('yyyy-MM-dd').format(currentDate ?? DateTime.now());
      }

      update();
      return currentDate;
    }
  }

  Future replyHomeworkData() async {
    showLoadingDialog(Get.context!);
    final result = await BaseService().getMethod(
        "${ApiHelper.homeworkReplyUrl}?start_date=$startDate&end_date=$endDate&standard_id=$selectedStdValue&group_section_id=$selectedSectionValue");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          staffHomeworkReplyList = StaffHomeworkReplyList.fromJson(result.data);
          replyListData = staffHomeworkReplyList?.data;
        }
      }
    } catch (e) {
      print("classTeacherViewHomeworkModel $e");
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }
}
