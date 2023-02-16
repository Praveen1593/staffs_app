import 'dart:collection';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../common/apihelper/api_helper.dart';
import '../../../../common/common_model/calender_model.dart';
import '../../../../common/common_model/custom_school_calender_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../../storage.dart';
import '../../../model/month_list_model.dart';

class CalenderController extends GetxController {
  int? currentMonthId;
  List<CalenderData> calenderData = [];
  final kToday = DateTime.now();
  List<DateTime> noOfDays = [];
  List<CustomSchoolCalenderModel> myList = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchMonthList(DateFormat("MMMM").format(DateTime.now()));
  }

  Future fetchMonthList(String month) async {
    try {
      final result = await BaseService().getMethod("${ApiHelper.monthListUrl}");
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
      final result = await BaseService().getMethod(
          "${ApiHelper.schoolCalenderUrl}student_id=${LocalStorage.getValue("studentId")}&month_list_id=$id");
      if (result != null) {
        if (result.statusCode == 200) {
          isLoading = false;
          CalenderModel calenderModel = CalenderModel.fromJson(result.data);
          calenderData = calenderModel.calenderData ?? [];
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

  List<CustomSchoolCalenderModel> events() {
    if (calenderData.isNotEmpty) {
      List.generate(calenderData.length, (index) {
        noOfDays = calculateDaysInterval(
            DateTime.parse(calenderData[index].startDate.toString()),
            DateTime.parse(calenderData[index].endDate.toString()));
        List<DateTime> myDate = [];
        for (int i = 0; i < noOfDays.length; i++) {
          myDate.add(noOfDays[i]);
        }
        myList.add(CustomSchoolCalenderModel(
            startDate: calenderData[index].startDate.toString(),
            endDate: calenderData[index].endDate.toString(),
            dateTimeList: myDate,
            title: calenderData[index].title,
            description: calenderData[index].description,
            eventName: calenderData[index].eventTypeName));
      });
    }
    return myList;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  getEvent() {
    List<CustomSchoolCalenderModel> finalList = events();
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
          hashCode: getHashCode,
        )..addAll(kEventSource);
      }
    }
    return kEvents;
  }
}
