import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/apihelper/api_helper.dart';
import '../../../common/database_helper.dart';
import '../../../common/services/base_client.dart';
import '../../../parent/view/dialogs/dialog_helper.dart';
import '../../model/ExamDBModel.dart';
import '../../model/overall_exam_result_model.dart';
import '../../model/pattern_model.dart';
import '../../model/standard_students_list_model.dart';
import '../../model/subject_assesment_exam_list_model.dart';

class StaffExamResultController extends GetxController {
  List<StudentStandardListData> studentsStandardListData = [];
  List<StudentStandardListData> filterStudentsStandardListData = [];
  List<ExamList> filteredExamList = [];
  List<ExamArea> filteredExamAreaList = [];
  List<SubjectList> filteredSubjectList = [];
  List<OverallExamResultData> overallExamResultData = [];
  PatternData? patternData;
  int studentsListSelectedIndex = 0;
  int studentsListSectionIndex = 0;
  int standardExamListSelectedIndex = 0;
  int standardExamAreaSelectedIndex = 0;
  int standardSubjectListSelectedIndex = 0;
  int standardSubjectId = 0;
  int standardSubjectItemId = 0;
  int patternSubjectListId = 0;
  int patternStandardSubjectId = 0;
  int patternExamListId = 0;
  int patternExamMarkTypeId = 0;
  int patternExamMarkTypeItemId = 0;
  bool isLoading = false;
  bool patternIsLoading = false;
  int columnLevel = 1;
  TextEditingController markEditController = TextEditingController();
  List<EditedCustomModel> editedCustomModel = [];
  List<ChildrenCustomModel> childrenCustomModel = [];
  List<CustomModelOverAllExamResult> customModelOverallExamList = [];
  String itemGrade ='';
  int? subjectItemId;

  SubjectExamListData? subjectExamListData;
  String? overallDisplayMark;

 // DatabaseHelper databaseHelper = DatabaseHelper();
  ExamDbModel? examDbModel;


  void checkboxUpdate(bool value,int index){

    if(value){
      editedCustomModel[index].absentValue=1;
    }else{
      editedCustomModel[index].absentValue=0;
    }
    update();


  }


  @override
  void onInit() {
    super.onInit();
    filterStudentsStandardListData.insert(
        0,
        StudentStandardListData(
            fullName: "-- Select Std --", section: [Section(fullName: "")]));

    filteredExamList.insert(0, ExamList(code: "-> Exam <-", name: ""));
    filteredExamAreaList.insert(0, ExamArea(name: "-> Exam Area <-"));
    filteredSubjectList.insert(
        0, SubjectList(subject: Subject(name: "Select Subject")));
    fetchTeacherStandardListData();

    //Standard list
    /*//Exam List
    fetchStandardSubjectAssessmentExamListData(
        url:
        "${ApiHelper.subjectAssessmentExamListUrl}standard_id=${filterStudentsStandardListData[studentsListSelectedIndex].section![studentsListSectionIndex].standardId}&group_section_id=${filterStudentsStandardListData[studentsListSelectedIndex].section![studentsListSectionIndex].id}&exam_list=1");
    //Exam Area List
    fetchStandardSubjectAssessmentExamListData(
        url:
        "${ApiHelper.subjectAssessmentExamListUrl}standard_id=${filterStudentsStandardListData[studentsListSelectedIndex].section![studentsListSectionIndex].standardId}&group_section_id=${filterStudentsStandardListData[studentsListSelectedIndex].section![studentsListSectionIndex].id}&exam_list=1&exam_area=1");*/
    //Subject List


  }



  void updateStudentListValue(int index, int index1) {
    studentsListSelectedIndex = index;
    studentsListSectionIndex = index1;

    update();
  }

  void updateSelectedExamList(int index) {
    standardExamListSelectedIndex = index;
    update();
  }

  void updateSelectedExamArea(int index) {
    standardExamAreaSelectedIndex = index;
    update();
  }

  void updateSelectedSubjectList(int index, int subjectId, int id) {
    standardSubjectListSelectedIndex = index;
    standardSubjectId = subjectId;
    standardSubjectItemId = id;
    update();
  }

  Future fetchTeacherStandardListData() async {
    final result =
        await BaseService().getMethod(ApiHelper.subjectTeacherStndardList);
    try {
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
      print("fetchTeacherStandardListData  $e");
    }
update();
  }

  Future fetchStandardSubjectAssessmentExamListData(
      {required String url}) async {
    showLoadingDialog(Get.context!);
    final result = await BaseService().getMethod(url);
    try {
      if (result != null) {
        if (result.statusCode == 200) {

          SubjectAssesementExamListModel staffStandardListModel =
              SubjectAssesementExamListModel.fromJson(result.data);
          print("subject in controller  $staffStandardListModel");

          subjectExamListData = staffStandardListModel.subjectExamListData;
          if (subjectExamListData != null) {
            if (subjectExamListData!=null&&subjectExamListData!.examList!.isNotEmpty) {
              List<ExamList> examList = subjectExamListData!.examList ?? [];
              filteredExamList.addAll(examList);
              print("subject in controller $filteredExamList ");

            }
            if (subjectExamListData!=null&&subjectExamListData!.examArea!.isNotEmpty) {
              List<ExamArea> examAreaList = subjectExamListData!.examArea ?? [];
              filteredExamAreaList.addAll(examAreaList);
            }
            if (subjectExamListData!=null&&subjectExamListData!.subjectList!.isNotEmpty) {
              List<SubjectList> subjectList =
                  subjectExamListData!.subjectList ?? [];
              filteredSubjectList.addAll(subjectList);
            }
          }
        }
      }
    } catch (e) {
      print("fetchStandardSubjectAssessmentExamListData  $e");
    }finally{
      closeLoadingDialog(Get.context!);}
    update();
  }

  updateLoadingStatus(){
 patternIsLoading = true;
  isLoading = true;
  update();
  }

  Future fetchPattern() async {
    patternIsLoading = true;
    final result = await BaseService().getMethod(
        "${ApiHelper.standardSubjectListOverallUrl}exam_list_id=${filteredExamList[standardExamListSelectedIndex].examListId}&standard_id=${filterStudentsStandardListData[studentsListSelectedIndex].section![studentsListSectionIndex].standardId}&standard_subject_id=$standardSubjectId&standard_subject_item_id=$standardSubjectItemId");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          PatternModel patternModel = PatternModel.fromJson(result.data);
          patternIsLoading = false;
          patternData = patternModel.patternData;
          patternStandardSubjectId = patternData?.standardSubjectId ?? 0;
          patternSubjectListId = patternData?.subjectListId ?? 0;
          patternExamListId =
              filteredExamList[standardExamListSelectedIndex].examListId ?? 0;
          patternExamMarkTypeId = patternData?.examMarkType?.id ?? 0;
          patternExamMarkTypeItemId = patternData?.examMarkType?.id ?? 0;
          columnLevel = patternData?.examMarkType?.displayColumnsLevel ?? 1;
        }
      }
    } catch (e) {
      print("fetchSearchStandardListOverallData $e");
    } finally {
      patternIsLoading = false;
    }
    update();
  }

  Future fetchOverallExamResultData(Map<String, dynamic> mapData) async {
    isLoading = true;
    final result = await BaseService()
        .postWithoutFormData(mapData, ApiHelper.overallExamResultUrl);
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          isLoading = false;
          OverAllExamResultModel overAllExamResultModel =
              OverAllExamResultModel.fromJson(result.data);
          overallExamResultData = overAllExamResultModel.overallExamResultData ?? [];

          //databaseHelper.insertItem(overallExamResultData);


         /*if (patternData!.examMarkType!.items!.isNotEmpty) {
            for (int p = 0; p < patternData!.examMarkType!.items!.length; p++) {
              if (overallExamResultData.isNotEmpty) {
                for (int q = 0; q < overallExamResultData.length; q++) {
                  if (overallExamResultData[q].examResult!.isNotEmpty) {
                    for (int r = 0;
                        r < overallExamResultData[q].examResult!.length;
                        r++) {
                      if (overallExamResultData[q]
                              .examResult?[r]
                              .examMarkTypeIteId ==
                          patternData?.examMarkType?.items?[p].id) {
                        if (patternData?.examMarkType?.items?[p].total == 1) {
                          overallExamResultData[q].totalMarkValue =
                              overallExamResultData[q]
                                      .examResult?[r]
                                      .examMark ??
                                  "";
                          overallExamResultData[q].absentValue =
                              overallExamResultData[q].examResult?[r].absent ??
                                  0;
                        }
                      }
                    }
                  }
                }
              }
            }
          }*/

          if (overallExamResultData.isNotEmpty) {
            customModelOverallExamList = [];
            for (int a = 0; a < overallExamResultData.length; a++) {
              customModelOverallExamList.add(CustomModelOverAllExamResult(edit: 0,customOverExamResultList: overallExamResultData[a]));
            }
            print("customModelOverallExamList length in controller ${customModelOverallExamList.length}");

          }
        }
      }
    } catch (e) {
      print("fetchOverallExamResultData  $e");
    } finally {
      isLoading = false;
    }
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

  void filterStandardExamListResults(String query) {
    List<ExamList> filterExamList = [];
    filterExamList.addAll(filteredExamList);
    if (query.isNotEmpty) {
      List<ExamList> listOfExamData = [];
      for (var item in filterExamList) {
        if (item.code.toString().toLowerCase().contains(query.toLowerCase()) ||
            item.name.toString().toLowerCase().contains(query.toLowerCase())) {
          listOfExamData.add(item);
        }
      }
      filteredExamList.clear();
      filteredExamList.addAll(listOfExamData);
    }
    update();
  }

  void filterStandardExamAreaResults(String query) {
    List<ExamArea> filterExamAList = [];
    filterExamAList.addAll(filteredExamAreaList);
    if (query.isNotEmpty) {
      List<ExamArea> listOfExamData = [];
      for (var item in filterExamAList) {
        if (item.name.toString().toLowerCase().contains(query.toLowerCase())) {
          listOfExamData.add(item);
        }
      }
      filteredExamAreaList.clear();
      filteredExamAreaList.addAll(listOfExamData);
    }
    update();
  }

  void filterStandardSubjectListResults(String query) {
    List<SubjectList> filterSubjectList = [];
    filterSubjectList.addAll(filteredSubjectList);
    if (query.isNotEmpty) {
      List<SubjectList> listOfExamData = [];
      for (var item in filterSubjectList) {
        if (item.subject!.name
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          listOfExamData.add(item);
        }
      }
      filteredSubjectList.clear();
      filteredSubjectList.addAll(listOfExamData);
    }
    update();
  }
}

class EditedCustomModel {
  EditedCustomModel(
      {required this.displayText,
      required this.absentValue,
       this.itemId,
       this.childrenId,
      required this.total,
      required this.type,
        this.subItem,
        required this.childrenFlag,
        this.childrenCustomModel,
        this.grade,
        this.maxMark=0,
        this.textEditingController,
        this.examMarkTypeItemId,
        this.standardSubjectId,
        this.subjectListId,
        this.standardSubjectItemId,
        this.examListId,
        this.examMarkTypeId,
        this.gradeDisplayType,
        this.editedFlag,
        this.editedValue,
        this.resultValue,
      this.itemMark,this.itemIndex});

  String displayText;
  int absentValue;
  int? itemId;
  int? childrenId;
  int total;
  int type;
  int? subItem;
  int childrenFlag;
  String? grade;
  int? gradeDisplayType;
  int maxMark;
  TextEditingController? textEditingController;
  List<ChildrenCustomModel>? childrenCustomModel;
  int? examMarkTypeItemId;
  int? standardSubjectId;
  int? subjectListId;
  int? standardSubjectItemId;
  int? examListId;
  int? examMarkTypeId;
  int? itemMark;
  int? itemIndex;
  int? editedFlag;
  int? editedValue;
  int? resultValue;
}

class ChildrenCustomModel {
  ChildrenCustomModel(
      {required this.displayText,
        required this.absentValue,
        this.itemId,
        this.childrenId,
        required this.total,
        required this.type,
        this.subItem,
        required this.childrenFlag,
        this.grade,
        this.maxMark=0,
        this.textEditingController,
        this.examMarkTypeItemId,
        this.standardSubjectId,
        this.subjectListId,
        this.standardSubjectItemId,
        this.examListId,
        this.examMarkTypeId,
        this.gradeDisplayType,
        this.itemMark,this.itemIndex});

  String displayText;
  int absentValue;
  int? itemId;
  int? childrenId;
  int total;
  int type;
  int? subItem;
  int childrenFlag;
  String? grade;
  int? gradeDisplayType;
  int maxMark;
  TextEditingController? textEditingController;
  int? examMarkTypeItemId;
  int? standardSubjectId;
  int? subjectListId;
  int? standardSubjectItemId;
  int? examListId;
  int? examMarkTypeId;
  int? itemMark;
  int? itemIndex;
}


class CustomModelOverAllExamResult{
  CustomModelOverAllExamResult({this.edit,this.customOverExamResultList});
  int? edit;
  OverallExamResultData? customOverExamResultList;
}