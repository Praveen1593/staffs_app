import 'dart:convert';

ClassTimeTableModel classTimeTableModelFromJson(String str) =>
    ClassTimeTableModel.fromJson(json.decode(str));

String classTimeTableModelToJson(ClassTimeTableModel data) =>
    json.encode(data.toJson());

class ClassTimeTableModel {
  ClassTimeTableModel(
      {required this.status, required this.code, this.cttData, this.error});

  String status;
  int code;
  CTTData? cttData;
  String? error;

  factory ClassTimeTableModel.fromJson(Map<String, dynamic> json) =>
      ClassTimeTableModel(
        status: json["status"],
        code: json["code"],
        cttData: CTTData.fromJson(json["data"]),
        error: json.containsKey("error") ? json["error"] : "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": cttData!.toJson(),
      };
}

class CTTData {
  CTTData({
    this.id,
    this.standardId,
    this.groupSectionId,
    this.periodScheduleId,
    this.periodScheduleType,
    this.onlineScheduleId,
    this.onlineScheduleType,
    this.periodSchedule,
    this.onlineSchedule,
    this.subjectStaff,
    this.regularStaffList,
    this.onlineStaffList,
  });

  int? id;
  int? standardId;
  int? groupSectionId;
  int? periodScheduleId;
  int? periodScheduleType;
  int? onlineScheduleId;
  int? onlineScheduleType;
  String? periodSchedule;
  String? onlineSchedule;
  String? subjectStaff;
  String? regularStaffList;
  String? onlineStaffList;

  factory CTTData.fromJson(Map<String, dynamic> json) => CTTData(
        id: json["id"],
        standardId: json["standard_id"],
        groupSectionId: json["group_section_id"],
        periodScheduleId: json["period_schedule_id"],
        periodScheduleType: json["period_schedule_type"],
        onlineScheduleId: json["online_schedule_id"],
        onlineScheduleType: json["online_schedule_type"],
        periodSchedule: json["period_schedule"],
        onlineSchedule: json["online_schedule"],
        subjectStaff: json["subject_staff"],
        regularStaffList: json["regular_staff_list"],
        onlineStaffList: json["online_staff_list"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "standard_id": standardId,
        "group_section_id": groupSectionId,
        "period_schedule_id": periodScheduleId,
        "period_schedule_type": periodScheduleType,
        "online_schedule_id": onlineScheduleId,
        "online_schedule_type": onlineScheduleType,
        "period_schedule": periodSchedule,
        "online_schedule": onlineSchedule,
        "subject_staff": subjectStaff,
        "regular_staff_list": regularStaffList,
        "online_staff_list": onlineStaffList,
      };
}
