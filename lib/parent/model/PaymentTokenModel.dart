// To parse this JSON data, do
//
//     final paymentTokenModel = paymentTokenModelFromJson(jsonString);

import 'dart:convert';

PaymentTokenModel paymentTokenModelFromJson(String str) => PaymentTokenModel.fromJson(json.decode(str));

String paymentTokenModelToJson(PaymentTokenModel data) => json.encode(data.toJson());

class PaymentTokenModel {
  PaymentTokenModel({
    this.type,
    this.token,
    this.expiresOn,
    this.expiryMonth,
    this.expiryYear,
    this.name,
    this.scheme,
    this.last4,
    this.bin,
    this.cardType,
    this.cardCategory,
    this.issuerCountry,
    this.productId,
    this.productType,
  });

  String? type;
  String? token;
  DateTime? expiresOn;
  int? expiryMonth;
  int? expiryYear;
  String? name;
  String? scheme;
  String? last4;
  String? bin;
  String? cardType;
  String? cardCategory;
  String? issuerCountry;
  String? productId;
  String? productType;

  factory PaymentTokenModel.fromJson(Map<String, dynamic> json) => PaymentTokenModel(
    type: json["type"],
    token: json["token"],
    expiresOn: DateTime.parse(json["expires_on"]),
    expiryMonth: json["expiry_month"],
    expiryYear: json["expiry_year"],
    name: json["name"],
    scheme: json["scheme"],
    last4: json["last4"],
    bin: json["bin"],
    cardType: json["card_type"],
    cardCategory: json["card_category"],
    issuerCountry: json["issuer_country"],
    productId: json["product_id"],
    productType: json["product_type"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "token": token,
    "expires_on": expiresOn!.toIso8601String(),
    "expiry_month": expiryMonth,
    "expiry_year": expiryYear,
    "name": name,
    "scheme": scheme,
    "last4": last4,
    "bin": bin,
    "card_type": cardType,
    "card_category": cardCategory,
    "issuer_country": issuerCountry,
    "product_id": productId,
    "product_type": productType,
  };
}
