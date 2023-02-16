// To parse this JSON data, do
//
//     final knetPaymentResponceModel = knetPaymentResponceModelFromJson(jsonString);

import 'dart:convert';

KnetPaymentResponceModel knetPaymentResponceModelFromJson(String str) => KnetPaymentResponceModel.fromJson(json.decode(str));

String knetPaymentResponceModelToJson(KnetPaymentResponceModel data) => json.encode(data.toJson());

class KnetPaymentResponceModel {
  KnetPaymentResponceModel({
    this.id,
    this.actionId,
    this.amount,
    this.currency,
    this.approved,
    this.status,
    this.authCode,
    this.responseCode,
    this.responseSummary,
    this.balances,
    this.risk,
    this.source,
    this.customer,
    this.processedOn,
    this.reference,
    this.schemeId,
    this.processing,
    this.expiresOn,
    this.links,
  });

  String? id;
  String? actionId;
  int? amount;
  String? currency;
  bool? approved;
  String? status;
  String? authCode;
  String? responseCode;
  String? responseSummary;
  Balances? balances;
  Risk? risk;
  Source? source;
  Customer? customer;
  DateTime? processedOn;
  String? reference;
  String? schemeId;
  Processing? processing;
  DateTime? expiresOn;
  Links? links;

  factory KnetPaymentResponceModel.fromJson(Map<String, dynamic> json) => KnetPaymentResponceModel(
    id: json["id"],
    actionId: json["action_id"],
    amount: json["amount"],
    currency: json["currency"],
    approved: json["approved"],
    status: json["status"],
    authCode: json["auth_code"],
    responseCode: json["response_code"],
    responseSummary: json["response_summary"],
    balances: Balances.fromJson(json["balances"]),
    risk: Risk.fromJson(json["risk"]),
    source: Source.fromJson(json["source"]),
    customer: Customer.fromJson(json["customer"]),
    processedOn: DateTime.parse(json["processed_on"]),
    reference: json["reference"],
    schemeId: json["scheme_id"],
    processing: Processing.fromJson(json["processing"]),
    expiresOn: DateTime.parse(json["expires_on"]),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "action_id": actionId,
    "amount": amount,
    "currency": currency,
    "approved": approved,
    "status": status,
    "auth_code": authCode,
    "response_code": responseCode,
    "response_summary": responseSummary,
    "balances": balances!.toJson(),
    "risk": risk!.toJson(),
    "source": source!.toJson(),
    "customer": customer!.toJson(),
    "processed_on": processedOn!.toIso8601String(),
    "reference": reference,
    "scheme_id": schemeId,
    "processing": processing!.toJson(),
    "expires_on": expiresOn!.toIso8601String(),
    "_links": links!.toJson(),
  };
}

class Balances {
  Balances({
    this.totalAuthorized,
    this.totalVoided,
    this.availableToVoid,
    this.totalCaptured,
    this.availableToCapture,
    this.totalRefunded,
    this.availableToRefund,
  });

  int? totalAuthorized;
  int? totalVoided;
  int? availableToVoid;
  int? totalCaptured;
  int? availableToCapture;
  int? totalRefunded;
  int? availableToRefund;

  factory Balances.fromJson(Map<String, dynamic> json) => Balances(
    totalAuthorized: json["total_authorized"],
    totalVoided: json["total_voided"],
    availableToVoid: json["available_to_void"],
    totalCaptured: json["total_captured"],
    availableToCapture: json["available_to_capture"],
    totalRefunded: json["total_refunded"],
    availableToRefund: json["available_to_refund"],
  );

  Map<String, dynamic> toJson() => {
    "total_authorized": totalAuthorized,
    "total_voided": totalVoided,
    "available_to_void": availableToVoid,
    "total_captured": totalCaptured,
    "available_to_capture": availableToCapture,
    "total_refunded": totalRefunded,
    "available_to_refund": availableToRefund,
  };
}

class Customer {
  Customer({
    this.id,
    this.email,
    this.name,
  });

  String? id;
  String? email;
  String? name;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    email: json["email"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
  };
}

class Links {
  Links({
    this.self,
    this.actions,
    this.capture,
    this.linksVoid,
  });

  Actions? self;
  Actions? actions;
  Actions? capture;
  Actions? linksVoid;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: Actions.fromJson(json["self"]),
    actions: Actions.fromJson(json["actions"]),
    capture: Actions.fromJson(json["capture"]),
    linksVoid: Actions.fromJson(json["void"]),
  );

  Map<String, dynamic> toJson() => {
    "self": self!.toJson(),
    "actions": actions!.toJson(),
    "capture": capture!.toJson(),
    "void": linksVoid!.toJson(),
  };
}

class Actions {
  Actions({
    this.href,
  });

  String? href;

  factory Actions.fromJson(Map<String, dynamic> json) => Actions(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Processing {
  Processing({
    this.acquirerTransactionId,
    this.retrievalReferenceNumber,
  });

  String? acquirerTransactionId;
  String? retrievalReferenceNumber;

  factory Processing.fromJson(Map<String, dynamic> json) => Processing(
    acquirerTransactionId: json["acquirer_transaction_id"],
    retrievalReferenceNumber: json["retrieval_reference_number"],
  );

  Map<String, dynamic> toJson() => {
    "acquirer_transaction_id": acquirerTransactionId,
    "retrieval_reference_number": retrievalReferenceNumber,
  };
}

class Risk {
  Risk({
    this.flagged,
    this.score,
  });

  bool? flagged;
  double? score;

  factory Risk.fromJson(Map<String, dynamic> json) => Risk(
    flagged: json["flagged"],
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "flagged": flagged,
    "score": score,
  };
}

class Source {
  Source({
    this.id,
    this.type,
    this.billingAddress,
    this.phone,
    this.expiryMonth,
    this.expiryYear,
    this.name,
    this.scheme,
    this.last4,
    this.fingerprint,
    this.bin,
    this.cardType,
    this.cardCategory,
    this.issuerCountry,
    this.productId,
    this.productType,
    this.avsCheck,
    this.cvvCheck,
    this.paymentAccountReference,
  });

  String? id;
  String? type;
  BillingAddress? billingAddress;
  Phone? phone;
  int? expiryMonth;
  int? expiryYear;
  String? name;
  String? scheme;
  String? last4;
  String? fingerprint;
  String? bin;
  String? cardType;
  String? cardCategory;
  String? issuerCountry;
  String? productId;
  String? productType;
  String? avsCheck;
  String? cvvCheck;
  String? paymentAccountReference;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],
    type: json["type"],
    billingAddress: BillingAddress.fromJson(json["billing_address"]),
    phone: Phone.fromJson(json["phone"]),
    expiryMonth: json["expiry_month"],
    expiryYear: json["expiry_year"],
    name: json["name"],
    scheme: json["scheme"],
    last4: json["last4"],
    fingerprint: json["fingerprint"],
    bin: json["bin"],
    cardType: json["card_type"],
    cardCategory: json["card_category"],
    issuerCountry: json["issuer_country"],
    productId: json["product_id"],
    productType: json["product_type"],
    avsCheck: json["avs_check"],
    cvvCheck: json["cvv_check"],
    paymentAccountReference: json["payment_account_reference"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "billing_address": billingAddress!.toJson(),
    "phone": phone!.toJson(),
    "expiry_month": expiryMonth,
    "expiry_year": expiryYear,
    "name": name,
    "scheme": scheme,
    "last4": last4,
    "fingerprint": fingerprint,
    "bin": bin,
    "card_type": cardType,
    "card_category": cardCategory,
    "issuer_country": issuerCountry,
    "product_id": productId,
    "product_type": productType,
    "avs_check": avsCheck,
    "cvv_check": cvvCheck,
    "payment_account_reference": paymentAccountReference,
  };
}

class BillingAddress {
  BillingAddress({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.zip,
    this.country,
  });

  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? zip;
  String? country;

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "city": city,
    "state": state,
    "zip": zip,
    "country": country,
  };
}

class Phone {
  Phone({
    this.number,
    this.countryCode,
  });

  String? number;
  String? countryCode;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
    number: json["number"],
    countryCode: json["country_code"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "country_code": countryCode,
  };
}
