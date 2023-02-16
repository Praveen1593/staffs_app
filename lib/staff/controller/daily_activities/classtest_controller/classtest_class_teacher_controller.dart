import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../common/const/colors.dart';
import '../../../../common/services/base_client.dart';
import '../../../../parent/view/dialogs/dialog_helper.dart';
import '../../../model/BasicSettingsModel.dart';
import '../../../model/ClassTeacherStandardListModel.dart';
import '../../../model/ClassTestAddResponce.dart';
import '../../../model/ClassTestReplyListModel.dart';
import '../../../model/ClassTestStdSubjectModel.dart';
import '../../../model/Classtest_ST_ViewModel.dart';
import '../../../model/CustomImageListDisplayModel.dart';
import '../../../model/CustomStdSubjectListModel.dart';
import '../../../model/CustomSubjectTeacherStdListModel.dart';
import '../../../model/StudentResultDetailsModel.dart';
import '../../../view/screens/staff_dailly_activities/staff_classtest/staff_classtest_CT_add_entry_screen.dart';
import '../../../view/screens/staff_dailly_activities/staff_classtest/staff_classtest_class_teacher_view_screen.dart';

class StaffClassTeacherClasstestController extends GetxController{

  int currentIndex = 0;
  int? radiotype = 2;
  List<dynamic>? attachmentList = [];
  List<CustomImageListDisplayModel>? attachList = [];
  String? selectedStdTxt = "Select Standard";
  int? selectedStdValue = 0;
  int? selectedSectionValue = 0;
  DateTime? currentDate;
  String? selectedDate;
  String? startDate;
  String? endDate;
  List<Widget> list = [
    BuildTodayBody(),
    BuildReplyBody(),
  ];
  ImagePicker picker = ImagePicker();
  TextEditingController titleEditController = TextEditingController();
  TextEditingController descriptionEditController = TextEditingController();
  TextEditingController maxMarkEditController = TextEditingController();
  TextEditingController markEditController = TextEditingController();
  ClassTeacherStandardListModel? cTStandardList;
  BasicSettingsmodel? basicSettingsModel;
  List<StaffClassTestCTAttachment> filesList = <StaffClassTestCTAttachment>[].obs;
  int? permissionChecked = 0;
  XFile? image;
  ClassTestAddResponce? classTestAddResponse;
  ClassTestReplyListModel? classTestReplyListModel;


  ClassTestStViewModel? classTestSTViewModel;
  List<ClassTestViewData>? classTestViewData;
  int? selectType;
  int? studentResultDetailsFetchId;
  List<ClassTestReplyListData>? classTestReplyListData;
  StudentResultDetailsModel? studentResultDetailsModel;
  List<StudentList>? studentList = [];
  String? resultTitleTxt;
  String? resultDescriptionTxt;
  int? stdSubjectId = 0;
  int subSelectFlag = 0;
  ClassTestStdSubjectModel? classTestStdSubjectModel;
  List<CustomStdSubjectListModel> stdSubject = [];
  List<CustomSubjectTeacherStdListModel> stdList = [];


  @override
  void onInit() {
    super.onInit();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    cTStandardListData();
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

  Future subjectListData(int type) async {
    showLoadingDialog(Get.context!);
    final result = await BaseService().getMethod(
        "https://test.schoolec.in/api/staff/v2/standard-subject?standard_id=$selectedStdValue&group_section_id=$selectedSectionValue&class_teacher=1");

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

  //Logics

  void selectedStandardUpdate(String std, int stdvalue, int secValue) {
    selectedStdTxt = std;
    selectedStdValue = stdvalue;
    selectedSectionValue = secValue;
    update();
  }

  void updateIndex(int index){
    currentIndex = index;
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
    attachmentList?.removeAt(index);
    update();
  }

  Future filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path.toString());
      String filename = file.path.split('/').last;
      filesList.add(StaffClassTestCTAttachment(file: file, fileName: filename));
      print("filesList ----> ${filesList.length}");
    }
    update();
  }

  Future captureImage() async {
    image = await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    String filename = image!.path.split('/').last;
    filesList.add(StaffClassTestCTAttachment(file: File(image!.path.toString()), fileName: filename));
    print("${filesList[0]}");
    print("${filesList[1]}");
    update();
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

  //API

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

  Future studentResultDetails() async {
    print("standardListData:studentResultDetailsFetchId $studentResultDetailsFetchId");
    final result = await BaseService().getMethod(
        "https://test.schoolec.in/api/staff/v2/class-test/student-result/$studentResultDetailsFetchId");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          studentResultDetailsModel = StudentResultDetailsModel.fromJson(result.data);
          print("standardListData: ${studentResultDetailsModel?.data}");
          // studentResultDetailsModel?.code = 200;
          studentList = studentResultDetailsModel?.data?.studentList;
          maxMarkEditController.text = studentResultDetailsModel
              ?.data?.classTestDetail?.resultMax
              .toString() ??
              "";
          print("standardListData: ${result.statusCode}");
        } else {
          print("standardListData: ${result.statusCode}");
        }
      }
    } catch (e) {
      print("standardListData $e");
    } finally {}
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

  Future viewClassTestData() async {
    /*if (selectType == 3) {

    }*/
    showLoadingDialog(Get.context!);
    final result = await BaseService().getMethod(
        "https://test.schoolec.in/api/staff/v2/class-test/class-teacher/overall-today?date=$selectedDate&standard_id=$selectedStdValue&group_section_id=$selectedSectionValue&class_test=1");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          classTestSTViewModel = ClassTestStViewModel.fromJson(result.data);
          classTestViewData = classTestSTViewModel?.data;
          print("classTestViewData ${classTestViewData?.first.classTest!.images!.first}");
          /*if(classTestViewData!=null&&classTestViewData!.isNotEmpty){
            for(int i=0;i<classTestViewData!.length;i++){
              if(classTestViewData![i].classTest!=null&&classTestViewData![i].classTest!.images!=null&&classTestViewData![i].classTest!.images!.isNotEmpty){
                for(int j=0;j<classTestViewData![i].classTest!.images!.length;j++){
                  attachList?.add(CustomImageListDisplayModel(type: 1,urlImage: "${classTestViewData![i].classTest!.images![j].oldAttachFile}"));
                  print("viewClassTestData : ${attachList?.length}");
                }

              }
            }
          }*/
          print("viewClassTestData : ${result.statusCode}");
        } else {
          print("viewClassTestData : ${result.statusCode}");
        }
      }
    } catch (e) {
      print("viewClassTestData : $e");
    } finally {
      closeLoadingDialog(Get.context!);
      /*if (selectType == 3) {

      }*/
    }
    update();
  }

  Future<int> cTStandardListData() async {
    final result =
    await BaseService().getMethod("https://test.schoolec.in/api/staff/v2/class-teacher-list");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          cTStandardList = ClassTeacherStandardListModel.fromJson(result.data);
          stdList.clear();
          for (int i = 0; i < cTStandardList!.data!.length; i++) {
            stdList.add(CustomSubjectTeacherStdListModel(
                cTStandardList!.data![i].standardId ??
                    0,
                cTStandardList!.data![i].groupSectionId ?? 0,
                "${cTStandardList!.data![i].name}"));
          }
        }
      }
    } catch (e) {
      print("Leave list $e");
    } finally {}
    update();
    return result.statusCode;
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

  Future sendClassTestSubmission(
      {required int classTestId,
        required String classTestTitle,
        required int sectionSubjectItemId,
        required String classTestDesc,
        required int approvalType,
        required int classTestApprovalType,
        required List<StaffClassTestCTAttachment> filesList,
        required String url}) async {
    showLoadingDialog(Get.context!);
    try {
      print("fi;eskhgkjf ${filesList.length}");
      final result = await BaseService().uploadStaffClassTestCTMultipleFiles(
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




}