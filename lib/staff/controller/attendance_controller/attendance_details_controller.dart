import 'package:flutter/material.dart';
import 'package:flutter_projects/staff/view/screens/payroll/staff_attendance/staff_attendance_details_screen.dart';
import 'package:get/get.dart';
import '../../../common/common_model/atendance_calender_model.dart';
import '../../../common/const/colors.dart';
import '../../../common/services/base_client.dart';
import '../../../parent/model/LeaveListModel.dart';
import '../../../parent/model/attendance_model.dart';
import '../../../parent/model/leave_create_responce_model.dart';
import '../../../parent/view/screens/daily_actvities/attendance/attendance_details_screen.dart';
import '../../model/StaffAttendanceDisplayModel.dart';

class StaffAttendanceDetailsController extends GetxController {
  DateTime? currentDate;
  String startDate = "";
  String endDate = "";
  String selectedLeaveType = 'Select Leave Type';
  bool openDialogValue = false;
  int? editFlag;
  int? leaveRequestId;
  double? noOfLeave;
  AttendanceModel? attendanceModel;
  ScrollController scrollController = ScrollController();
  LeaveListModel? leaveListModel;
  List<LeaveListData> finalList = <LeaveListData>[].obs;
  final isLoading = true.obs;
  LeaveCreateResponceModel? leaveCreateResponceModel;
  int? selectedLeaveTypeValue = -1;
  List<String> selectedLeaveList1 = [
    'Select Leave Type',
    'Full Day',
    'AN leave Start date',
    'MN leave to End date',
    "AN leave in Start date & MN leave in End date"
  ];
  List<String> selectedLeaveList2 = [
    'Select Leave Type',
    'Full Day',
    'AN leave Start date',
    'MN leave to End date',
  ];
  List<ChartDatas>? chartDatas;

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

  StaffAttendanceDisplayModel? staffAttendanceDisplayModel;

  @override
  void onInit() {
    super.onInit();
    chartDatas = [
      ChartDatas('Present', 0, const Color.fromRGBO(255, 189, 57, 1)),
      ChartDatas('Absent', 0, const Color.fromRGBO(9, 0, 136, 1)),
    ];
    attendanceData();
  }

  Future attendanceData() async {
    final result = await BaseService().getMethod(
        "https://test.schoolec.in/api/staff/v2/payroll/attendance/list?leave_type=1");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          staffAttendanceDisplayModel = StaffAttendanceDisplayModel.fromJson(result.data);
          chartDatas = [
            ChartDatas('Present ${staffAttendanceDisplayModel?.data?.present ?? 0}',
                attendanceModel?.data?.present.toInt() ?? 0,AppColors.darkGreenColor),
            ChartDatas('Absent ${attendanceModel?.data?.absent ?? 0}',
                attendanceModel?.data?.absent.toInt() ?? 0, AppColors.darkPinkColor),
          ];
          print("attendanceData: ${result.statusCode}");
        } else {
          print("attendanceData: ${result.statusCode}");
        }
      }
    } catch (e) {
      print("attendanceData $e");
    } finally {}
    update();
  }


}
