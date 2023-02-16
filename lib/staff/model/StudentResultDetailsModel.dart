// To parse this JSON data, do
//
//     final studentResultDetailsModel = studentResultDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

StudentResultDetailsModel studentResultDetailsModelFromJson(String str) => StudentResultDetailsModel.fromJson(json.decode(str));

String studentResultDetailsModelToJson(StudentResultDetailsModel data) => json.encode(data.toJson());

class StudentResultDetailsModel {
  StudentResultDetailsModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  Data? data;

  factory StudentResultDetailsModel.fromJson(Map<String, dynamic> json) => StudentResultDetailsModel(
    status: json["status"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.classTestDetail,
    this.studentList,
  });

  ClassTestDetail? classTestDetail;
  List<StudentList>? studentList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    classTestDetail: ClassTestDetail.fromJson(json["class_test_detail"]),
    studentList: List<StudentList>.from(json["student_list"].map((x) => StudentList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "class_test_detail": classTestDetail!.toJson(),
    "student_list": List<dynamic>.from(studentList!.map((x) => x.toJson())),
  };
}

class ClassTestDetail {
  ClassTestDetail({
    this.id,
    this.title,
    this.description,
    this.resultMax,
    this.resultTotal,
    this.resultAvg,
  });

  int? id;
  String? title;
  String? description;
  int? resultMax;
  dynamic resultTotal;
  dynamic resultAvg;

  factory ClassTestDetail.fromJson(Map<String, dynamic> json) => ClassTestDetail(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    resultMax: json["result_max"],
    resultTotal: json["result_total"],
    resultAvg: json["result_avg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "result_max": resultMax,
    "result_total": resultTotal,
    "result_avg": resultAvg,
  };
}

class StudentList {



  StudentList({
    this.id,
    this.studentId,
    this.code,
    this.name,
    this.photo,
    this.classTestResult,
    this.markController
  }
  );

  int? id;
  int? studentId;
  String? code;
  String? name;
  String? photo;
  ClassTestResult? classTestResult;
  TextEditingController? markController ;

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
    id: json["id"],
    studentId: json["student_id"],
    code: json["code"],
    name: json["name"],
    photo: json["photo"],
    classTestResult: ClassTestResult.fromJson(json["class_test_result"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_id": studentId,
    "code": code,
    "name": name,
    "photo": photo,
    "class_test_result": classTestResult!.toJson(),
  };
}

class ClassTestResult {
  ClassTestResult({
    this.totalMark,
    this.absent,
    this.average,
    this.absentRef = "Mark"
  });

  dynamic totalMark;
  int? absent;
  int? average;
  String? absentRef;

  factory ClassTestResult.fromJson(Map<String, dynamic> json) => ClassTestResult(
    totalMark: json["total_mark"] ?? "",
    absent: json["absent"],
    average: json["average"],
  );

  Map<String, dynamic> toJson() => {
    "total_mark": totalMark,
    "absent": absent,
    "average": average,
  };
}
