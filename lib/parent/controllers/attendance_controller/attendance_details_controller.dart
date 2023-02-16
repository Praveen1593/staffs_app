import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../common/apihelper/api_helper.dart';
import '../../../common/common_model/atendance_calender_model.dart';
import '../../../common/const/colors.dart';
import '../../../common/enums/loading_enums.dart';
import '../../../common/services/base_client.dart';
import '../../model/LeaveListModel.dart';
import '../../model/attendance_model.dart';
import '../../model/leave_create_responce_model.dart';
import '../../view/dialogs/dialog_helper.dart';
import '../../view/screens/daily_actvities/attendance/attendance_details_screen.dart';
import '../../../storage.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../model/month_list_model.dart';

class AttendanceDetailsController extends GetxController {
  DateTime? currentDate;
  String startDate = "";
  String endDate = "";
  String selectedLeaveType = 'Select Type';
  bool openDialogValue = false;
  int? editFlag;
  int? leaveRequestId;
  double? noOfLeave;
  AttendanceModel? attendanceModel;
  final loadingState =
      LeaveListLoadingState(loadingType: LoadingType.stable).obs;
  ScrollController scrollController = ScrollController();
  int _pageNo = 1;
  LeaveListModel? leaveListModel;
  List<LeaveListData> finalList = <LeaveListData>[].obs;
  final isLoading = true.obs;
  LeaveCreateResponceModel? leaveCreateResponceModel;
  int? selectedLeaveTypeValue = -1;
  List<String> selectedLeaveList1 = [
    'Select Type',
    'Full Day',
    'AN leave Start date',
    'MN leave to End date',
    "AN leave in Start date & MN leave in End date"
  ];
  List<String> selectedLeaveList2 = [
    'Select Type',
    'Full Day',
    'AN leave Start date',
    'MN leave to End date',
  ];
  List<ChartData> chartData = [];

  int? numLeave = 1;

  TextEditingController noOfLeaves = TextEditingController();
  TextEditingController leaveDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int? currentMonthId;
  List<AttendanceCalenderData> attendanceCalenderData = [];
  final kToday = DateTime.now();
  List<DateTime> noOfDays = [];
  bool loader = false;

  @override
  void onInit() {
    super.onInit();
    startDate = "";
    endDate = "";
    // leaveDateController.text = DateFormat('yyyy-MM-dd').format(currentDate);
    chartData = [
      ChartData('Present', 0, const Color.fromRGBO(255, 189, 57, 1)),
      ChartData('Absent', 0, const Color.fromRGBO(9, 0, 136, 1)),
    ];
    fetchMonthList(DateFormat("MMMM").format(DateTime.now()));
    getData();
    scrollController.addListener(_scrollListener);
  }

  Future getLeaveListData() async {
    if (_pageNo == 1) {
      isLoading.value = true;
    }
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.leaveListUrl}student_id=${LocalStorage.getValue("studentId")}&page=${_pageNo}");
      if (result != null) {
        if (result.statusCode == 200) {
          leaveListModel = LeaveListModel.fromJson(result.data);
          finalList.assignAll(leaveListModel?.data ?? []);
          isLoading.value = false;
        } else {
          print("Leave list : ${result.statusCode}");
        }
      }
    } catch (e) {
      print("Leave list $e");
    } finally {}
    update();
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value =
          LeaveListLoadingState(loadingType: LoadingType.loading);
      try {
        List<LeaveListData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await getLeaveListData();

        if (listOfData.isEmpty) {
          loadingState.value = LeaveListLoadingState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          finalList.addAll(listOfData);
          loadingState.value =
              LeaveListLoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value = LeaveListLoadingState(
            loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  Future<LeaveCreateResponceModel?> leaveRequestCreate(
      String url, int type, Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    try {
      //dynamic result;
      final result = await BaseService().postMethod(userData, url);
      /*if(type==1){
        result = await BaseService().postData(userData,"$baseUrl${ApiHelper.leaveCreateUrl}");
      }else{

      }*/

      if (result != null) {
        if (result.statusCode == 200) {
          leaveCreateResponceModel = LeaveCreateResponceModel.fromJson(result.data);
        } else {
          /*leaveCreateResponceModel = LeaveCreateResponceModel(
              status: "Failed",
              code: 400,
              message: result.data.containsKey("message")
                  ? result.data["message"]
                  : "");*/

          print("leaveRequestEdit ${result.statusCode}");
        }
      }
    } catch (e) {
      print('leaveRequestEdit $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return leaveCreateResponceModel;
  }

  Future getData() async {
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.attendanceUrl}student_id=${LocalStorage.getValue("studentId")}");
      if (result != null) {
        if (result.statusCode == 200) {
          attendanceModel = AttendanceModel.fromJson(result.data);
          chartData = [
            ChartData('Present ${attendanceModel?.data?.present ?? 0}',
                attendanceModel?.data?.present.toInt() ?? 0, AppColors.darkGreenColor),
            ChartData('Absent ${attendanceModel?.data?.absent ?? 0}',
                attendanceModel?.data?.absent.toInt() ?? 0, AppColors.darkPinkColor),
          ];
        }
      }
    } catch (e) {
      print("Fee Invoice $e");
    } finally {}
    update();
  }

  updateOpenDialogValue(bool value) {
    openDialogValue = value;
    update();
  }

  void updateSelectedLeaveType(List<String> list, String selectedIndex) {
    selectedLeaveType = selectedIndex;
    List.generate(list.length, (index) {
      if (list[index] == selectedLeaveType) {
        if (index == 1) {
          selectedLeaveTypeValue = 0;
        } else if (index == 2) {
          selectedLeaveTypeValue = 1;
        } else if (index == 3) {
          selectedLeaveTypeValue = 2;
        } else if (index == 4) {
          selectedLeaveTypeValue = 3;
        } else {
          selectedLeaveTypeValue = -1;
        }
      }
    });
    update();
  }

  Future<DateTime?> selectDate(BuildContext context) async {
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
                primary: Color(0XFF407BFF), // <-- SEE HERE
                onPrimary: AppColors.whiteColor, // <-- SEE HERE
                surface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        });
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
      startDate = DateFormat('yyyy-MM-dd').format(currentDate ?? DateTime.now());
      leaveDateController.text = currentDate.toString();
      leaveDateController.text = DateFormat('yyyy-MM-dd').format(currentDate ?? DateTime.now());
      update();
      return currentDate;
    }
  }

  Future<DateTimeRange?> dateRangeDialog(BuildContext context) async {
    DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2022, 1, 1),
        lastDate: DateTime(2070, 12, 31),
        currentDate: DateTime.now(),
        saveText: 'SAVE',
        useRootNavigator: false,
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

    if (result != null) {
      startDate = result.start.toString().split(' ')[0];
      endDate = result.end.toString().split(' ')[0];
      noOfLeaves.text = result.end.difference(result.start).inDays.toString();
      startDateController.text = startDate;
      endDateController.text = endDate;
      update();
      return result;
    }
    return null;
  }

  Future fetchMonthList(String month) async {
    try {
      final result = await BaseService().getMethod(ApiHelper.monthListUrl);
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
    loader = true;
    try {
      final result = await BaseService().getMethod(
          "${ApiHelper.attendanceMonthWiseUrl}student_id=${LocalStorage.getValue("studentId")}&month_list_id=10");
      if (result != null) {
        if (result.statusCode == 200) {
          loader = false;
          AttendanceCalenderModel calenderModel =
              AttendanceCalenderModel.fromJson(result.data);
          attendanceCalenderData = calenderModel.attendanceData ?? [];
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    } finally {
      loader = false;
    }
    update();
  }

  getEvent() {
    Map kEvents = {};
    if (attendanceCalenderData.isNotEmpty) {
      Map<DateTime, List<AttendanceCalenderData>> kEventSource = {};
      for (var i = 0; i < attendanceCalenderData.length; i++) {
        DateTime dateTime = DateFormat("dd-MMM-yyyy").parse(attendanceCalenderData[i].date.toString());
        kEventSource.addAll({
          DateTime.utc(dateTime.year, dateTime.month, dateTime.day): [
            attendanceCalenderData[i]
          ]
        });
        kEvents = LinkedHashMap<DateTime, List<AttendanceCalenderData>>(
          equals: isSameDay,
          hashCode: getHashCode,
        )..addAll(kEventSource);
      }
    }
    return kEvents;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
