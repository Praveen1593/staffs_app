// To parse this JSON data, do
//
//     final classTestReplyListModel = classTestReplyListModelFromJson(jsonString);

import 'dart:convert';

ClassTestReplyListModel classTestReplyListModelFromJson(String str) => ClassTestReplyListModel.fromJson(json.decode(str));

String classTestReplyListModelToJson(ClassTestReplyListModel data) => json.encode(data.toJson());

class ClassTestReplyListModel {
  ClassTestReplyListModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  List<ClassTestReplyListData>? data;

  factory ClassTestReplyListModel.fromJson(Map<String, dynamic> json) => ClassTestReplyListModel(
    status: json["status"],
    code: json["code"],
    data: List<ClassTestReplyListData>.from(json["data"].map((x) => ClassTestReplyListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ClassTestReplyListData {
  ClassTestReplyListData({
    this.id,
    this.code,
    this.date,
    this.title,
    this.description,
    this.createdByName,
    this.edit,
    this.approvalType,
    this.staffClassTestApprovalType,
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
  int? staffClassTestApprovalType;
  dynamic images;

  factory ClassTestReplyListData.fromJson(Map<String, dynamic> json) => ClassTestReplyListData(
    id: json["id"],
    code: json["code"],
    date: json["date"],
    title: json["title"],
    description: json["description"],
    createdByName: json["created_by_name"],
    edit: json["edit"],
    approvalType: json["approval_type"],
    staffClassTestApprovalType: json["staff_class_test_approval_type"],
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
    "staff_class_test_approval_type": staffClassTestApprovalType,
    "images": images,
  };
}
