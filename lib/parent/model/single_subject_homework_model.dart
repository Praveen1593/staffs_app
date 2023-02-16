// To parse this JSON data, do
//
//     final singleSubjectModel = singleSubjectModelFromJson(jsonString);

import 'dart:convert';

SingleSubjectModel singleSubjectModelFromJson(String str) =>
    SingleSubjectModel.fromJson(json.decode(str));

String singleSubjectModelToJson(SingleSubjectModel data) =>
    json.encode(data.toJson());

class SingleSubjectModel {
  SingleSubjectModel({
    required this.status,
    required this.code,
    this.subjectData,
  });

  String status;
  int code;
  SingleSubjectData? subjectData;

  factory SingleSubjectModel.fromJson(Map<String, dynamic> json) =>
      SingleSubjectModel(
        status: json["status"],
        code: json["code"],
        subjectData: SingleSubjectData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": subjectData!.toJson(),
      };
}

class SingleSubjectData {
  SingleSubjectData({
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
    this.homeworkReply,
  });

  int? id;
  String? date;
  int? subjectListId;
  String? subjectName;
  String? icon;
  dynamic title;
  String? description;
  String? postedBy;
  String? postedAt;
  List<dynamic>? attachFile;
  HomeworkReply? homeworkReply;

  factory SingleSubjectData.fromJson(Map<String, dynamic> json) => SingleSubjectData(
        id: json["id"],
        date: json["date"],
        subjectListId: json["subject_list_id"],
        subjectName: json["subject_name"],
        icon: json["icon"],
        title: json["title"],
        description: json["description"],
        postedBy: json["posted_by"],
        postedAt: json["posted_at"],
        attachFile: List<dynamic>.from(json["attach_file"].map((x) => x)),
        homeworkReply: json["homework_reply"] == null
            ? null
            : HomeworkReply.fromJson(json["homework_reply"]),
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
        "attach_file": List<dynamic>.from(attachFile!.map((x) => x)),
        "homework_reply": homeworkReply!.toJson(),
      };
}

class AttachFile {
  AttachFile({
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

  factory AttachFile.fromJson(Map<String, dynamic> json) => AttachFile(
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

class HomeworkReply {
  HomeworkReply({
    this.id,
    this.studentReply,
    this.staffReply,
  });

  int? id;
  StudentReply? studentReply;
  StaffReply? staffReply;

  factory HomeworkReply.fromJson(Map<String, dynamic> json) => HomeworkReply(
        id: json["id"],
        studentReply: json.containsKey("student_reply")
            ? StudentReply.fromJson(json["student_reply"])
            : StudentReply(),
        staffReply: json.containsKey("staff_reply")
            ? StaffReply.fromJson(json["staff_reply"])
            : StaffReply(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_reply": studentReply!.toJson(),
        "staff_reply": staffReply!.toJson(),
      };
}

class StaffReply {
  StaffReply({
    this.staffName,
    this.staffDate,
    this.staffDescription,
    this.staffRating,
  });

  dynamic staffName;
  dynamic staffDate;
  dynamic staffDescription;
  dynamic staffRating;

  factory StaffReply.fromJson(Map<String, dynamic> json) => StaffReply(
        staffName: json["staff_name"],
        staffDate: json["staff_date"],
        staffDescription: json["staff_description"],
        staffRating: json["staff_rating"],
      );

  Map<String, dynamic> toJson() => {
        "staff_name": staffName,
        "staff_date": staffDate,
        "staff_description": staffDescription,
        "staff_rating": staffRating,
      };
}

class StudentReply {
  StudentReply({
    this.date,
    this.stuDescription,
    this.stuHomeworkFile,
  });

  String? date;
  String? stuDescription;
  List<dynamic>? stuHomeworkFile;

  factory StudentReply.fromJson(Map<String, dynamic> json) => StudentReply(
        date: json["date"],
        stuDescription: json["stu_description"],
        stuHomeworkFile:
            List<dynamic>.from(json["stu_homework_file"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "stu_description": stuDescription,
        "stu_homework_file": List<dynamic>.from(stuHomeworkFile!.map((x) => x)),
      };
}
