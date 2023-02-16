import 'package:flutter/material.dart';
import 'package:flutter_projects/common/apihelper/api_helper.dart';
import 'package:get/get.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../parent/model/custom_model.dart';
import '../../../../common/services/base_client.dart';
import '../../model/gender_list_model.dart';
import '../../model/standard_students_list_model.dart';
import '../../model/students_list_model.dart';

class StudentsDetailsController extends GetxController {
  final isLoading = true.obs;
  final loadingState = LoadingState(loadingType: LoadingType.stable).obs;
  List<GenderData> genderData = [];
  List<GenderData> filteredGenderList = <GenderData>[].obs;
  RxInt genderSelectedIndex = 0.obs;
  RxInt studentsListSelectedIndex = 0.obs;
  RxInt studentsListSectionIndex = 0.obs;
  int pageNo = 1;
  List<StudentStandardListData> studentsStandardListData = [];
  List<StudentStandardListData> filterStudentsStandardListData =
      <StudentStandardListData>[].obs;
  ScrollController scrollController = ScrollController();
  List<StudentsData> studentsData = <StudentsData>[].obs;
  List<StudentsData> studentsList = <StudentsData>[].obs;
  RxBool isExpanded = false.obs;
  RxInt checkType = 1.obs;
  RxInt genderId = 0.obs;
  RxInt standardId = 0.obs;
  RxInt groupSectionId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    filteredGenderList.insert(0, GenderData(id: 0, name: "Select Gender"));
    filterStudentsStandardListData.insert(
        0,
        StudentStandardListData(
            fullName: "Select ", section: [Section(fullName: "Std")]));
    getData("${ApiHelper.studentsListUrl}?page=$pageNo");
    scrollController.addListener(_scrollListener);
  }

  void updateGenderValue(int index) {
    genderSelectedIndex.value = index;
  }

  void updateStudentListValue(int index, int index1) {
    studentsListSelectedIndex.value = index;
    studentsListSectionIndex.value = index1;
  }

  void expandedView(expanded) {
    isExpanded.value = !expanded;
    update();
  }

  Future fetchGenderList() async {
    try {
      final result = await BaseService().getMethod(ApiHelper.genderListUrl);
      if (result != null) {
        if (result.statusCode == 200) {
          GenderListModel genderListModel =
              GenderListModel.fromJson(result.data);
          genderData = genderListModel.genderData;
          filteredGenderList.addAll(genderData);
        }
      }
    } catch (e) {
      print('Gender List $e');
    } finally {}
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
  }

  void getData(String url) async {
    if (pageNo == 1) {
      isLoading.value = true;
    }
    studentsList = [];
    List<StudentsData> listOfData = [];
    listOfData = await fetchData(url: url);
    studentsList.clear();
    studentsList.assignAll(listOfData);
    isLoading.value = false;
  }

  Future<List<StudentsData>> fetchData({String? url}) async {
    try {
      final result = await BaseService().getMethod(url ?? "");
      if (result != null) {
        if (result.statusCode == 200) {
          StudentsListModel studentsListModel =
              StudentsListModel.fromJson(result.data);
          studentsData = studentsListModel.studentsData ?? [];
        }
      }
    } catch (e) {
      print('Fetch Students List $e');
    }
    update();
    return studentsData;
  }

  void _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadingState.value = LoadingState(loadingType: LoadingType.loading);
      try {
        List<StudentsData> listOfData = [];
        await Future.delayed(const Duration(seconds: 3));
        if (checkType.value == 2) {
          listOfData = await fetchData(
              url:
                  "${ApiHelper.studentsListUrl}?gender_id=${genderId.value}&standard_id=${standardId.value}&group_section_id=${groupSectionId.value}&page=${++pageNo}");
        } else {
          listOfData = await fetchData(
              url: "${ApiHelper.studentsListUrl}?page=${++pageNo}");
        }
        if (listOfData.isEmpty) {
          loadingState.value =
              LoadingState(loadingType: LoadingType.completed, completed: "");
        } else {
          studentsList.addAll(listOfData);
          loadingState.value = LoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            LoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
    update();
  }

  void filterGenderResults(String query) {
    List<GenderData> filterList = [];
    filterList.addAll(filteredGenderList);
    if (query.isNotEmpty) {
      List<GenderData> listData = [];
      for (var item in filterList) {
        if (item.name.toString().toLowerCase().contains(query.toLowerCase())) {
          listData.add(item);
        }
      }
      filteredGenderList.clear();
      filteredGenderList.addAll(listData);
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
  }
}
