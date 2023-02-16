// To parse this JSON data, do
//
//     final paymentErrorModel = paymentErrorModelFromJson(jsonString);

import 'dart:convert';

PaymentErrorModel paymentErrorModelFromJson(String str) => PaymentErrorModel.fromJson(json.decode(str));

String paymentErrorModelToJson(PaymentErrorModel data) => json.encode(data.toJson());

class PaymentErrorModel {
  PaymentErrorModel({
    this.requestId,
    this.errorType,
    this.errorCodes,
  });

  String? requestId;
  String? errorType;
  List<String>? errorCodes;

  factory PaymentErrorModel.fromJson(Map<String, dynamic> json) => PaymentErrorModel(
    requestId: json["request_id"],
    errorType: json["error_type"],
    errorCodes: List<String>.from(json["error_codes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "request_id": requestId,
    "error_type": errorType,
    "error_codes": List<dynamic>.from(errorCodes!.map((x) => x)),
  };
}
