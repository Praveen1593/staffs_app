// To parse this JSON data, do
//
//     final payrollSalaryListModel = payrollSalaryListModelFromJson(jsonString);

import 'dart:convert';

import '../../common/enums/loading_enums.dart';

PayrollSalaryListModel payrollSalaryListModelFromJson(String str) => PayrollSalaryListModel.fromJson(json.decode(str));

String payrollSalaryListModelToJson(PayrollSalaryListModel data) => json.encode(data.toJson());

class PayrollSalaryListModel {
  PayrollSalaryListModel({
    this.data,
    this.links,
    required this.meta,
    required this.code,
    required this.status,
    this.msg,
  });

  List<SalaryData>? data;
  Links? links;
  Meta meta;
  int code;
  String status;
  String? msg;

  factory PayrollSalaryListModel.fromJson(Map<String, dynamic> json) => PayrollSalaryListModel(
    data: List<SalaryData>.from(json["data"].map((x) => SalaryData.fromJson(x))),
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

class SalaryData {
  SalaryData({
    this.id,
    this.salaryDate,
    this.date,
    this.allowanceName,
    this.gSalary,
    this.deductionName,
    this.dTotal,
    this.nSalary,
  });

  int? id;
  String? salaryDate;
  String? date;
  String? allowanceName;
  String? gSalary;
  String? deductionName;
  String? dTotal;
  String? nSalary;

  factory SalaryData.fromJson(Map<String, dynamic> json) => SalaryData(
    id: json["id"],
    salaryDate: json["salary_date"],
    date: json["date"],
    allowanceName: json["allowance_name"],
    gSalary: json["g_salary"],
    deductionName: json["deduction_name"],
    dTotal: json["d_total"],
    nSalary: json["n_salary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "salary_date": salaryDate,
    "date": date,
    "allowance_name": allowanceName,
    "g_salary": gSalary,
    "deduction_name": deductionName,
    "d_total": dTotal,
    "n_salary": nSalary,
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

class SalaryListState {
  LoadingType? loadingType;
  String? error;
  String? completed;

  SalaryListState({required this.loadingType, this.error, this.completed});
}
