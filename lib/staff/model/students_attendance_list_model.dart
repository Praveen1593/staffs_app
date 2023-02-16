import 'dart:convert';

import 'package:flutter/material.dart';

StudentsAttendanceListModel studentsAttendanceListModelFromJson(String str) =>
    StudentsAttendanceListModel.fromJson(json.decode(str));

String studentsAttendanceListModelToJson(StudentsAttendanceListModel data) =>
    json.encode(data.toJson());

class StudentsAttendanceListModel {
  StudentsAttendanceListModel({
    required this.status,
    required this.code,
    this.studentsAttendanceData,
  });

  String status;
  int code;
  List<StudentsAttendanceData>? studentsAttendanceData;

  factory StudentsAttendanceListModel.fromJson(Map<String, dynamic> json) =>
      StudentsAttendanceListModel(
        status: json["status"],
        code: json["code"],
        studentsAttendanceData: List<StudentsAttendanceData>.from(
            json["data"].map((x) => StudentsAttendanceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data":
            List<dynamic>.from(studentsAttendanceData!.map((x) => x.toJson())),
      };
}

class StudentsAttendanceData {
  StudentsAttendanceData(
      {this.id,
      this.studentId,
      this.firstName,
      this.phoneNo,
      this.fatherName,
      this.motherName,
      this.standardSection,
      this.attendance,
        this.photo,
      this.flag = 1,
      this.remarkFlag = false,
      this.remarkText = "",
      this.lateComer = false,
      this.time = "ENTER TIME"});

  int? id;
  int? studentId;
  String? firstName;
  dynamic phoneNo;
  String? fatherName;
  String? motherName;
  String? standardSection;
  Attendance? attendance;
  String? photo;
  int flag;
  bool remarkFlag;
  String remarkText;
  bool lateComer;
  String time;

  factory StudentsAttendanceData.fromJson(Map<String, dynamic> json) =>
      StudentsAttendanceData(
        id: json["id"],
        studentId: json["student_id"],
        firstName: json["first_name"],
        phoneNo: json["phone_no"],
        fatherName: json["father_name"],
        motherName: json["mother_name"] ?? "",
        standardSection: json["standard_section"],
        attendance: json["attendance"] == null
            ? null
            : Attendance.fromJson(json["attendance"]),
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "first_name": firstName,
        "phone_no": phoneNo,
        "father_name": fatherName,
        "mother_name": motherName ?? "",
        "standard_section": standardSection,
        "attendance": attendance == null ? null : attendance!.toJson(),
      };
}

class Attendance {
  Attendance({
    this.lateAtt,
    this.lateTime,
    this.remark,
    this.leaveTypeId,
    this.leaveName,
  });

  int? lateAtt;
  String? lateTime;
  String? remark;
  int? leaveTypeId;
  String? leaveName;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        lateAtt: json["late_att"],
        lateTime: json["late_time"],
        remark: json["remark"] ?? "",
        leaveTypeId: json["leave_type_id"],
        leaveName: json["leave_name"],
      );

  Map<String, dynamic> toJson() => {
        "late_att": lateAtt,
        "late_time": lateTime,
        "remark": remark ?? "",
        "leave_type_id": leaveTypeId,
        "leave_name": leaveName,
      };
}
