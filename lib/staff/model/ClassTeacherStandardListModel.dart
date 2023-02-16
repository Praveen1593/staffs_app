// To parse this JSON data, do
//
//     final classTeacherStandardListModel = classTeacherStandardListModelFromJson(jsonString);

import 'dart:convert';

ClassTeacherStandardListModel classTeacherStandardListModelFromJson(String str) => ClassTeacherStandardListModel.fromJson(json.decode(str));

String classTeacherStandardListModelToJson(ClassTeacherStandardListModel data) => json.encode(data.toJson());

class ClassTeacherStandardListModel {
  ClassTeacherStandardListModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  List<ClassTeacherStandardData>? data;

  factory ClassTeacherStandardListModel.fromJson(Map<String, dynamic> json) => ClassTeacherStandardListModel(
    status: json["status"],
    code: json["code"],
    data: List<ClassTeacherStandardData>.from(json["data"].map((x) => ClassTeacherStandardData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ClassTeacherStandardData {
  ClassTeacherStandardData({
    this.id,
    this.name,
    this.standardId,
    this.standardName,
    this.groupSectionId,
    this.groupSectionName,
  });

  int? id;
  String? name;
  int? standardId;
  String? standardName;
  int? groupSectionId;
  String? groupSectionName;

  factory ClassTeacherStandardData.fromJson(Map<String, dynamic> json) => ClassTeacherStandardData(
    id: json["id"],
    name: json["name"],
    standardId: json["standard_id"],
    standardName: json["standard_name"],
    groupSectionId: json["group_section_id"],
    groupSectionName: json["group_section_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "standard_id": standardId,
    "standard_name": standardName,
    "group_section_id": groupSectionId,
    "group_section_name": groupSectionName,
  };
}
