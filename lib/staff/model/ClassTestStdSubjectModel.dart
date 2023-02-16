// To parse this JSON data, do
//
//     final classTestStdSubjectModel = classTestStdSubjectModelFromJson(jsonString);

import 'dart:convert';

ClassTestStdSubjectModel classTestStdSubjectModelFromJson(String str) => ClassTestStdSubjectModel.fromJson(json.decode(str));

String classTestStdSubjectModelToJson(ClassTestStdSubjectModel data) => json.encode(data.toJson());

class ClassTestStdSubjectModel {
  ClassTestStdSubjectModel({
    required this.status,
    required this.code,
    required this.data,
  });

  String status;
  int code;
  List<Datum> data;

  factory ClassTestStdSubjectModel.fromJson(Map<String, dynamic> json) => ClassTestStdSubjectModel(
    status: json["status"],
    code: json["code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.standardSubjectId,
    this.subjectListId,
    this.subject,
    this.examType,
    this.examMarkTypeId,
    this.practicalType,
    this.practicalMark,
    this.examMark,
    this.staffAssignType,
    this.subjectType,
    this.baseType,
    this.oldBaseType,
    this.languageType,
    this.rootExamType,
    this.rootStaffAssignType,
    this.children,
  });

  int? id;
  int? standardSubjectId;
  int? subjectListId;
  Subject? subject;
  int? examType;
  int? examMarkTypeId;
  int? practicalType;
  int? practicalMark;
  int? examMark;
  int? staffAssignType;
  int? subjectType;
  int? baseType;
  int? oldBaseType;
  int? languageType;
  bool? rootExamType;
  bool? rootStaffAssignType;
  List<dynamic>? children;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    standardSubjectId: json["standard_subject_id"],
    subjectListId: json["subject_list_id"],
    subject: Subject.fromJson(json["subject"]),
    examType: json["exam_type"],
    examMarkTypeId: json["exam_mark_type_id"],
    practicalType: json["practical_type"],
    practicalMark: json["practical_mark"],
    examMark: json["exam_mark"],
    staffAssignType: json["staff_assign_type"],
    subjectType: json["subject_type"],
    baseType: json["base_type"],
    oldBaseType: json["old_base_type"],
    languageType: json["language_type"],
    rootExamType: json["root_exam_type"],
    rootStaffAssignType: json["root_staff_assign_type"],
    children: List<dynamic>.from(json["children"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "standard_subject_id": standardSubjectId,
    "subject_list_id": subjectListId,
    "subject": subject!.toJson(),
    "exam_type": examType,
    "exam_mark_type_id": examMarkTypeId,
    "practical_type": practicalType,
    "practical_mark": practicalMark,
    "exam_mark": examMark,
    "staff_assign_type": staffAssignType,
    "subject_type": subjectType,
    "base_type": baseType,
    "old_base_type": oldBaseType,
    "language_type": languageType,
    "root_exam_type": rootExamType,
    "root_staff_assign_type": rootStaffAssignType,
    "children": List<dynamic>.from(children!.map((x) => x)),
  };
}

class Subject {
  Subject({
    this.id,
    this.uuid,
    this.shortName,
    this.code,
    this.name,
    this.fullName,
  });

  int? id;
  String? uuid;
  String? shortName;
  String? code;
  String? name;
  String? fullName;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    uuid: json["uuid"],
    shortName: json["short_name"],
    code: json["code"],
    name: json["name"],
    fullName: json["full_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "short_name": shortName,
    "code": code,
    "name": name,
    "full_name": fullName,
  };
}
