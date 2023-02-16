// To parse this JSON data, do
//
//     final subjectTeacherStandardListModel = subjectTeacherStandardListModelFromJson(jsonString);

import 'dart:convert';

SubjectTeacherStandardListModel subjectTeacherStandardListModelFromJson(String str) => SubjectTeacherStandardListModel.fromJson(json.decode(str));

String subjectTeacherStandardListModelToJson(SubjectTeacherStandardListModel data) => json.encode(data.toJson());

class SubjectTeacherStandardListModel {
  SubjectTeacherStandardListModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  List<StandardList>? data;

  factory SubjectTeacherStandardListModel.fromJson(Map<String, dynamic> json) => SubjectTeacherStandardListModel(
    status: json["status"],
    code: json["code"],
    data: List<StandardList>.from(json["data"].map((x) => StandardList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StandardList {
  StandardList({
    this.id,
    this.code,
    this.name,
    this.fullName,
    this.type,
    this.section,
  });

  int? id;
  String? code;
  String? name;
  String? fullName;
  int? type;
  List<Section>? section;

  factory StandardList.fromJson(Map<String, dynamic> json) => StandardList(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    fullName: json["full_name"],
    type: json["type"],
    section: List<Section>.from(json["section"].map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "full_name": fullName,
    "type": type,
    "section": List<dynamic>.from(section!.map((x) => x.toJson())),
  };
}

class Section {
  Section({
    this.id,
    this.code,
    this.standardId,
    this.name,
    this.fullName,
    this.type,
    this.studentCount,
  });

  int? id;
  String? code;
  int? standardId;
  String? name;
  String? fullName;
  int? type;
  dynamic studentCount;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    code: json["code"],
    standardId: json["standard_id"],
    name: json["name"],
    fullName: json["full_name"],
    type: json["type"],
    studentCount: json["student_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "standard_id": standardId,
    "name": name,
    "full_name": fullName,
    "type": type,
    "student_count": studentCount,
  };
}
