
import 'dart:convert';

FeeInvoiceSingleModel feeInvoiceSingleModelFromJson(String str) => FeeInvoiceSingleModel.fromJson(json.decode(str));

String feeInvoiceSingleModelToJson(FeeInvoiceSingleModel data) => json.encode(data.toJson());

class FeeInvoiceSingleModel {
  FeeInvoiceSingleModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  FeeInvoiceSingleData? data;

  factory FeeInvoiceSingleModel.fromJson(Map<String, dynamic> json) => FeeInvoiceSingleModel(
    status: json["status"],
    code: json["code"],
    data: FeeInvoiceSingleData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data!.toJson(),
  };
}

class FeeInvoiceSingleData {
  FeeInvoiceSingleData({
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
    this.feeDetail,
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
  List<FeeDetail>? feeDetail;

  factory FeeInvoiceSingleData.fromJson(Map<String, dynamic> json) => FeeInvoiceSingleData(
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
    feeDetail: List<FeeDetail>.from(json["fee_detail"].map((x) => FeeDetail.fromJson(x))),
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
    "fee_detail": List<dynamic>.from(feeDetail!.map((x) => x.toJson())),
  };
}

class FeeDetail {
  FeeDetail({
    this.id,
    this.name,
    this.fees,
  });

  int? id;
  String? name;
  List<Fee>? fees;

  factory FeeDetail.fromJson(Map<String, dynamic> json) => FeeDetail(
    id: json["id"],
    name: json["name"],
    fees: List<Fee>.from(json["fees"].map((x) => Fee.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "fees": List<dynamic>.from(fees!.map((x) => x.toJson())),
  };
}

class Fee {
  Fee({
    this.id,
    this.amount,
    this.feeGroupName,
    this.feeCategoryName,
    this.remark,
    this.items,
  });

  int? id;
  String? amount;
  String? feeGroupName;
  String? feeCategoryName;
  dynamic remark;
  List<Item>? items;

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
    id: json["id"],
    amount: json["amount"],
    feeGroupName: json["fee_group_name"],
    feeCategoryName: json["fee_category_name"],
    remark: json["remark"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "fee_group_name": feeGroupName,
    "fee_category_name": feeCategoryName,
    "remark": remark,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.id,
    this.amount,
    this.name,
  });

  int? id;
  String? amount;
  String? name;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    amount: json["amount"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "name": name,
  };
}
