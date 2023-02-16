import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../common/apihelper/api_helper.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/services/base_client.dart';
import '../../../../parent/view/dialogs/dialog_helper.dart';
import '../../../model/BasicSettingsModel.dart';
import '../../../model/ClassTestAddResponce.dart';
import '../../../model/ClassTestReplyListModel.dart';
import '../../../model/ClassTestStdSubjectModel.dart';
import '../../../model/Classtest_ST_ViewModel.dart';
import '../../../model/CustomStdSubjectListModel.dart';
import '../../../model/CustomSubjectTeacherStdListModel.dart';
import '../../../model/StudentResultDetailsModel.dart';
import '../../../model/SubjectTeacherStandardListModel.dart';
import '../../../view/screens/staff_dailly_activities/staff_classtest/staff_classtest_add_entry_screen.dart';
import '../../../view/screens/staff_dailly_activities/staff_classtest/staff_classtest_view_screen.dart';

class StaffClasstestController extends GetxController {
  int currentIndex = 0;
  int? radiotype = 2;
  int? permissionChecked = 0;
  DateTime? currentDate;
  String? selectedDate;
  String? startDate;
  String? endDate;
  bool? absentClicked = false;
  List<Widget> list = [
    BuildTodayBody(),
    BuildReplyBody(),
    BuildReportBody(),
  ];
  String? selectedStdTxt = "Select Standard";
  int? selectedStdValue = 0;
  int? selectedSectionValue = 0;
  int? stdSubjectId = 0;
  int subSelectFlag = 0;
  XFile? image;
  int? studentResultDetailsFetchId;
  TextEditingController titleEditController = TextEditingController();
  TextEditingController descriptionEditController = TextEditingController();
  TextEditingController maxMarkEditController = TextEditingController();
  TextEditingController markEditController = TextEditingController();
  /*View*/
  ClassTestStViewModel? classTestSTViewModel;
  List<ClassTestViewData>? classTestViewData;
  /*Settings*/
  BasicSettingsmodel? basicSettingsModel;
  ClassTestAddResponce? classTestAddResponse;
  SubjectTeacherStandardListModel? subjectTeacherStandardListModel;
  String? resultTitleTxt;
  String? resultDescriptionTxt;
  StudentResultDetailsModel? studentResultDetailsModel;

  List<StaffClassTestAttachment> filesList = <StaffClassTestAttachment>[].obs;
  List<dynamic>? attachmentList = [];
  ImagePicker picker = ImagePicker();
  int? selectType;
  List<CustomSubjectTeacherStdListModel> stdList = [];
  ClassTestReplyListModel? classTestReplyListModel;
  List<ClassTestReplyListData>? classTestReplyListData;
  ClassTestStdSubjectModel? classTestStdSubjectModel;
  List<CustomStdSubjectListModel> stdSubject = [];
  List<StudentList>? studentList = [];

  @override
  void onInit() {
    super.onInit();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    standardListData();
    viewClassTestData();
  }

  void absentUpdate(bool value, int index) {
    if (value) {
      studentList?[index].classTestResult?.absent = 1;
      studentList?[index].classTestResult?.absentRef = "Absent marked";

    } else {
      studentList?[index].classTestResult?.absent = 0;
      studentList?[index].classTestResult?.absentRef = "Mark";
    }
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    maxMarkEditController.clear();
    markEditController.clear();
    titleEditController.clear();
    descriptionEditController.clear();
  }

  Future standardListData() async {
    final result = await BaseService().getMethod(
        "https://test.schoolec.in/api/staff/v2/subject-teacher-standard-list");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          print("standardListData: ${result.statusCode}");
          subjectTeacherStandardListModel =
              SubjectTeacherStandardListModel.fromJson(result.data);
          stdList.clear();
          for (int i = 0; i < subjectTeacherStandardListModel!.data!.length; i++) {
            for (int j = 0; j < subjectTeacherStandardListModel!.data![i].section!.length; j++) {
              stdList.add(CustomSubjectTeacherStdListModel(
                  subjectTeacherStandardListModel!.data![i].section![j].standardId ??
                      0,
                  subjectTeacherStandardListModel!.data![i].section![j].id ?? 0,
                  "${subjectTeacherStandardListModel!.data![i].name} - ${subjectTeacherStandardListModel!.data![i].section![j].name}"));
            }
          }
        } else {
          print("standardListData: ${result.statusCode}");
        }
      }
    } catch (e) {
      print("standardListData $e");
    }
    update();
  }

  Future subjectListData() async {
    showLoadingDialog(Get.context!);
    final result = await BaseService().getMethod(
        "https://test.schoolec.in/api/staff/v2/standard-subject?standard_id=$selectedStdValue&group_section_id=$selectedSectionValue");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          classTestStdSubjectModel =
              ClassTestStdSubjectModel.fromJson(result.data);
          stdSubject.clear();
          for (int i = 0; i < classTestStdSubjectModel!.data.length; i++) {
            stdSubject.add(CustomStdSubjectListModel(
                classTestStdSubjectModel!.data[i].id!,
                classTestStdSubjectModel!.data[i].subjectListId!,
                classTestStdSubjectModel!.data[i].subject?.fullName ?? "",
                classTestStdSubjectModel!.data[i].subject?.shortName ?? ""));
          }
        } else {
          print("standardListData: ${result.statusCode}");
        }
      }
    } catch (e) {
      print("standardListData $e");
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  Future studentResultDetails() async {
    final result = await BaseService().getMethod(
        "https://test.schoolec.in/api/staff/v2/class-test/student-result/$studentResultDetailsFetchId");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          studentResultDetailsModel = StudentResultDetailsModel.fromJson(result.data);
          studentList = studentResultDetailsModel?.data?.studentList;
          maxMarkEditController.text = studentResultDetailsModel
                  ?.data?.classTestDetail?.resultMax
                  .toString() ??
              "";
        } else {
          print("standardListData: ${result.statusCode}");
        }
      }
    } catch (e) {
      print("standardListData $e");
    } finally {}
    update();
  }

  void selectedStandardUpdate(String std, int stdvalue, int secValue) {
    selectedStdTxt = std;
    selectedStdValue = stdvalue;
    selectedSectionValue = secValue;
    update();
  }

  void updateIndex(int index) {
    currentIndex = index;
    studentList?.clear();
    classTestReplyListData?.clear();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    selectedStdTxt = "Select Standard";
    selectedStdValue = 0;
    selectedSectionValue = 0;
    stdSubjectId = 0;
    subSelectFlag = 0;
    update();
  }

  Future<int> imageDelete(Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    dynamic result;
    try {
      result = await BaseService().postMethod(userData,
          "https://test.schoolec.in/api/staff/v2/class-test/images-delete");
      if (result != null) {
        if (result.statusCode == 200) {
          print('staffReplySubmit: ${result.statusCode}');
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

  removeItem(int index) {
    filesList.removeAt(index);
    update();
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

  Future sendClassTestSubmission(
      {required int classTestId,
      required String classTestTitle,
      required int sectionSubjectItemId,
      required String classTestDesc,
      required int approvalType,
      required int classTestApprovalType,
      required List<StaffClassTestAttachment> filesList,
      required String url}) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService().uploadStaffClassTestMultipleFiles(
          filesList: filesList,
          url: url,
          classTestId: classTestId,
          classTestTitle: classTestTitle,
          sectionSubjectItemId: sectionSubjectItemId,
          classTestDesc: classTestDesc,
          approvalType: approvalType,
          classTestApprovalType: classTestApprovalType);
      if (result != null) {
        if (result.statusCode == 200) {
          classTestAddResponse = ClassTestAddResponce.fromJson(result.data);
          Get.back();
          viewClassTestData();
        } else {}
      }
    } catch (e) {
      print('Homework Submission Screen  $e');
    } finally {
      closeLoadingDialog(Get.context!);
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
      selectType = type;
      if (type == 1) {
        startDate =
            DateFormat('yyyy-MM-dd').format(currentDate ?? DateTime.now());
      } else if (type == 2) {
        endDate =
            DateFormat('yyyy-MM-dd').format(currentDate ?? DateTime.now());
      } else {
        selectedDate =
            DateFormat('yyyy-MM-dd').format(currentDate ?? DateTime.now());
        viewClassTestData();
      }

      update();
      return currentDate;
    }
  }

  Future viewClassTestData() async {
    if (selectType == 3) {
      showLoadingDialog(Get.context!);
    }
    final result = await BaseService().getMethod(
        "https://test.schoolec.in/api/staff/v2/class-test/overall-today?date=$selectedDate&class_test=1");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          classTestSTViewModel = ClassTestStViewModel.fromJson(result.data);
          classTestViewData = classTestSTViewModel?.data;
          print("viewClassTestData : ${result.statusCode}");
        } else {
          print("viewClassTestData : ${result.statusCode}");
        }
      }
    } catch (e) {
      print("viewClassTestData : $e");
    } finally {
      if (selectType == 3) {
        closeLoadingDialog(Get.context!);
      }
    }
    update();
  }

  Future<int> checkSettings() async {
    showLoadingDialog(Get.context!);
    final result = await BaseService()
        .getMethod("https://test.schoolec.in/api/staff/v2/setting");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          basicSettingsModel = BasicSettingsmodel.fromJson(result.data);
        } else {
          print("checkSettings : ${result.statusCode}");
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

  Future filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path.toString());
      String filename = file.path.split('/').last;
      filesList.add(StaffClassTestAttachment(file: file, fileName: filename));
    }

    update();
  }

  Future captureImage() async {
    image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    String filename = image!.path.split('/').last;
    filesList.add(StaffClassTestAttachment(
        file: File(image!.path.toString()), fileName: filename));
    update();
  }

  Future<int> studentResultSubmit(Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    print("zkugfkjd called");
    final result = await BaseService().postWithoutFormData(userData,
        "https://test.schoolec.in/api/staff/v2/class-test/student-result/$studentResultDetailsFetchId");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          // classTestReplyListModel =
          //     ClassTestReplyListModel.fromJson(result.data);
          // classTestReplyListData = classTestReplyListModel?.data;
          print("classTeacherViewHomeworkModel ${result.statusCode}");
        } else {
          print("classTeacherViewHomeworkModel ${result.statusCode}");
        }
      }
    } catch (e) {
      print("classTeacherViewHomeworkModel $e");
    } finally {
      closeLoadingDialog(Get.context!);
    }
     update();
    return result.statusCode;
  }


  Future<int> classTestListData(Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    final result = await BaseService().postWithoutFormData(userData,
        "https://test.schoolec.in/api/staff/v2/class-test/class-test-list");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          classTestReplyListModel =
              ClassTestReplyListModel.fromJson(result.data);
          classTestReplyListData = classTestReplyListModel?.data;
          print("classTeacherViewHomeworkModel ${result.statusCode}");
        } else {
          print("classTeacherViewHomeworkModel ${result.statusCode}");
        }
      }
    } catch (e) {
      print("classTeacherViewHomeworkModel $e");
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return result.statusCode;
  }


}
