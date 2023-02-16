// To parse this JSON data, do
//
//     final payrollLoanModel = payrollLoanModelFromJson(jsonString);

import 'dart:convert';

import '../../common/enums/loading_enums.dart';

PayrollLoanModel payrollLoanModelFromJson(String str) => PayrollLoanModel.fromJson(json.decode(str));

String payrollLoanModelToJson(PayrollLoanModel data) => json.encode(data.toJson());

class PayrollLoanModel {
  PayrollLoanModel({
    this.data,
    this.links,
    required this.meta,
    this.code,
    this.status,
    this.msg,
  });

  List<LoanData>? data;
  Links? links;
  Meta meta;
  int? code;
  String? status;
  String? msg;

  factory PayrollLoanModel.fromJson(Map<String, dynamic> json) => PayrollLoanModel(
    data: List<LoanData>.from(json["data"].map((x) => LoanData.fromJson(x))),
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

class LoanData {
  LoanData({
    this.id,
    this.leaveTypeId,
    this.leaveTypeName,
    this.date,
    this.startDate,
    this.endDate,
    this.amount,
    this.paymentStatus,
    this.status,
  });

  int? id;
  dynamic leaveTypeId;
  String? leaveTypeName;
  String? date;
  String? startDate;
  String? endDate;
  String? amount;
  String? paymentStatus;
  String? status;

  factory LoanData.fromJson(Map<String, dynamic> json) => LoanData(
    id: json["id"],
    leaveTypeId: json["leave_type_id"],
    leaveTypeName: json["leave_type_name"],
    date: json["date"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    amount: json["amount"],
    paymentStatus: json["payment_status"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "leave_type_id": leaveTypeId,
    "leave_type_name": leaveTypeName,
    "date": date,
    "start_date": startDate,
    "end_date": endDate,
    "amount": amount,
    "payment_status": paymentStatus,
    "status": status,
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

class LoanListState {
  LoadingType? loadingType;
  String? error;
  String? completed;

  LoanListState({required this.loadingType, this.error, this.completed});
}
