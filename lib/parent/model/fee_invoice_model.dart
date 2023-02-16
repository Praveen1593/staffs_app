// To parse this JSON data, do
//
//     final feeInvoiceModel = feeInvoiceModelFromJson(jsonString);

import 'dart:convert';

import '../../../../../common/enums/loading_enums.dart';


FeeInvoiceModel feeInvoiceModelFromJson(String str) => FeeInvoiceModel.fromJson(json.decode(str));

String feeInvoiceModelToJson(FeeInvoiceModel data) => json.encode(data.toJson());

class FeeInvoiceModel {
  FeeInvoiceModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  List<InvoiceData>? data;

  factory FeeInvoiceModel.fromJson(Map<String, dynamic> json) => FeeInvoiceModel(
    status: json["status"],
    code: json["code"],
    data: List<InvoiceData>.from(json["data"].map((x) => InvoiceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class InvoiceData {
  InvoiceData({
    this.id,
    this.frNo,
    this.billDate,
    this.total,
    this.studentName,
    this.standardSection,
    this.discountType,
    this.billPayType,
    this.studentType,
    this.createdBy,
    this.createdAt,
  });

  int? id;
  String? frNo;
  String? billDate;
  String? total;
  String? studentName;
  String? standardSection;
  String? discountType;
  String? billPayType;
  String? studentType;
  String? createdBy;
  String? createdAt;

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
    id: json["id"],
    frNo: json["fr_no"],
    billDate: json["bill_date"],
    total: json["total"],
    studentName: json["student_name"],
    standardSection: json["standard_section"],
    discountType: json["discount_type"],
    billPayType: json["bill_pay_type"],
    studentType: json["student_type"],
    createdBy: json["created_by"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fr_no": frNo,
    "bill_date": billDate,
    "total": total,
    "student_name": studentName,
    "standard_section": standardSection,
    "discount_type": discountType,
    "bill_pay_type": billPayType,
    "student_type": studentType,
    "created_by": createdBy,
    "created_at": createdAt,
  };

}


class LoadingState {
  LoadingType loadingType;
  String? error;
  String? completed;

  LoadingState({required this.loadingType, this.error, this.completed});
}