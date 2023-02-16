// To parse this JSON data, do
//
//     final barrowModel = barrowModelFromJson(jsonString);

import 'dart:convert';

import '../../../../../common/enums/loading_enums.dart';

BarrowModel barrowModelFromJson(String str) => BarrowModel.fromJson(json.decode(str));

String barrowModelToJson(BarrowModel data) => json.encode(data.toJson());

class BarrowModel {
  BarrowModel({
    this.data,
    this.links,
    required this.meta,
    required this.code,
    required this.status,
    required this.msg,
  });

  List<BarrowListData>? data;
  Links? links;
  Meta meta;
  int code;
  String status;
  String msg;

  factory BarrowModel.fromJson(Map<String, dynamic> json) => BarrowModel(
    data: List<BarrowListData>.from(json["data"].map((x) => BarrowListData.fromJson(x))),
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

class BarrowListData {
  BarrowListData({
    this.id,
    this.code,
    this.date,
    this.accessionNo,
    this.bookName,
    this.getDate,
    this.dueDate,
    this.status,
    this.returnRenewDate,
    this.fineDays,
    this.singleDayFine,
    this.fineAmount,
    this.lostBookAmount,
    this.totalFineAmount,
    this.fineStatus,
    this.academic,
  });

  int? id;
  String? code;
  String? date;
  String? accessionNo;
  String? bookName;
  String? getDate;
  String? dueDate;
  String? status;
  String? returnRenewDate;
  int? fineDays;
  String? singleDayFine;
  String? fineAmount;
  String? lostBookAmount;
  String? totalFineAmount;
  String? fineStatus;
  String? academic;

  factory BarrowListData.fromJson(Map<String, dynamic> json) => BarrowListData(
    id: json["id"],
    code: json["code"],
    date: json["date"],
    accessionNo: json["accession_no"],
    bookName: json["book_name"],
    getDate: json["get_date"],
    dueDate: json["due_date"],
    status: json["status"],
    returnRenewDate: json["return_renew_date"] == null ? null : json["return_renew_date"],
    fineDays: json["fine_days"] == null ? null : json["fine_days"],
    singleDayFine: json["single_day_fine"] == null ? null : json["single_day_fine"],
    fineAmount: json["fine_amount"] == null ? null : json["fine_amount"],
    lostBookAmount: json["lost_book_amount"] == null ? null : json["lost_book_amount"],
    totalFineAmount: json["total_fine_amount"] == null ? null : json["total_fine_amount"],
    fineStatus: json["fine_status"],
    academic: json["academic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "date": date,
    "accession_no": accessionNo,
    "book_name": bookName,
    "get_date": getDate,
    "due_date": dueDate,
    "status": status,
    "return_renew_date": returnRenewDate == null ? null : returnRenewDate,
    "fine_days": fineDays == null ? null : fineDays,
    "single_day_fine": singleDayFine == null ? null : singleDayFine,
    "fine_amount": fineAmount == null ? null : fineAmount,
    "lost_book_amount": lostBookAmount == null ? null : lostBookAmount,
    "total_fine_amount": totalFineAmount == null ? null : totalFineAmount,
    "fine_status": fineStatus,
    "academic": academic,
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

class BarrowListLoadingState {
  LoadingType loadingType;
  String? error;
  String? completed;

  BarrowListLoadingState({required this.loadingType, this.error, this.completed});
}
