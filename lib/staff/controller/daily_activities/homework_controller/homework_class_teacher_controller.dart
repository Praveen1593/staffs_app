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
import '../../../model/StaffAddHomeworkResponce.dart';
import '../../../model/StaffHomeworkReplyList.dart';
import '../../../model/StaffHomeworkStaffReplyResponce.dart';
import '../../../model/StaffHomeworkStudentReplyList.dart';
import '../../../view/screens/staff_dailly_activities/staff_home_work/staff_homework_add_entry_screen.dart';
import '../../../view/screens/staff_dailly_activities/staff_home_work/staff_homework_class_teacher_view_screen.dart';

class StaffClassTeacherHomeworkController extends GetxController {
  int currentIndex = 0;
  DateTime? currentDate;
  String? selectedDate;
  String? startDate;
  String? endDate;
  List<Widget> list = [
    BuildTodayBody(),
    BuildReplyBody(),
  ];
  TextEditingController titleEditController = TextEditingController();
  TextEditingController descriptionEditController = TextEditingController();
  TextEditingController staffReplyEditController = TextEditingController();
  ClassTeacherStandardListModel? cTStandardList;
  ClassTeacherViewHomeworkModel? classTeacherViewHomeworkModel;
  List<ClassTeacherViewHomeworkData>? classTeacherViewHomeworkData;
  String? selectedStdTxt = "Select Standard";
  int? selectedStdValue = 0;
  int? selectedSectionValue = 0;
  BasicSettingsmodel? basicSettingsmodel;
  StaffAddHomeworkResponce? staffAddHomeworkResponce;
  StaffHomeworkReplyList? staffHomeworkReplyList;
  List<ReplyListData>? replyListData;
  StaffHomeworkStudentReplyList? staffHomeworkStudentReplyList;
  List<StudentReplyList>? studentReplyList;
  int? permissionChecked = 0;
  int? radiotype = 2;
  int? replyId;
  bool multiReplySelect = false;
  bool overallReplySelect = false;
  StaffHomeworkStaffReplyResponce? staffHomeworkStaffReplyResponce;
  List<int>? staffReplyEntryList = [];
  List<int> staffReplyEntryList1 = [];
  List<StudentReplyList> studentMultiReplyDataList = [];
  List<int> dummyList = [];
  XFile? image;
  List<StaffHomeworkAttachment> filesList = <StaffHomeworkAttachment>[].obs;
  ImagePicker picker = ImagePicker();
  List<dynamic>? attachmentList = [];

  @override
  void onInit() {
    super.onInit();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    cTStandardListData();
  }

  //Today
  void permissionUpdate(int value) {
    radiotype = value;
    if (value == 1) {
      permissionChecked = 1;
    } else if (value == 2) {
      permissionChecked = 0;
    }
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

  void updateIndex(int index) {
    currentIndex = index;
    update();
  }

  Future<StaffAddHomeworkResponce?> homeworkSubmit(
      Map<String, dynamic> userData, int hwId) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService().postMethod(
          userData, "${ApiHelper.todayHomeworkSubmitUrl}$hwId");
      if (result != null) {
        if (result.statusCode == 200) {
          staffAddHomeworkResponce =
              StaffAddHomeworkResponce.fromJson(result.data);
        }
      }
    } catch (e) {
      print('staffAddHomeworkResponce $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return staffAddHomeworkResponce;
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

  void selectedStandardUpdate(String std, int stdvalue, int secValue) {
    selectedStdTxt = std;
    selectedStdValue = stdvalue;
    selectedSectionValue = secValue;
    update();
  }

  Future viewHomeworkData() async {
    showLoadingDialog(Get.context!);
    final result = await BaseService().getMethod(
        "${ApiHelper.classTeacherOverallTodayUrl}date=${startDate}&standard_id=$selectedStdValue&group_section_id=$selectedSectionValue&homework=1");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          classTeacherViewHomeworkModel =
              ClassTeacherViewHomeworkModel.fromJson(result.data);
          classTeacherViewHomeworkData = classTeacherViewHomeworkModel?.data;
        }
      }
    } catch (e) {
      print("classTeacherViewHomeworkModel $e");
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  Future<int> cTStandardListData() async {
    final result =
        await BaseService().getMethod("${ApiHelper.classTeacherListUrl}");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          cTStandardList = ClassTeacherStandardListModel.fromJson(result.data);
        }
      }
    } catch (e) {
      print("Leave list $e");
    } finally {}
    update();
    return result.statusCode;
  }

  //Reply

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

  Future<int> imageDelete(Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    dynamic result;
    try {
      result = await BaseService()
          .postMethod(userData, "${ApiHelper.homeworkImageDeleteUrl}");
      if (result != null) {
        if (result.statusCode == 200) {
        } else {
          print('staffReplySubmit: ${result.statusCode}');
        }
      }
    } catch (e) {
      print('staffReplySubmit $e');
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
          print('staffReplySubmit: ${result.statusCode}');
        } else {
          print('staffReplySubmit: ${result.statusCode}');
        }
      }
    } catch (e) {
      print('staffReplySubmit $e');
    } finally {}
    update();
    return staffHomeworkStaffReplyResponce;
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

  Future<int> studentReplyData() async {
    final result = await BaseService()
        .getMethod("${ApiHelper.homeworkReplyUrl}/$replyId");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          staffHomeworkStudentReplyList =
              StaffHomeworkStudentReplyList.fromJson(result.data);
          studentReplyList = staffHomeworkStudentReplyList?.data;
        } else {
          print("studentReplyData : ${result.statusCode}");
        }
      }
    } catch (e) {
      print("studentReplyData $e");
    }
    update();
    return result.statusCode;
  }

  Future replyHomeworkData() async {
    final result = await BaseService().getMethod(
        "${ApiHelper.homeworkReplyUrl}?start_date=$startDate&end_date=$endDate&standard_id=$selectedStdValue&group_section_id=$selectedSectionValue");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          staffHomeworkReplyList = StaffHomeworkReplyList.fromJson(result.data);
          replyListData = staffHomeworkReplyList?.data;
        } else {
          print("classTeacherViewHomeworkModel : ${result.statusCode}");
        }
      }
    } catch (e) {
      print("classTeacherViewHomeworkModel $e");
    }
    update();
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

  removeItem(int index) {
    filesList.removeAt(index);
    update();
  }
}
