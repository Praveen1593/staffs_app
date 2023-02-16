// To parse this JSON data, do
//
//     final materialBillModel = materialBillModelFromJson(jsonString);

import 'dart:convert';

import '../../../../../common/enums/loading_enums.dart';

MaterialBillModel materialBillModelFromJson(String str) => MaterialBillModel.fromJson(json.decode(str));

String materialBillModelToJson(MaterialBillModel data) => json.encode(data.toJson());

class MaterialBillModel {
  MaterialBillModel({
    this.data,
    this.links,
    required this.meta,
    required this.code,
    required this.status,
    required this.msg,
  });

  List<MaterialListData>? data;
  Links? links;
  Meta meta;
  int code;
  String status;
  String msg;

  factory MaterialBillModel.fromJson(Map<String, dynamic> json) => MaterialBillModel(
    data: List<MaterialListData>.from(json["data"].map((x) => MaterialListData.fromJson(x))),
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

class MaterialListData {
  MaterialListData({
    this.id,
    this.uuid,
    this.code,
    this.billDate,
    this.billTo,
    this.billPayType,
    this.amount,
    this.createdBy,
    this.items,
  });

  int? id;
  String? uuid;
  String? code;
  String? billDate;
  String? billTo;
  String? billPayType;
  String? amount;
  String? createdBy;
  List<Item>? items;

  factory MaterialListData.fromJson(Map<String, dynamic> json) => MaterialListData(
    id: json["id"],
    uuid: json["uuid"],
    code: json["code"],
    billDate: json["bill_date"],
    billTo: json["bill_to"],
    billPayType: json["bill_pay_type"],
    amount: json["amount"],
    createdBy: json["created_by"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "code": code,
    "bill_date": billDate,
    "bill_to": billTo,
    "bill_pay_type": billPayType,
    "amount": amount,
    "created_by": createdBy,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.id,
    this.productName,
    this.brandName,
    this.sizeName,
    this.qtyUom,
    this.qty,
    this.price,
    this.total,
  });

  int? id;
  String? productName;
  String? brandName;
  String? sizeName;
  String? qtyUom;
  int? qty;
  String? price;
  String? total;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    productName: json["product_name"],
    brandName: json["brand_name"],
    sizeName: json["size_name"],
    qtyUom: json["qty_uom"],
    qty: json["qty"],
    price: json["price"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "brand_name": brandName,
    "size_name": sizeName,
    "qty_uom": qtyUom,
    "qty": qty,
    "price": price,
    "total": total,
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

class MaterialBillLoadingState {
  LoadingType? loadingType;
  String? error;
  String? completed;

  MaterialBillLoadingState({required this.loadingType, this.error, this.completed});
}

