import 'dart:convert';

AttendanceCalenderModel attendanceCalenderModelFromJson(String str) => AttendanceCalenderModel.fromJson(json.decode(str));

String attendanceCalenderModelToJson(AttendanceCalenderModel data) => json.encode(data.toJson());

class AttendanceCalenderModel {
  AttendanceCalenderModel({
    this.attendanceData,
    required this.code,
    required this.status,
    this.msg,
    this.percentage,
  });

  List<AttendanceCalenderData>? attendanceData;
  int? code;
  String status;
  String? msg;
  Percentage? percentage;

  factory AttendanceCalenderModel.fromJson(Map<String, dynamic> json) => AttendanceCalenderModel(
    attendanceData: List<AttendanceCalenderData>.from(json["data"].map((x) => AttendanceCalenderData.fromJson(x))),
    code: json["code"],
    status: json["status"],
    msg: json["msg"],
    percentage: Percentage.fromJson(json["percentage"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(attendanceData!.map((x) => x.toJson())),
    "code": code,
    "status": status,
    "msg": msg,
    "percentage": percentage!.toJson(),
  };
}

class AttendanceCalenderData {
  AttendanceCalenderData({
    this.id,
    this.date,
    this.leaveTypeId,
    this.leaveType,
    this.remark,
    this.createdAt,
  });

  int? id;
  String? date;
  int? leaveTypeId;
  String? leaveType;
  dynamic remark;
  String? createdAt;

  factory AttendanceCalenderData.fromJson(Map<String, dynamic> json) => AttendanceCalenderData(
    id: json["id"],
    date: json["date"],
    leaveTypeId: json["leave_type_id"],
    leaveType: json["leave_type"],
    remark: json["remark"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "leave_type_id": leaveTypeId,
    "leave_type": leaveType,
    "remark": remark,
    "created_at": createdAt,
  };
}

class Percentage {
  Percentage({
    this.noOfWorkingDays,
    this.present,
    this.absent,
    this.absentDetail,
    this.percentage,
  });

  int? noOfWorkingDays;
  int? present;
  int? absent;
  AbsentDetail? absentDetail;
  String? percentage;

  factory Percentage.fromJson(Map<String, dynamic> json) => Percentage(
    noOfWorkingDays: json["no_of_working_days"],
    present: json["present"],
    absent: json["absent"],
    absentDetail: AbsentDetail.fromJson(json["absent_detail"]),
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
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
