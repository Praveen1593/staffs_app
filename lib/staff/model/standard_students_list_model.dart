import 'dart:convert';

StaffStandardListModel staffStandardListModelFromJson(String str) => StaffStandardListModel.fromJson(json.decode(str));

String staffStandardListModelToJson(StaffStandardListModel data) => json.encode(data.toJson());

class StaffStandardListModel {
  StaffStandardListModel({
    required this.status,
    required this.code,
    this.studentsStandardListData,
  });

  String status;
  int code;
  List<StudentStandardListData>? studentsStandardListData;

  factory StaffStandardListModel.fromJson(Map<String, dynamic> json) => StaffStandardListModel(
    status: json["status"],
    code: json["code"],
    studentsStandardListData: List<StudentStandardListData>.from(json["data"].map((x) => StudentStandardListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(studentsStandardListData!.map((x) => x.toJson())),
  };
}

class StudentStandardListData {
  StudentStandardListData({
    this.id,
    this.code,
    this.name,
    this.fullName,
    this.type,
    this.section,
  });

  int? id;
  String? code;
  String? name;
  String? fullName;
  int? type;
  List<Section>? section;

  factory StudentStandardListData.fromJson(Map<String, dynamic> json) => StudentStandardListData(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    fullName: json["full_name"],
    type: json["type"],
    section: List<Section>.from(json["section"].map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "full_name": fullName,
    "type": type,
    "section": List<dynamic>.from(section!.map((x) => x.toJson())),
  };
}

class Section {
  Section({
    this.id,
    this.code,
    this.standardId,
    this.name,
    this.fullName,
    this.type,
    this.studentCount,
  });

  int? id;
  String? code;
  int? standardId;
  String? name;
  String? fullName;
  int? type;
  dynamic studentCount;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    code: json["code"],
    standardId: json["standard_id"],
    name: json["name"],
    fullName: json["full_name"],
    type: json["type"],
    studentCount: json["student_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "standard_id": standardId,
    "name": name,
    "full_name": fullName,
    "type": type,
    "student_count": studentCount,
  };
}
