import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/apihelper/api_helper.dart';
import '../../../../common/services/base_client.dart';

import '../../../model/exam_list_model.dart';
import '../../../model/exam_timetable_model.dart';
import '../../../../storage.dart';

class ExamResultAndTimeTableController extends GetxController {
  String dropdownValue = 'Select Exam';
  ExamListModel? examListModel;
  List<ExamListData>? examListData = [];
  ExamTimeTableModel? examTimeTableModel;
  int? selectedId;
  final arguments = Get.arguments;
  bool isLoading = false;

  void updateSelectedIndex({required String data}) {
    dropdownValue = data;
    if (examListData!.isNotEmpty) {
      examListData?.forEach((element) {
        if (element.name == dropdownValue && dropdownValue != "Select Exam") {
          selectedId = element.id ?? -1;
          if (arguments["name"] != null) {
            if (arguments["name"] == "Exam TimeTable") {
              fetchExamTimeTable(examListId: selectedId);
            } else if (arguments["name"] == "Exam Result") {
              fetchExamResult(examListId: selectedId);
            }
          }
        }
      });
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    examListData = [];
    if (arguments["name"] != null) {
      Future.delayed(const Duration(seconds: 1),(){
        arguments["name"] == "Exam Result"
            ? fetchExamList(type: 1)
            : fetchExamList(type: 2);
      });
    }
    update();
  }

  Future fetchExamList({int? type}) async {
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.examListUrl}student_id=${LocalStorage.getValue("studentId")}&type=$type");
      if (result != null) {
        if (result.statusCode == 200) {
          examListModel = ExamListModel.fromJson(result.data);
          examListData?.addAll(examListModel?.examListData ?? []);
          examListData?.insert(
              0,
              ExamListData(
                id: -1,
                code: "",
                name: "Select Exam",
                status: -1,
                priority: -1,
              ));
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft
          ]);
        } else {
          examListModel = ExamListModel(
              code: 403, status: "error", error: examListModel?.error ?? "");
        }
      }
    } catch (e) {
      print('Exam List $e');
    } finally {
    }
    update();
  }

  Future fetchExamResult({int? examListId}) async {
    isLoading = true;
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.examResultUrl}student_id=${LocalStorage.getValue("studentId")}&exam_list_id=$examListId&single_color=1");
      if (result != null) {
        if (result.statusCode == 200) {
          examTimeTableModel = ExamTimeTableModel.fromJson(result.data);
          isLoading = false;
        } else {
          isLoading = false;
          examTimeTableModel = ExamTimeTableModel(
              code: 403,
              status: "error",
              error:
                  result.data.containsKey("error") ? result.data["error"] : "");
        }
      }
    } catch (e) {
      print('Exam Result $e');
    } finally {
    }
    update();
  }

  Future fetchExamTimeTable({int? examListId}) async {
    isLoading = true;
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.examTimeTableUrl}student_id=${LocalStorage.getValue("studentId")}&exam_list_id=$examListId&single_color=1");
      if (result != null) {
        if (result.statusCode == 200) {
          examTimeTableModel = ExamTimeTableModel.fromJson(result.data);
          isLoading = false;
        } else {
          isLoading = false;
          examTimeTableModel = ExamTimeTableModel(
              code: 403,
              status: "error",
              error:
                  result.data.containsKey("error") ? result.data["error"] : "");
        }
      }
    } catch (e) {
      print('Exam TimeTable $e');
    } finally {

    }
    update();
  }
}
