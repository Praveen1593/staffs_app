// To parse this JSON data, do
//
//     final paymentOverviewModel = paymentOverviewModelFromJson(jsonString);

import 'dart:convert';

PaymentOverviewModel paymentOverviewModelFromJson(String str) => PaymentOverviewModel.fromJson(json.decode(str));

String paymentOverviewModelToJson(PaymentOverviewModel data) => json.encode(data.toJson());

class PaymentOverviewModel {
  PaymentOverviewModel({
    required this.status,
    required this.code,
    this.paymentOverviewData,
  });

  String status;
  int code;
  PaymentOverviewData? paymentOverviewData;

  factory PaymentOverviewModel.fromJson(Map<String, dynamic> json) => PaymentOverviewModel(
    status: json["status"],
    code: json["code"],
    paymentOverviewData: PaymentOverviewData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": paymentOverviewData!.toJson(),
  };
}

class PaymentOverviewData {
  PaymentOverviewData({
    this.id,
    this.total,
    this.paid,
    this.discount,
    this.pending,
    this.percentage,
    this.feePendingDetail,
  });

  int? id;
  int? total;
  int? paid;
  int? discount;
  int? pending;
  int? percentage;
  List<dynamic>? feePendingDetail;

  factory PaymentOverviewData.fromJson(Map<String, dynamic> json) => PaymentOverviewData(
    id: json["id"],
    total: json["total"],
    paid: json["paid"],
    discount: json["discount"],
    pending: json["pending"],
    percentage: json["percentage"],
    feePendingDetail: List<dynamic>.from(json["fee_pending_detail"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total": total,
    "paid": paid,
    "discount": discount,
    "pending": pending,
    "percentage": percentage,
    "fee_pending_detail": List<dynamic>.from(feePendingDetail!.map((x) => x)),
  };
}
