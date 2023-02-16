// To parse this JSON data, do
//
//     final staffModel = staffModelFromJson(jsonString);

import 'dart:convert';

StaffModel staffModelFromJson(String str) => StaffModel.fromJson(json.decode(str));

String staffModelToJson(StaffModel data) => json.encode(data.toJson());

class StaffModel {
  StaffModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  StaffData? data;

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
    status: json["status"],
    code: json["code"],
    data: StaffData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data!.toJson(),
  };
}

class StaffData {
  StaffData({
    this.classTeacher,
    this.subjectList,
  });

  ClassTeacher? classTeacher;
  List<SubjectList>? subjectList;

  factory StaffData.fromJson(Map<String, dynamic> json) => StaffData(
    classTeacher: ClassTeacher.fromJson(json["class_teacher"]),
    subjectList: List<SubjectList>.from(json["subject_list"].map((x) => SubjectList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "class_teacher": classTeacher?.toJson(),
    "subject_list": List<dynamic>.from(subjectList!.map((x) => x.toJson())),
  };
}

class ClassTeacher {
  ClassTeacher({
    this.id,
    this.code,
    this.name,
    this.photo,
  });

  int? id;
  String? code;
  String? name;
  String? photo;

  factory ClassTeacher.fromJson(Map<String, dynamic> json) => ClassTeacher(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "photo": photo,
  };
}

class SubjectList {
  SubjectList({
    this.id,
    this.standardSubjectId,
    this.subjectListId,
    this.subject,
    this.children,
    this.staffAssignType,
    this.staffDetail,
  });

  int? id;
  int? standardSubjectId;
  int? subjectListId;
  Subject? subject;
  List<SubjectList>? children;
  int? staffAssignType;
  StaffDetail? staffDetail;

  factory SubjectList.fromJson(Map<String, dynamic> json) => SubjectList(
    id: json["id"],
    standardSubjectId: json["standard_subject_id"],
    subjectListId: json["subject_list_id"],
    subject: Subject.fromJson(json["subject"]),
    children: List<SubjectList>.from(json["children"].map((x) => SubjectList.fromJson(x))),
    staffAssignType: json["staff_assign_type"],
    staffDetail: StaffDetail.fromJson(json["staff_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "standard_subject_id": standardSubjectId,
    "subject_list_id": subjectListId,
    "subject": subject!.toJson(),
    "children": List<dynamic>.from(children!.map((x) => x.toJson())),
    "staff_assign_type": staffAssignType,
    "staff_detail": staffDetail!.toJson(),
  };
}

class StaffDetail {
  StaffDetail({
    this.id,
    this.employeeId,
    this.employeeCode,
    this.employeeName,
    this.employeePhoto,
    this.assistantEmployeeId,
    this.assistantCode,
    this.assistantName,
    this.assistantPhoto,
  });

  int? id;
  int? employeeId;
  String? employeeCode;
  String? employeeName;
  String? employeePhoto;
  dynamic assistantEmployeeId;
  dynamic assistantCode;
  dynamic assistantName;
  dynamic assistantPhoto;

  factory StaffDetail.fromJson(Map<String, dynamic> json) => StaffDetail(
    id: json["id"],
    employeeId: json["employee_id"],
    employeeCode: json["employee_code"],
    employeeName: json["employee_name"],
    employeePhoto: json["employee_photo"],
    assistantEmployeeId: json["assistant_employee_id"],
    assistantCode: json["assistant_code"],
    assistantName: json["assistant_name"],
    assistantPhoto: json["assistant_photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "employee_code": employeeCode,
    "employee_name": employeeName,
    "employee_photo": employeePhoto,
    "assistant_employee_id": assistantEmployeeId,
    "assistant_code": assistantCode,
    "assistant_name": assistantName,
    "assistant_photo": assistantPhoto,
  };
}

class Subject {
  Subject({
    this.id,
    this.code,
    this.name,
    this.shortName,
    this.fullName,
    this.languageType,
    this.icon,
  });

  int? id;
  String? code;
  String? name;
  String? shortName;
  String? fullName;
  int? languageType;
  String? icon;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    shortName: json["short_name"],
    fullName: json["full_name"],
    languageType: json["language_type"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "short_name": shortName,
    "full_name": fullName,
    "language_type": languageType,
    "icon": icon,
  };
}
