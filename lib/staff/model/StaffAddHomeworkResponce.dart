// To parse this JSON data, do
//
//     final staffAddHomeworkResponce = staffAddHomeworkResponceFromJson(jsonString);

import 'dart:convert';

StaffAddHomeworkResponce staffAddHomeworkResponceFromJson(String str) => StaffAddHomeworkResponce.fromJson(json.decode(str));

String staffAddHomeworkResponceToJson(StaffAddHomeworkResponce data) => json.encode(data.toJson());

class StaffAddHomeworkResponce {
  StaffAddHomeworkResponce({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  ResponceData? data;

  factory StaffAddHomeworkResponce.fromJson(Map<String, dynamic> json) => StaffAddHomeworkResponce(
    status: json["status"],
    code: json["code"],
    data: ResponceData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data!.toJson(),
  };
}

class ResponceData {
  ResponceData({
    this.id,
    this.code,
    this.date,
    this.title,
    this.description,
    this.createdByName,
    this.edit,
    this.approvalType,
    this.staffHomeworkApprovalType,
    this.images,
  });

  int? id;
  String? code;
  String? date;
  String? title;
  String? description;
  String? createdByName;
  bool? edit;
  int? approvalType;
  int? staffHomeworkApprovalType;
  dynamic images;

  factory ResponceData.fromJson(Map<String, dynamic> json) => ResponceData(
    id: json["id"],
    code: json["code"],
    date: json["date"],
    title: json["title"],
    description: json["description"],
    createdByName: json["created_by_name"],
    edit: json["edit"],
    approvalType: json["approval_type"],
    staffHomeworkApprovalType: json["staff_homework_approval_type"],
    images: json["images"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "date": date,
    "title": title,
    "description": description,
    "created_by_name": createdByName,
    "edit": edit,
    "approval_type": approvalType,
    "staff_homework_approval_type": staffHomeworkApprovalType,
    "images": images,
  };
}
