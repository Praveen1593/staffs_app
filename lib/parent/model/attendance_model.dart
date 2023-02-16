// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) => AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) => json.encode(data.toJson());

class AttendanceModel {
  AttendanceModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  AttendanceData? data;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    status: json["status"],
    code: json["code"],
    data: AttendanceData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data?.toJson(),
  };
}

class AttendanceData {
  AttendanceData({
    this.todayAttendance,
    this.noOfWorkingDays,
    this.present,
    this.absent,
    this.absentDetail,
    this.percentage,
  });

  dynamic todayAttendance;
  dynamic noOfWorkingDays;
  dynamic present;
  dynamic absent;
  AbsentDetail? absentDetail;
  String? percentage;

  factory AttendanceData.fromJson(Map<String, dynamic> json) => AttendanceData(
    todayAttendance: json["today_attendance"],
    noOfWorkingDays: json["no_of_working_days"],
    present: json["present"],
    absent: json["absent"],
    absentDetail: AbsentDetail.fromJson(json["absent_detail"]),
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "today_attendance": todayAttendance,
    "no_of_working_days": noOfWorkingDays,
    "present": present,
    "absent": absent,
    "absent_detail": absentDetail!.toJson(),
    "percentage": percentage,
  };
}

class AbsentDetail {
  AbsentDetail({
    this.fullDay,
    this.haftDay,
    this.morningHaftDay,
    this.eveningHaftDay,
  });

  int? fullDay;
  int? haftDay;
  int? morningHaftDay;
  int? eveningHaftDay;

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
