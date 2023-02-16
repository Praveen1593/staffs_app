// To parse this JSON data, do
//
//     final staffHomeworkStudentReplyList = staffHomeworkStudentReplyListFromJson(jsonString);

import 'dart:convert';

StaffHomeworkStudentReplyList staffHomeworkStudentReplyListFromJson(String str) => StaffHomeworkStudentReplyList.fromJson(json.decode(str));

String staffHomeworkStudentReplyListToJson(StaffHomeworkStudentReplyList data) => json.encode(data.toJson());

class StaffHomeworkStudentReplyList {
  StaffHomeworkStudentReplyList({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  List<StudentReplyList>? data;

  factory StaffHomeworkStudentReplyList.fromJson(Map<String, dynamic> json) => StaffHomeworkStudentReplyList(
    status: json["status"],
    code: json["code"],
    data: List<StudentReplyList>.from(json["data"].map((x) => StudentReplyList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StudentReplyList {
  StudentReplyList({
    this.id,
    this.studentReply,
    this.staffReply,
    this.checkboxClick = false,
  });

  int? id;
  StudentReply? studentReply;
  StaffReply? staffReply;
  bool checkboxClick;

  factory StudentReplyList.fromJson(Map<String, dynamic> json) => StudentReplyList(
    id: json["id"],
    studentReply: StudentReply.fromJson(json["student_reply"]),
    staffReply: StaffReply.fromJson(json["staff_reply"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_reply": studentReply!.toJson(),
    "staff_reply": staffReply!.toJson(),
  };
}

class StaffReply {
  StaffReply({
    this.staffDate,
    this.staffDescription,
    this.staffRating,
  });

  dynamic staffDate;
  dynamic staffDescription;
  dynamic staffRating;

  factory StaffReply.fromJson(Map<String, dynamic> json) => StaffReply(
    staffDate: json["staff_date"],
    staffDescription: json["staff_description"],
    staffRating: json["staff_rating"],
  );

  Map<String, dynamic> toJson() => {
    "staff_date": staffDate,
    "staff_description": staffDescription,
    "staff_rating": staffRating,
  };
}

class StudentReply {
  StudentReply({
    this.studentName,
    this.date,
    this.stuDescription,
    this.stuHomeworkFile,
  });

  String? studentName;
  String? date;
  String? stuDescription;
  List<dynamic>? stuHomeworkFile;

  factory StudentReply.fromJson(Map<String, dynamic> json) => StudentReply(
    studentName: json["student_name"],
    date: json["date"],
    stuDescription: json["stu_description"],
    stuHomeworkFile: List<dynamic>.from(json["stu_homework_file"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "student_name": studentName,
    "date": date,
    "stu_description": stuDescription,
    "stu_homework_file": List<dynamic>.from(stuHomeworkFile!.map((x) => x)),
  };
}
