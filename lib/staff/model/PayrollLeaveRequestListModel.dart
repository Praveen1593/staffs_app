// To parse this JSON data, do
//
//     final payrollLeaveRequestListModel = payrollLeaveRequestListModelFromJson(jsonString);

import 'dart:convert';

import '../../common/enums/loading_enums.dart';

PayrollLeaveRequestListModel payrollLeaveRequestListModelFromJson(String str) => PayrollLeaveRequestListModel.fromJson(json.decode(str));

String payrollLeaveRequestListModelToJson(PayrollLeaveRequestListModel data) => json.encode(data.toJson());

class PayrollLeaveRequestListModel {
  PayrollLeaveRequestListModel({
    this.data,
    this.links,
    required this.meta,
    required this.code,
    required this.status,
    this.msg,
  });

  List<LeaveRequestListData>? data;
  Links? links;
  Meta meta;
  int code;
  String status;
  String? msg;

  factory PayrollLeaveRequestListModel.fromJson(Map<String, dynamic> json) => PayrollLeaveRequestListModel(
    data: List<LeaveRequestListData>.from(json["data"].map((x) => LeaveRequestListData.fromJson(x))),
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

class LeaveRequestListData {
  LeaveRequestListData({
    this.id,
    this.leaveTypeId,
    this.leaveType,
    this.applyDate,
    this.startDate,
    this.endDate,
    this.total,
    this.description,
    this.halfDayLeave,
    this.status,
    this.statusName,
  });

  int? id;
  int? leaveTypeId;
  LeaveType? leaveType;
  String? applyDate;
  String? startDate;
  String? endDate;
  String? total;
  String? description;
  int? halfDayLeave;
  int? status;
  String? statusName;

  factory LeaveRequestListData.fromJson(Map<String, dynamic> json) => LeaveRequestListData(
    id: json["id"],
    leaveTypeId: json["leave_type_id"] == null ? null : json["leave_type_id"],
    leaveType: json["leave_type"] == null ? null : LeaveType.fromJson(json["leave_type"]),
    applyDate: json["apply_date"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    total: json["total"],
    description: json["description"] == null ? null : json["description"],
    halfDayLeave: json["half_day_leave"],
    status: json["status"],
    statusName:json["status_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "leave_type_id": leaveTypeId == null ? null : leaveTypeId,
    "leave_type": leaveType == null ? null : leaveType!.toJson(),
    "apply_date": applyDate,
    "start_date": startDate,
    "end_date": endDate,
    "total": total,
    "description": description == null ? null : description,
    "half_day_leave": halfDayLeave,
    "status": status,
    "status_name": statusName,
  };
}

class LeaveType {
  LeaveType({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
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

class LeaveRequestListState {
  LoadingType? loadingType;
  String? error;
  String? completed;

  LeaveRequestListState({required this.loadingType, this.error, this.completed});
}



