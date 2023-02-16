// To parse this JSON data, do
//
//     final classTestAddResponce = classTestAddResponceFromJson(jsonString);

import 'dart:convert';

ClassTestAddResponce classTestAddResponceFromJson(String str) => ClassTestAddResponce.fromJson(json.decode(str));

String classTestAddResponceToJson(ClassTestAddResponce data) => json.encode(data.toJson());

class ClassTestAddResponce {
  ClassTestAddResponce({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  ResponseData? data;

  factory ClassTestAddResponce.fromJson(Map<String, dynamic> json) => ClassTestAddResponce(
    status: json["status"],
    code: json["code"],
    data: ResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data!.toJson(),
  };
}

class ResponseData {
  ResponseData({
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

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    id: json["id"],
    code: json["code"],
    date: json["date"],
    title: json["title"],
    description: json["description"],
    createdByName: json["created_by_name"],
    edit: json["edit"],
    approvalType: json["approval_type"],
    staffClassTestApprovalType: json["staff_class_test_approval_type"],
    images: json["images"] == null ? null : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
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
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
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
