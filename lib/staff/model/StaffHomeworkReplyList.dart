// To parse this JSON data, do
//
//     final staffHomeworkReplyList = staffHomeworkReplyListFromJson(jsonString);

import 'dart:convert';

StaffHomeworkReplyList staffHomeworkReplyListFromJson(String str) => StaffHomeworkReplyList.fromJson(json.decode(str));

String staffHomeworkReplyListToJson(StaffHomeworkReplyList data) => json.encode(data.toJson());

class StaffHomeworkReplyList {
  StaffHomeworkReplyList({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  List<ReplyListData>? data;

  factory StaffHomeworkReplyList.fromJson(Map<String, dynamic> json) => StaffHomeworkReplyList(
    status: json["status"],
    code: json["code"],
    data: List<ReplyListData>.from(json["data"].map((x) => ReplyListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ReplyListData {
  ReplyListData({
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

  factory ReplyListData.fromJson(Map<String, dynamic> json) => ReplyListData(
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
