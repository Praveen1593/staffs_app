
import 'dart:convert';

import '../../../../../common/enums/loading_enums.dart';


FineListModel fineListModelFromJson(String str) => FineListModel.fromJson(json.decode(str));

String fineListModelToJson(FineListModel data) => json.encode(data.toJson());

class FineListModel {
  FineListModel({
    this.data,
    this.links,
    required this.meta,
    required this.code,
    required this.status,
    required this.msg,
  });

  List<FineListData>? data;
  Links? links;
  Meta meta;
  int code;
  String status;
  String msg;

  factory FineListModel.fromJson(Map<String, dynamic> json) => FineListModel(
    data: List<FineListData>.from(json["data"].map((x) => FineListData.fromJson(x))),
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

class FineListData {
  FineListData({
    this.id,
    this.code,
    this.date,
    this.accessionNo,
    this.bookName,
    this.renewGetDate,
    this.renewDueDate,
    this.renewTotalDay,
    this.returnRenewDate,
    this.type,
    this.totalFineDays,
    this.singleDayFine,
    this.fineAmount,
    this.lostBookAmount,
    this.totalFineAmount,
    this.discount,
    this.discountDescription,
    this.fineStatus,
    this.academic,
    this.isClicked = false,
    this.checkboxClicked = false
  });

  int? id;
  String? code;
  String? date;
  String? accessionNo;
  String? bookName;
  dynamic renewGetDate;
  dynamic renewDueDate;
  dynamic renewTotalDay;
  String? returnRenewDate;
  String? type;
  int? totalFineDays;
  String? singleDayFine;
  String? fineAmount;
  String? lostBookAmount;
  String? totalFineAmount;
  dynamic discount;
  dynamic discountDescription;
  String? fineStatus;
  String? academic;
  bool isClicked;
  bool checkboxClicked;

  factory FineListData.fromJson(Map<String, dynamic> json) => FineListData(
    id: json["id"],
    code: json["code"],
    date: json["date"],
    accessionNo: json["accession_no"],
    bookName: json["book_name"],
    renewGetDate: json["renew_get_date"],
    renewDueDate: json["renew_due_date"],
    renewTotalDay: json["renew_total_day"],
    returnRenewDate: json["return_renew_date"],
    type: json["type"],
    totalFineDays: json["total_fine_days"],
    singleDayFine: json["single_day_fine"],
    fineAmount: json["fine_amount"],
    lostBookAmount: json["lost_book_amount"],
    totalFineAmount: json["total_fine_amount"],
    discount: json["discount"],
    discountDescription: json["discount_description"],
    fineStatus: json["fine_status"],
    academic: json["academic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "date": date,
    "accession_no": accessionNo,
    "book_name": bookName,
    "renew_get_date": renewGetDate,
    "renew_due_date": renewDueDate,
    "renew_total_day": renewTotalDay,
    "return_renew_date": returnRenewDate,
    "type": type,
    "total_fine_days": totalFineDays,
    "single_day_fine": singleDayFine,
    "fine_amount": fineAmount,
    "lost_book_amount": lostBookAmount,
    "total_fine_amount": totalFineAmount,
    "discount": discount,
    "discount_description": discountDescription,
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

class FineListLoadingState {
  LoadingType? loadingType;
  String? error;
  String? completed;

  FineListLoadingState({required this.loadingType, this.error, this.completed});
}
