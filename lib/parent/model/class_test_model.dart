// To parse this JSON data, do
//
//     final classTestModel = classTestModelFromJson(jsonString);

import 'dart:convert';

ClassTestModel classTestModelFromJson(String str) =>
    ClassTestModel.fromJson(json.decode(str));

String classTestModelToJson(ClassTestModel data) => json.encode(data.toJson());

class ClassTestModel {
  ClassTestModel({
    this.data,
    required this.code,
    required this.status,
    required this.msg,
  });

  List<ClassTestTodayData>? data;
  int code;
  String status;
  String msg;

  factory ClassTestModel.fromJson(Map<String, dynamic> json) => ClassTestModel(
        data: List<ClassTestTodayData>.from(
            json["data"].map((x) => ClassTestTodayData.fromJson(x))),
        code: json["code"],
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
        "status": status,
        "msg": msg,
      };
}

class ClassTestTodayData {
  ClassTestTodayData({
    this.id,
    this.date,
    this.description,
    this.postedAt,
    this.subject,
  });

  int? id;
  String? date;
  String? description;
  String? postedAt;
  List<ClassTestTodaySubjectModel>? subject;

  factory ClassTestTodayData.fromJson(Map<String, dynamic> json) =>
      ClassTestTodayData(
        id: json["id"],
        date: json["date"],
        description: json["description"],
        postedAt: json["posted_at"],
        subject: List<ClassTestTodaySubjectModel>.from(
            json["subject"].map((x) => ClassTestTodaySubjectModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "description": description,
        "posted_at": postedAt,
        "subject": List<dynamic>.from(subject!.map((x) => x.toJson())),
      };
}

class ClassTestTodaySubjectModel {
  ClassTestTodaySubjectModel({
    this.id,
    this.date,
    this.subjectListId,
    this.subjectName,
    this.icon,
    this.title,
    this.description,
    this.postedBy,
    this.postedAt,
    this.attachFile,
    this.resultData,
  });

  int? id;
  String? date;
  int? subjectListId;
  String? subjectName;
  String? icon;
  String? title;
  String? description;
  dynamic postedBy;
  String? postedAt;
  List<AttachFile>? attachFile;
  dynamic resultData;

  factory ClassTestTodaySubjectModel.fromJson(Map<String, dynamic> json) =>
      ClassTestTodaySubjectModel(
        id: json["id"],
        date: json["date"],
        subjectListId: json["subject_list_id"],
        subjectName: json["subject_name"],
        icon: json["icon"],
        title: json["title"],
        description: json["description"],
        postedBy: json["posted_by"],
        postedAt: json["posted_at"],
        attachFile: List<AttachFile>.from(
            json["attach_file"].map((x) => AttachFile.fromJson(x))),
        resultData: json["result_data"] != null
            ? ResultData.fromJson(json["result_data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "subject_list_id": subjectListId,
        "subject_name": subjectName,
        "icon": icon,
        "title": title,
        "description": description,
        "posted_by": postedBy,
        "posted_at": postedAt,
        "attach_file": List<dynamic>.from(attachFile!.map((x) => x.toJson())),
        "result_data": resultData,
      };
}

class AttachFile {
  AttachFile({
    this.attachFile,
    this.attachType,
    this.attachExtension,
    this.attachSize,
  });

  String? attachFile;
  String? attachType;
  String? attachExtension;
  String? attachSize;

  factory AttachFile.fromJson(Map<String, dynamic> json) => AttachFile(
        attachFile: json["attach_file"],
        attachType: json["attach_type"],
        attachExtension: json["attach_extension"],
        attachSize: json["attach_size"],
      );

  Map<String, dynamic> toJson() => {
        "attach_file": attachFile,
        "attach_type": attachType,
        "attach_extension": attachExtension,
        "attach_size": attachSize,
      };
}

class ResultData {
  ResultData({
    this.id,
    this.totalMark,
    this.absent,
    this.average,
    this.resultMax,
    this.createdBy,
  });

  int? id;
  int? totalMark;
  int? absent;
  dynamic average;
  int? resultMax;
  String? createdBy;

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
        id: json["id"],
        totalMark: json["total_mark"],
        absent: json["absent"],
        average: json["average"],
        resultMax: json["result_max"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total_mark": totalMark,
        "absent": absent,
        "average": average,
        "result_max": resultMax,
        "created_by": createdBy,
      };
}
