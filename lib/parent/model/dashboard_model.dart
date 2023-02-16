import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  DashboardModel({
    required this.code,
    required this.status,
    required this.msg,
    required this.dashboardData,
  });

  int code;
  String status;
  String msg;
  DashboardData dashboardData;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    code: json["code"],
    status: json["status"],
    msg: json["msg"],
    dashboardData: DashboardData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "msg": msg,
    "data": dashboardData.toJson(),
  };
}

class DashboardData {
  DashboardData({
    this.subjectList,
    this.notification,
  });

  List<SubjectList>? subjectList;
  Map<String, int>? notification;

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
    subjectList: json.containsKey("subject_list") ? List<SubjectList>.from(json["subject_list"].map((x) => SubjectList.fromJson(x))):[],
    notification:json.containsKey("notification") ?Map.from(json["notification"]).map((k, v) => MapEntry<String, int>(k, v)) :{},
  );

  Map<String, dynamic> toJson() => {
    "subject_list": List<dynamic>.from(subjectList!.map((x) => x.toJson())),
    "notification": Map.from(notification!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class SubjectList {
  SubjectList({
    this.id,
    this.subjectListId,
    this.subject,
  });

  int? id;
  int? subjectListId;
  Subject? subject;

  factory SubjectList.fromJson(Map<String, dynamic> json) => SubjectList(
    id: json["id"],
    subjectListId: json["subject_list_id"],
    subject: Subject.fromJson(json["subject"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject_list_id": subjectListId,
    "subject": subject!.toJson(),
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
    this.homeWorkCount,
  });

  int? id;
  String? code;
  String? name;
  String? shortName;
  String? fullName;
  int? languageType;
  String? icon;
  int? homeWorkCount;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    shortName: json["short_name"],
    fullName: json["full_name"],
    languageType: json["language_type"],
    icon: json["icon"],
    homeWorkCount: json["home_work_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "short_name": shortName,
    "full_name": fullName,
    "language_type": languageType,
    "icon": icon,
    "home_work_count": homeWorkCount,
  };
}
