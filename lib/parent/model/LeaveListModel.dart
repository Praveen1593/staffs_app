// To parse this JSON data, do
//
//     final leaveListModel = leaveListModelFromJson(jsonString);

import 'dart:convert';

import '../../../../../common/enums/loading_enums.dart';


LeaveListModel leaveListModelFromJson(String str) => LeaveListModel.fromJson(json.decode(str));

String leaveListModelToJson(LeaveListModel data) => json.encode(data.toJson());

class LeaveListModel {
  LeaveListModel({
    this.data,
    this.links,
    required this.meta,
    required this.code,
    required this.status,
    required this.msg,
  });

  List<LeaveListData>? data;
  Links? links;
  Meta meta;
  int code;
  String status;
  String msg;

  factory LeaveListModel.fromJson(Map<String, dynamic> json) => LeaveListModel(
    data: List<LeaveListData>.from(json["data"].map((x) => LeaveListData.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    code: json["code"],
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links!.toJson(),
    "meta": meta.toJson(),
    "code": code,
    "status": status,
    "msg": msg,
  };
}

class LeaveListData {
  LeaveListData({
    this.id,
    this.uuid,
    this.studentId,
    this.studentName,
    this.academicStudentId,
    this.applyDate,
    this.startDate,
    this.endDate,
    this.total,
    this.description,
    this.rejectRemark,
    this.halfDayLeave,
    this.status,
    this.statusName,
  });

  int? id;
  String? uuid;
  int? studentId;
  String? studentName;
  int? academicStudentId;
  String? applyDate;
  String? startDate;
  String? endDate;
  String? total;
  String? description;
  dynamic rejectRemark;
  int? halfDayLeave;
  int? status;
  String? statusName;

  factory LeaveListData.fromJson(Map<String, dynamic> json) => LeaveListData(
    id: json["id"],
    uuid: json["uuid"],
    studentId: json["student_id"],
    studentName: json["student_name"],
    academicStudentId: json["academic_student_id"],
    applyDate: json["apply_date"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    total: json["total"],
    description: json["description"],
    rejectRemark: json["reject_remark"],
    halfDayLeave: json["half_day_leave"],
    status: json["status"],
    statusName: json["status_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "student_id": studentId,
    "student_name": studentName,
    "academic_student_id": academicStudentId,
    "apply_date": applyDate,
    "start_date": startDate,
    "end_date": endDate,
    "total": total,
    "description": description,
    "reject_remark": rejectRemark,
    "half_day_leave": halfDayLeave,
    "status": status,
    "status_name": statusName,
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

class LeaveListLoadingState {
  LoadingType loadingType;
  String? error;
  String? completed;

  LeaveListLoadingState({required this.loadingType, this.error, this.completed});
}
