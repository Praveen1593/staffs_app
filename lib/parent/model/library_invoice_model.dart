// To parse this JSON data, do
//
//     final invoiceModel = invoiceModelFromJson(jsonString);

import 'dart:convert';

import '../../../../../common/enums/loading_enums.dart';

InvoiceModel invoiceModelFromJson(String str) => InvoiceModel.fromJson(json.decode(str));

String invoiceModelToJson(InvoiceModel data) => json.encode(data.toJson());

class InvoiceModel {
  InvoiceModel({
    this.data,
    this.links,
    required this.meta,
    required this.code,
    required this.status,
    required this.msg,
  });

  List<InvoiceData>? data;
  Links? links;
  Meta meta;
  int code;
  String status;
  String msg;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
    data: List<InvoiceData>.from(json["data"].map((x) => InvoiceData.fromJson(x))),
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

class InvoiceData {
  InvoiceData({
    this.id,
    this.code,
    this.billDate,
    this.totalFine,
    this.discount,
    this.discountDescription,
    this.total,
    this.billPayType,
    this.academic,
    this.finePaymentItem,
  });

  int? id;
  String? code;
  String? billDate;
  String? totalFine;
  String? discount;
  String? discountDescription;
  String? total;
  String? billPayType;
  String? academic;
  List<FinePaymentItem>? finePaymentItem;

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
    id: json["id"],
    code: json["code"],
    billDate: json["bill_date"],
    totalFine: json["total_fine"],
    discount: json["discount"],
    discountDescription: json["discount_description"],
    total: json["total"],
    billPayType: json["bill_pay_type"],
    academic: json["academic"],
    finePaymentItem: List<FinePaymentItem>.from(json["fine_payment_item"].map((x) => FinePaymentItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "bill_date": billDate,
    "total_fine": totalFine,
    "discount": discount,
    "discount_description": discountDescription,
    "total": total,
    "bill_pay_type": billPayType,
    "academic": academic,
    "fine_payment_item": List<dynamic>.from(finePaymentItem!.map((x) => x.toJson())),
  };
}

class FinePaymentItem {
  FinePaymentItem({
    this.id,
    this.accessionNo,
    this.bookName,
    this.totalFineDays,
    this.singleDayFine,
    this.totalFineAmount,
  });

  int? id;
  String? accessionNo;
  String? bookName;
  int? totalFineDays;
  String? singleDayFine;
  String? totalFineAmount;

  factory FinePaymentItem.fromJson(Map<String, dynamic> json) => FinePaymentItem(
    id: json["id"],
    accessionNo: json["accession_no"],
    bookName: json["book_name"],
    totalFineDays: json["total_fine_days"],
    singleDayFine: json["single_day_fine"],
    totalFineAmount: json["total_fine_amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accession_no": accessionNo,
    "book_name": bookName,
    "total_fine_days": totalFineDays,
    "single_day_fine": singleDayFine,
    "total_fine_amount": totalFineAmount,
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

class InvoiceListLoadingState {
  LoadingType? loadingType;
  String? error;
  String? completed;

  InvoiceListLoadingState({required this.loadingType, this.error, this.completed});
}

