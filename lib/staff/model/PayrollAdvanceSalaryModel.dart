// To parse this JSON data, do
//
//     final payrollAdvanceSalaryModel = payrollAdvanceSalaryModelFromJson(jsonString);

import 'dart:convert';

import '../../common/enums/loading_enums.dart';

PayrollAdvanceSalaryModel payrollAdvanceSalaryModelFromJson(String str) => PayrollAdvanceSalaryModel.fromJson(json.decode(str));

String payrollAdvanceSalaryModelToJson(PayrollAdvanceSalaryModel data) => json.encode(data.toJson());

class PayrollAdvanceSalaryModel {
  PayrollAdvanceSalaryModel({
    this.data,
    this.links,
    required this.meta,
    required this.code,
    required this.status,
    this.msg,
  });

  List<AdvanceSalarayData>? data;
  Links? links;
  Meta meta;
  int code;
  String status;
  String? msg;

  factory PayrollAdvanceSalaryModel.fromJson(Map<String, dynamic> json) => PayrollAdvanceSalaryModel(
    data: List<AdvanceSalarayData>.from(json["data"].map((x) => AdvanceSalarayData.fromJson(x))),
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

class AdvanceSalarayData {
  AdvanceSalarayData({
    this.id,
    this.leaveType,
    this.applyDate,
    this.amount,
    this.paymentStatus,
  });

  int? id;
  dynamic leaveType;
  String? applyDate;
  String? amount;
  String? paymentStatus;

  factory AdvanceSalarayData.fromJson(Map<String, dynamic> json) => AdvanceSalarayData(
    id: json["id"],
    leaveType: json["leave_type"],
    applyDate: json["apply_date"],
    amount: json["amount"],
    paymentStatus: json["payment_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "leave_type": leaveType,
    "apply_date": applyDate,
    "amount": amount,
    "payment_status": paymentStatus,
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

class AdvanceSalaryListState {
  LoadingType? loadingType;
  String? error;
  String? completed;

  AdvanceSalaryListState({required this.loadingType, this.error, this.completed});
}
