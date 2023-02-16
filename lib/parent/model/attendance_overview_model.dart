// To parse this JSON data, do
//
//     final attendanceOverviewModel = attendanceOverviewModelFromJson(jsonString);

import 'dart:convert';

AttendanceOverviewModel attendanceOverviewModelFromJson(String str) => AttendanceOverviewModel.fromJson(json.decode(str));

String attendanceOverviewModelToJson(AttendanceOverviewModel data) => json.encode(data.toJson());

class AttendanceOverviewModel {
  AttendanceOverviewModel({
    required this.status,
    required this.code,
    required this.attendanceOverviewData,
  });

  String status;
  int code;
  AttendanceOverViewData attendanceOverviewData;

  factory AttendanceOverviewModel.fromJson(Map<String, dynamic> json) => AttendanceOverviewModel(
    status: json["status"],
    code: json["code"],
    attendanceOverviewData: AttendanceOverViewData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": attendanceOverviewData.toJson(),
  };
}

class AttendanceOverViewData {
  AttendanceOverViewData({
    required this.todayAttendance,
    required this.noOfWorkingDays,
    required this.present,
    required this.absent,
    required this.absentDetail,
    required this.percentage,
  });

  dynamic todayAttendance;
  int noOfWorkingDays;
  double present;
  double absent;
  AbsentDetail absentDetail;
  String percentage;

  factory AttendanceOverViewData.fromJson(Map<String, dynamic> json) => AttendanceOverViewData(
    todayAttendance: json["today_attendance"]!=null?TodayAttendance.fromJson(json["today_attendance"]):null,
    noOfWorkingDays: json["no_of_working_days"],
    present: json["present"]?.toDouble(),
    absent: json["absent"]?.toDouble(),
    absentDetail: AbsentDetail.fromJson(json["absent_detail"]),
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "today_attendance": todayAttendance.toJson(),
    "no_of_working_days": noOfWorkingDays,
    "present": present,
    "absent": absent,
    "absent_detail": absentDetail.toJson(),
    "percentage": percentage,
  };
}

class AbsentDetail {
  AbsentDetail({
    required this.fullDay,
    required this.haftDay,
    required this.morningHaftDay,
    required this.eveningHaftDay,
  });

  int fullDay;
  int haftDay;
  int morningHaftDay;
  int eveningHaftDay;

  factory AbsentDetail.fromJson(Map<String, dynamic> json) => AbsentDetail(
    fullDay: json["full_day"],
    haftDay: json["haft_day"],
    morningHaftDay: json["morning_haft_day"],
    eveningHaftDay: json["evening_haft_day"],
  );

  Map<String, dynamic> toJson() => {
    "full_day": fullDay,
    "haft_day": haftDay,
    "morning_haft_day": morningHaftDay,
    "evening_haft_day": eveningHaftDay,
  };
}

class TodayAttendance {
  TodayAttendance({
    required this.leaveTypeId,
    required this.leaveType,
    this.remark,
    required this.type,
  });

  int leaveTypeId;
  String leaveType;
  dynamic remark;
  int type;

  factory TodayAttendance.fromJson(Map<String, dynamic> json) => TodayAttendance(
    leaveTypeId: json["leave_type_id"],
    leaveType: json["leave_type"],
    remark: json["remark"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "leave_type_id": leaveTypeId,
    "leave_type": leaveType,
    "remark": remark,
    "type": type,
  };
}
