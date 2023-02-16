// To parse this JSON data, do
//
//     final leaveCreateResponceModel = leaveCreateResponceModelFromJson(jsonString);

import 'dart:convert';

LeaveCreateResponceModel leaveCreateResponceModelFromJson(String str) => LeaveCreateResponceModel.fromJson(json.decode(str));

String leaveCreateResponceModelToJson(LeaveCreateResponceModel data) => json.encode(data.toJson());

class LeaveCreateResponceModel {
  LeaveCreateResponceModel({
    required this.status,
    required this.code,
    this.data,
    this.message,
  });

  String status;
  int code;
  LeaveCreateData? data;
  String? message;

  factory LeaveCreateResponceModel.fromJson(Map<String, dynamic> json) => LeaveCreateResponceModel(
    status: json["status"],
    code: json["code"],
    data: LeaveCreateData.fromJson(json["data"],
    message: json.containsKey("message") ? json["message"] : ""),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data!.toJson(),
  };
}

class LeaveCreateData {
  LeaveCreateData({
    this.id,
    this.uuid,
    this.studentId,
    this.studentName,
    this.academicStudentId,
    this.applyDate,
    this.startDate,
    this.endDate,
    this.total,
    this.description,
    this.rejectRemark,
    this.halfDayLeave,
    this.status,
    this.statusName,
  });

  int? id;
  String? uuid;
  int? studentId;
  String? studentName;
  int? academicStudentId;
  String? applyDate;
  String? startDate;
  String? endDate;
  int? total;
  String? description;
  dynamic rejectRemark;
  String? halfDayLeave;
  int? status;
  String? statusName;

  factory LeaveCreateData.fromJson(Map<String, dynamic> json, {required message}) => LeaveCreateData(
    id: json["id"],
    uuid: json["uuid"],
    studentId: json["student_id"],
    studentName: json["student_name"],
    academicStudentId: json["academic_student_id"],
    applyDate: json["apply_date"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    total: json["total"],
    description: json["description"],
    rejectRemark: json["reject_remark"],
    halfDayLeave: json["half_day_leave"],
    status: json["status"] ?? -1,
    statusName: json["status_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "student_id": studentId,
    "student_name": studentName,
    "academic_student_id": academicStudentId,
    "apply_date": applyDate,
    "start_date": startDate,
    "end_date": endDate,
    "total": total,
    "description": description,
    "reject_remark": rejectRemark,
    "half_day_leave": halfDayLeave,
    "status": status,
    "status_name": statusName,
  };
}
