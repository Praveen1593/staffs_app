// To parse this JSON data, do
//
//     final examListModel = examListModelFromJson(jsonString);

import 'dart:convert';

ExamListModel examListModelFromJson(String str) =>
    ExamListModel.fromJson(json.decode(str));

String examListModelToJson(ExamListModel data) => json.encode(data.toJson());

class ExamListModel {
  ExamListModel({
    this.examListData,
    required this.code,
    required this.status,
    this.msg,
    this.error,
  });

  List<ExamListData>? examListData;
  int code;
  String status;
  String? msg;
  String? error;

  factory ExamListModel.fromJson(Map<String, dynamic> json) => ExamListModel(
      examListData: json.containsKey("data")
          ? List<ExamListData>.from(
              json["data"].map((x) => ExamListData.fromJson(x)))
          : [],
      code: json["code"],
      status: json["status"],
      msg: json.containsKey("msg") ? json["msg"] : "",
      error: json.containsKey("error") ? json["error"] : "");

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(examListData!.map((x) => x.toJson())),
        "code": code,
        "status": status,
        "msg": msg,
      };
}

class ExamListData {
  ExamListData({
    this.id,
    this.code,
    this.name,
    this.status,
    this.priority,
  });

  int? id;
  String? code;
  String? name;
  int? status;
  int? priority;

  factory ExamListData.fromJson(Map<String, dynamic> json) => ExamListData(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        status: json["status"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "status": status,
        "priority": priority,
      };
}
