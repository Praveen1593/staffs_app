import 'dart:collection';
import 'package:flutter_projects/common/apihelper/api_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../common/common_model/calender_model.dart';
import '../../../common/common_model/custom_school_calender_model.dart';
import '../../../parent/model/month_list_model.dart';
import '../../../../common/services/base_client.dart';

class StaffCalenderController extends GetxController {
  int? currentMonthId;
  List<CalenderData> calenderDataList = [];
  final kToday = DateTime.now();
  List<DateTime> noOfDays = [];
  List<CustomSchoolCalenderModel> customModelList = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchMonthList(DateFormat("MMMM").format(DateTime.now()));
  }

  Future fetchMonthList(String month) async {
    try {
      final result =
          await BaseService().getMethod("${ApiHelper.monthListUrl}");
      if (result != null) {
        if (result.statusCode == 200) {
          MonthListModel monthListModel = MonthListModel.fromJson(result.data);
          List<MonthListData> monthList = monthListModel.monthData;
          if (monthList.isNotEmpty) {
            for (var element in monthList) {
              if (element.commonName == month) {
                currentMonthId = element.id;
              }
            }
            if (currentMonthId != null) {
              fetchCalenderDetails(currentMonthId ?? 0);
            }
          }
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    }
    update();
  }

  Future fetchCalenderDetails(int id) async {
    isLoading = true;
    try {
      final result = await BaseService()
          .getMethod("${ApiHelper.schoolCalenderUrl}month_list_id=$id");
      if (result != null) {
        if (result.statusCode == 200) {
          isLoading = false;
          CalenderModel calenderModel = CalenderModel.fromJson(result.data);
          calenderDataList = calenderModel.calenderData ?? [];
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    } finally {
      isLoading = false;
    }
    update();
  }

  List<DateTime> calculateDaysInterval(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  List<CustomSchoolCalenderModel> staffEvents() {
    if (calenderDataList.isNotEmpty) {
      List.generate(calenderDataList.length, (index) {
        noOfDays = calculateDaysInterval(
            DateTime.parse(calenderDataList[index].startDate.toString()),
            DateTime.parse(calenderDataList[index].endDate.toString()));
        List<DateTime> myDate = [];
        for (int i = 0; i < noOfDays.length; i++) {
          myDate.add(noOfDays[i]);
        }
        customModelList.add(CustomSchoolCalenderModel(
            startDate: calenderDataList[index].startDate.toString(),
            endDate: calenderDataList[index].endDate.toString(),
            dateTimeList: myDate,
            title: calenderDataList[index].title,
            description: calenderDataList[index].description,
            eventName: calenderDataList[index].eventTypeName));
      });
    }
    return customModelList;
  }

  int _getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  getStaffEvent() {
    List<CustomSchoolCalenderModel> finalList = staffEvents();
    Map kEvents = {};
    Map<DateTime, List<CustomSchoolCalenderModel>> kEventSource = {};
    for (var i = 0; i < finalList.length; i++) {
      for (var j = 0; j < finalList[i].dateTimeList!.length; j++) {
        kEventSource.addAll({
          DateTime.utc(
              finalList[i].dateTimeList![j].year,
              finalList[i].dateTimeList![j].month,
              finalList[i].dateTimeList![j].day): [finalList[i]],
        });
        kEvents = LinkedHashMap<DateTime, List<CustomSchoolCalenderModel>>(
          equals: isSameDay,
          hashCode: _getHashCode,
        )..addAll(kEventSource);
      }
    }
    return kEvents;
  }
}
