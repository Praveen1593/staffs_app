import 'dart:convert';

StaffDashboardAttendanceOverallModel staffDashboardAttendanceOverallModelFromJson(String str) => StaffDashboardAttendanceOverallModel.fromJson(json.decode(str));

String staffDashboardAttendanceOverallModelToJson(StaffDashboardAttendanceOverallModel data) => json.encode(data.toJson());

class StaffDashboardAttendanceOverallModel {
  StaffDashboardAttendanceOverallModel({
    required this.status,
    required this.code,
    this.dAttendanceOveralldata,
  });

  String status;
  int code;
  DAttendanceAllData? dAttendanceOveralldata;

  factory StaffDashboardAttendanceOverallModel.fromJson(Map<String, dynamic> json) => StaffDashboardAttendanceOverallModel(
    status: json["status"],
    code: json["code"],
    dAttendanceOveralldata: DAttendanceAllData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": dAttendanceOveralldata!.toJson(),
  };
}

class DAttendanceAllData {
  DAttendanceAllData({
    this.todayAttendance,
    this.noOfWorkingDays,
    this.present,
    this.absent,
    this.absentDetail,
    this.percentage,
    this.leaveList,
  });

  dynamic todayAttendance;
  int? noOfWorkingDays;
  double? present;
  double? absent;
  AbsentDetail? absentDetail;
  String? percentage;
  List<LeaveList>? leaveList;

  factory DAttendanceAllData.fromJson(Map<String, dynamic> json) => DAttendanceAllData(
    todayAttendance: json["today_attendance"],
    noOfWorkingDays: json["no_of_working_days"],
    present: json["present"].toDouble(),
    absent: json["absent"].toDouble(),
    absentDetail: AbsentDetail.fromJson(json["absent_detail"]),
    percentage: json["percentage"],
    leaveList: List<LeaveList>.from(json["leave_list"].map((x) => LeaveList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "today_attendance": todayAttendance,
    "no_of_working_days": noOfWorkingDays,
    "present": present,
    "absent": absent,
    "absent_detail": absentDetail!.toJson(),
    "percentage": percentage,
    "leave_list": List<dynamic>.from(leaveList!.map((x) => x.toJson())),
  };
}

class AbsentDetail {
  AbsentDetail({
    this.fullDay,
    this.haftDay,
    this.morningHaftDay,
    this.eveningHaftDay,
    this.total,
  });

  int? fullDay;
  int? haftDay;
  int? morningHaftDay;
  int? eveningHaftDay;
  int? total;

  factory AbsentDetail.fromJson(Map<String, dynamic> json) => AbsentDetail(
    fullDay: json["full_day"],
    haftDay: json["haft_day"],
    morningHaftDay: json["morning_haft_day"],
    eveningHaftDay: json["evening_haft_day"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "full_day": fullDay,
    "haft_day": haftDay,
    "morning_haft_day": morningHaftDay,
    "evening_haft_day": eveningHaftDay,
    "total": total == null ? null : total,
  };
}

class LeaveList {
  LeaveList({
    this.id,
    this.name,
    this.fullName,
    this.absentDetail,
  });

  int? id;
  String? name;
  String? fullName;
  AbsentDetail? absentDetail;

  factory LeaveList.fromJson(Map<String, dynamic> json) => LeaveList(
    id: json["id"],
    name: json["name"],
    fullName: json["full_name"],
    absentDetail: AbsentDetail.fromJson(json["absent_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "full_name": fullName,
    "absent_detail": absentDetail!.toJson(),
  };
}
