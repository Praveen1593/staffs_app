// To parse this JSON data, do
//
//     final payrollLeaveType = payrollLeaveTypeFromJson(jsonString);

import 'dart:convert';

PayrollLeaveTypeModel payrollLeaveTypeFromJson(String str) => PayrollLeaveTypeModel.fromJson(json.decode(str));

String payrollLeaveTypeToJson(PayrollLeaveTypeModel data) => json.encode(data.toJson());

class PayrollLeaveTypeModel {
  PayrollLeaveTypeModel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  List<Datum>? data;

  factory PayrollLeaveTypeModel.fromJson(Map<String, dynamic> json) => PayrollLeaveTypeModel(
    status: json["status"],
    code: json["code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.type,
    this.name,
  });

  int? id;
  int? type;
  String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
  };
}
