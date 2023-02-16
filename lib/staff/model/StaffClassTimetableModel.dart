// To parse this JSON data, do
//
//     final staffClassTimetableModel = staffClassTimetableModelFromJson(jsonString);

import 'dart:convert';

StaffClassTimetableModel staffClassTimetableModelFromJson(String str) => StaffClassTimetableModel.fromJson(json.decode(str));

String staffClassTimetableModelToJson(StaffClassTimetableModel data) => json.encode(data.toJson());

class StaffClassTimetableModel {
  StaffClassTimetableModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  Data? data;

  factory StaffClassTimetableModel.fromJson(Map<String, dynamic> json) => StaffClassTimetableModel(
    status: json["status"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.periodSchedule,
    this.onlineSchedule,
    this.staffSubject,
  });

  String? periodSchedule;
  String? onlineSchedule;
  String? staffSubject;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    periodSchedule: json["period_schedule"],
    onlineSchedule: json["online_schedule"],
    staffSubject: json["staff_subject"],
  );

  Map<String, dynamic> toJson() => {
    "period_schedule": periodSchedule,
    "online_schedule": onlineSchedule,
    "staff_subject": staffSubject,
  };
}
