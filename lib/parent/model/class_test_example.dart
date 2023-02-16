// To parse this JSON data, do
//
//     final homeworkModelCls = homeworkModelClsFromJson(jsonString);

import 'dart:convert';

ClassTestExampleModel classTestExampleModelFromJson(String str) => ClassTestExampleModel.fromJson(json.decode(str));

String ClassTestExampleModelToJson(ClassTestExampleModel data) => json.encode(data.toJson());

String responce = "";

class ClassTestExampleModel {
  ClassTestExampleModel({
    this.classTestData,
    this.links,
    this.meta,
    required this.code,
    required this.status,
    this.msg,
  });

  List<ClassTestData>? classTestData;
  Links? links;
  Meta? meta;
  int code;
  String status;
  String? msg;

  factory ClassTestExampleModel.fromJson(Map<String, dynamic> json) => ClassTestExampleModel(
    classTestData: List<ClassTestData>.from(json["data"].map((x) => ClassTestData.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    code: json["code"],
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(classTestData!.map((x) => x.toJson())),
    "links": links!.toJson(),
    "meta": meta!.toJson(),
    "code": code,
    "status": status,
    "msg": msg,
  };
}

class ClassTestData {
  ClassTestData({
    this.id,
    this.date,
  //  this.description,
    this.postedAt,
    this.subject,
  });

  int? id;
  String? date;
 // String? description;
  String? postedAt;
  List<Subject>? subject;

  factory ClassTestData.fromJson(Map<String, dynamic> json) => ClassTestData(
    id: json["id"],
    date: json["date"],
   // description: json["description"],
    postedAt: json["posted_at"],
    subject: List<Subject>.from(json["subject"].map((x) => Subject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
   // "description": description,
    "posted_at": postedAt,
    "subject": List<dynamic>.from(subject!.map((x) => x.toJson())),
  };
}

class Subject {
  Subject({
    this.id,
    this.date,
    this.subjectListId,
    this.subjectName,
    this.icon,
    this.title,
    this.description,
    this.postedBy,
    this.postedAt,
   // this.attachFile,
    this.resultData,

    this.color,
    this.performance,
    this.percentageLoader,
    this.percentageText,
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
 // List<dynamic>? attachFile;
  ResultData? resultData;
  int? color;
  String? performance;
  String? percentageLoader;
  String? percentageText;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    date: json["date"],
    subjectListId: json["subject_list_id"],
    subjectName: json["subject_name"],
    icon: json["icon"],
    title: json["title"],
    description: json["description"],
    postedBy: json["posted_by"],
    postedAt: json["posted_at"],
    //attachFile: json["attach_file"]!=null?List<dynamic>.from(json["attach_file"].map((x) => x)):[],
    resultData: json["result_data"]!=null? ResultData.fromJson(json["result_data"]):null,
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
   // "attach_file": List<dynamic>.from(attachFile!.map((x) => x)),
    "result_data": resultData!.toJson(),
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
  dynamic next;

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
