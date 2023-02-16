// To parse this JSON data, do
//
//     final classTestPastModel = classTestPastModelFromJson(jsonString);

import 'dart:convert';

ClassTestPastModel classTestPastModelFromJson(String str) => ClassTestPastModel.fromJson(json.decode(str));

String classTestPastModelToJson(ClassTestPastModel data) => json.encode(data.toJson());

class ClassTestPastModel {
  ClassTestPastModel({
    required this.data,
    required this.links,
    required this.meta,
    this.code,
    required this.status,
    required this.msg,
  });

  List<ClassTestPastData> data;
  Links links;
  Meta meta;
  int? code;
  String status;
  String msg;

  factory ClassTestPastModel.fromJson(Map<String, dynamic> json) => ClassTestPastModel(
    data: List<ClassTestPastData>.from(json["data"].map((x) => ClassTestPastData.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    code: json["code"],
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
    "code": code,
    "status": status,
    "msg": msg,
  };
}

class ClassTestPastData {
  ClassTestPastData({
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
  List<ClassTestPastSubject>? subject;

  factory ClassTestPastData.fromJson(Map<String, dynamic> json) => ClassTestPastData(
    id: json["id"],
    date: json["date"],
    description: json["description"],
    postedAt: json["posted_at"],
    subject: List<ClassTestPastSubject>.from(json["subject"].map((x) => ClassTestPastSubject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "description": description,
    "posted_at": postedAt,
    "subject": List<dynamic>.from(subject!.map((x) => x.toJson())),
  };
}

class ClassTestPastSubject {
  ClassTestPastSubject({
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
  String? postedBy;
  String? postedAt;
  List<AttachFile>? attachFile;
  ResultData? resultData;

  factory ClassTestPastSubject.fromJson(Map<String, dynamic> json) => ClassTestPastSubject(
    id: json["id"],
    date: json["date"],
    subjectListId: json["subject_list_id"],
    subjectName: json["subject_name"],
    icon: json["icon"],
    title: json["title"],
    description: json["description"],
    postedBy: json["posted_by"],
    postedAt: json["posted_at"],
    attachFile: List<AttachFile>.from(json["attach_file"].map((x) => AttachFile.fromJson(x))),
    resultData: json["result_data"] == null ? null : ResultData.fromJson(json["result_data"]),
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
    "result_data": resultData == null ? null : resultData!.toJson(),
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
  int? average;
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

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}
