// To parse this JSON data, do
//
//     final feeModel = feeModelFromJson(jsonString);

import 'dart:convert';

FeeModel feeModelFromJson(String str) => FeeModel.fromJson(json.decode(str));

String feeModelToJson(FeeModel data) => json.encode(data.toJson());

class FeeModel {
  FeeModel({
    required this.status,
    required this.code,
    this.feeData,
  });

  String status;
  int code;
  FeeData? feeData;

  factory FeeModel.fromJson(Map<String, dynamic> json) => FeeModel(
    status: json["status"],
    code: json["code"],
    feeData: FeeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": feeData!.toJson(),
  };
}

class FeeData {
  FeeData({
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
  List<FeePendingDetail>? feePendingDetail;

  factory FeeData.fromJson(Map<String, dynamic> json) => FeeData(
    id: json["id"],
    total: json["total"],
    paid: json["paid"],
    discount: json["discount"],
    pending: json["pending"],
    percentage: json["percentage"],
    feePendingDetail: List<FeePendingDetail>.from(json["fee_pending_detail"].map((x) => FeePendingDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total": total,
    "paid": paid,
    "discount": discount,
    "pending": pending,
    "percentage": percentage,
    "fee_pending_detail": List<dynamic>.from(feePendingDetail!.map((x) => x.toJson())),
  };
}

class FeePendingDetail {
  FeePendingDetail({
    this.id,
    this.stuFeePendingId,
    this.name,
    this.total,
    this.paid,
    this.discount,
    this.pending,
    this.extraPaidTotal,
    this.type,
    this.feeGroupDetail,
  });

  int? id;
  int? stuFeePendingId;
  String? name;
  int? total;
  int? paid;
  int? discount;
  int? pending;
  int? extraPaidTotal;
  int? type;
  List<FeeGroupDetail>? feeGroupDetail;

  factory FeePendingDetail.fromJson(Map<String, dynamic> json) => FeePendingDetail(
    id: json["id"],
    stuFeePendingId: json["stu_fee_pending_id"],
    name: json["name"],
    total: json["total"],
    paid: json["paid"],
    discount: json["discount"],
    pending: json["pending"],
    extraPaidTotal: json["extra_paid_total"],
    type: json["type"],
    feeGroupDetail: List<FeeGroupDetail>.from(json["fee_group_detail"].map((x) => FeeGroupDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stu_fee_pending_id": stuFeePendingId,
    "name": name,
    "total": total,
    "paid": paid,
    "discount": discount,
    "pending": pending,
    "extra_paid_total": extraPaidTotal,
    "type": type,
    "fee_group_detail": List<dynamic>.from(feeGroupDetail!.map((x) => x.toJson())),
  };
}

class FeeGroupDetail {
  FeeGroupDetail({
    this.id,
    this.academicFeeGroupId,
    this.feeRateId,
    this.feeCategoryId,
    this.feeAccountId,
    this.type,
    this.name,
    this.total,
    this.paid,
    this.discount,
    this.pending,
    this.extraPaidTotal,
    this.checkboxClicked = false,
    this.feeTermMonthPending,
  });

  int? id;
  int? academicFeeGroupId;
  int? feeRateId;
  int? feeCategoryId;
  int? feeAccountId;
  int? type;
  String? name;
  int? total;
  int? paid;
  int? discount;
  int? pending;
  int? extraPaidTotal;
  bool? checkboxClicked;
  List<FeeTermMonthPending>? feeTermMonthPending;

  factory FeeGroupDetail.fromJson(Map<String, dynamic> json) => FeeGroupDetail(
    id: json["id"],
    academicFeeGroupId: json["academic_fee_group_id"],
    feeRateId: json["fee_rate_id"],
    feeCategoryId: json["fee_category_id"],
    feeAccountId: json["fee_account_id"],
    type: json["type"],
    name: json["name"],
    total: json["total"],
    paid: json["paid"],
    discount: json["discount"],
    pending: json["pending"],
    extraPaidTotal: json["extra_paid_total"],
    feeTermMonthPending: List<FeeTermMonthPending>.from(json["fee_term_month_pending"].map((x) => FeeTermMonthPending.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "academic_fee_group_id": academicFeeGroupId,
    "fee_rate_id": feeRateId,
    "fee_category_id": feeCategoryId,
    "fee_account_id": feeAccountId,
    "type": type,
    "name": name,
    "total": total,
    "paid": paid,
    "discount": discount,
    "pending": pending,
    "extra_paid_total": extraPaidTotal,
    "fee_term_month_pending": List<dynamic>.from(feeTermMonthPending!.map((x) => x.toJson())),
  };
}

class FeeTermMonthPending {
  FeeTermMonthPending({
    this.id,
    this.termListId,
    this.monthListId,
    this.name,
    this.total,
    this.paid,
    this.discount,
    this.pending,
    this.extraPaidTotal,
    this.checkboxClicked=false,
  });

  int? id;
  int? termListId;
  int? monthListId;
  String? name;
  int? total;
  int? paid;
  int? discount;
  int? pending;
  int? extraPaidTotal;
  bool? checkboxClicked;

  factory FeeTermMonthPending.fromJson(Map<String, dynamic> json) => FeeTermMonthPending(
    id: json["id"],
    termListId: json["term_list_id"],
    monthListId: json["month_list_id"],
    name: json["name"],
    total: json["total"],
    paid: json["paid"],
    discount: json["discount"],
    pending: json["pending"],
    extraPaidTotal: json["extra_paid_total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "term_list_id": termListId,
    "month_list_id": monthListId,
    "name": name,
    "total": total,
    "paid": paid,
    "discount": discount,
    "pending": pending,
    "extra_paid_total": extraPaidTotal,
  };
}
