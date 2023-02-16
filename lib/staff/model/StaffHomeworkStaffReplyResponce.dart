// To parse this JSON data, do
//
//     final staffHomeworkStaffReplyResponce = staffHomeworkStaffReplyResponceFromJson(jsonString);

import 'dart:convert';

StaffHomeworkStaffReplyResponce staffHomeworkStaffReplyResponceFromJson(String str) => StaffHomeworkStaffReplyResponce.fromJson(json.decode(str));

String staffHomeworkStaffReplyResponceToJson(StaffHomeworkStaffReplyResponce data) => json.encode(data.toJson());

class StaffHomeworkStaffReplyResponce {
  StaffHomeworkStaffReplyResponce({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  StaffReplyData? data;

  factory StaffHomeworkStaffReplyResponce.fromJson(Map<String, dynamic> json) => StaffHomeworkStaffReplyResponce(
    status: json["status"],
    code: json["code"],
    data: StaffReplyData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data!.toJson(),
  };
}

class StaffReplyData {
  StaffReplyData({
    this.id,
    this.studentReply,
    this.staffReply,
  });

  int? id;
  StudentReply? studentReply;
  StaffReply? staffReply;

  factory StaffReplyData.fromJson(Map<String, dynamic> json) => StaffReplyData(
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

  String? staffDate;
  String? staffDescription;
  String? staffRating;

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
