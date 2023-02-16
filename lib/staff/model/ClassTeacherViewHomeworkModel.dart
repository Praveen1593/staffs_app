// To parse this JSON data, do
//
//     final classTeacherViewHomeworkModel = classTeacherViewHomeworkModelFromJson(jsonString);

import 'dart:convert';

ClassTeacherViewHomeworkModel classTeacherViewHomeworkModelFromJson(
        String str) =>
    ClassTeacherViewHomeworkModel.fromJson(json.decode(str));

String classTeacherViewHomeworkModelToJson(
        ClassTeacherViewHomeworkModel data) =>
    json.encode(data.toJson());

class ClassTeacherViewHomeworkModel {
  ClassTeacherViewHomeworkModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  List<ClassTeacherViewHomeworkData>? data;

  factory ClassTeacherViewHomeworkModel.fromJson(Map<String, dynamic> json) =>
      ClassTeacherViewHomeworkModel(
        status: json["status"],
        code: json["code"],
        data: List<ClassTeacherViewHomeworkData>.from(
            json["data"].map((x) => ClassTeacherViewHomeworkData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ClassTeacherViewHomeworkData {
  ClassTeacherViewHomeworkData({
    this.id,
    this.sectionSubjectItemId,
    this.standardId,
    this.groupSectionId,
    this.standardSectionName,
    this.subjectName,
    this.subjectCode,
    this.subjectShortName,
    this.homework,
  });

  int? id;
  int? sectionSubjectItemId;
  int? standardId;
  int? groupSectionId;
  String? standardSectionName;
  String? subjectName;
  String? subjectCode;
  String? subjectShortName;
  Homework? homework;

  factory ClassTeacherViewHomeworkData.fromJson(Map<String, dynamic> json) =>
      ClassTeacherViewHomeworkData(
          id: json["id"],
          sectionSubjectItemId: json["section_subject_item_id"],
          standardId: json["standard_id"],
          groupSectionId: json["group_section_id"],
          standardSectionName: json["standard_section_name"],
          subjectName: json["subject_name"],
          subjectCode: json["subject_code"],
          subjectShortName: json["subject_short_name"],
          homework: json["homework"] != null
              ? Homework.fromJson(json["homework"])
              : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "section_subject_item_id": sectionSubjectItemId,
        "standard_id": standardId,
        "group_section_id": groupSectionId,
        "standard_section_name": standardSectionName,
        "subject_name": subjectName,
        "subject_code": subjectCode,
        "subject_short_name": subjectShortName,
        "homework": homework!.toJson(),
      };
}

class Homework {
  Homework({
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
  List<dynamic>? images;

  factory Homework.fromJson(Map<String, dynamic> json) => Homework(
        id: json["id"],
        code: json["code"],
        date: json["date"],
        title: json["title"],
        description: json["description"],
        createdByName: json["created_by_name"],
        edit: json["edit"],
        approvalType: json["approval_type"],
        staffHomeworkApprovalType: json["staff_homework_approval_type"],
        images: json["images"] == null
            ? null
            : List<Attachment>.from(
                json["images"].map((x) => Attachment.fromJson(x))),
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
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Attachment {
  Attachment({
    this.id,
    this.file,
    this.oldFile,
    this.oldAttachFile,
    this.attachType,
  });

  int? id;
  String? file;
  String? oldFile;
  String? oldAttachFile;
  String? attachType;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        file: json["file"],
        oldFile: json["old_file"],
        oldAttachFile: json["old_attach_file"],
        attachType: json["attach_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "old_file": oldFile,
        "old_attach_file": oldAttachFile,
        "attach_type": attachType,
      };
}
