// To parse this JSON data, do
//
//     final classTestStViewModel = classTestStViewModelFromJson(jsonString);

import 'dart:convert';

ClassTestStViewModel classTestStViewModelFromJson(String str) => ClassTestStViewModel.fromJson(json.decode(str));

String classTestStViewModelToJson(ClassTestStViewModel data) => json.encode(data.toJson());

class ClassTestStViewModel {
  ClassTestStViewModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  List<ClassTestViewData>? data;

  factory ClassTestStViewModel.fromJson(Map<String, dynamic> json) => ClassTestStViewModel(
    status: json["status"],
    code: json["code"],
    data: List<ClassTestViewData>.from(json["data"].map((x) => ClassTestViewData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ClassTestViewData {
  ClassTestViewData({
    this.id,
    this.sectionSubjectItemId,
    this.standardSectionName,
    this.subjectName,
    this.subjectCode,
    this.subjectShortName,
    this.classTest,
  });

  int? id;
  int? sectionSubjectItemId;
  String? standardSectionName;
  String? subjectName;
  String? subjectCode;
  String? subjectShortName;
  ClassTest? classTest;

  factory ClassTestViewData.fromJson(Map<String, dynamic> json) => ClassTestViewData(
    id: json["id"],
    sectionSubjectItemId: json["section_subject_item_id"],
    standardSectionName: json["standard_section_name"],
    subjectName: json["subject_name"],
    subjectCode: json["subject_code"],
    subjectShortName: json["subject_short_name"],
    classTest: json["class_test"] == null ? null : ClassTest.fromJson(json["class_test"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "section_subject_item_id": sectionSubjectItemId,
    "standard_section_name": standardSectionName,
    "subject_name": subjectName,
    "subject_code": subjectCode,
    "subject_short_name": subjectShortName,
    "class_test": classTest == null ? null : classTest!.toJson(),
  };
}

class ClassTest {
  ClassTest({
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
  List<dynamic>? images;

  factory ClassTest.fromJson(Map<String, dynamic> json) => ClassTest(
    id: json["id"],
    code: json["code"],
    date: json["date"],
    title: json["title"],
    description: json["description"],
    createdByName: json["created_by_name"],
    edit: json["edit"],
    approvalType: json["approval_type"],
    staffClassTestApprovalType: json["staff_class_test_approval_type"],
    images:  json["images"] == null ? null : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
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
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}

class Image {
  Image({
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

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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
