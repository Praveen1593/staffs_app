
import 'dart:convert';

ProfessionModel ProfessionModelFromJson(String str) => ProfessionModel.fromJson(json.decode(str));

String ProfessionModelToJson(ProfessionModel data) => json.encode(data.toJson());

class ProfessionModel {
  ProfessionModel({
    required this.status,
    required this.code,
    required this.data,
  });

  String status;
  int code;
  List<ProfessionDatum> data;

  factory ProfessionModel.fromJson(Map<String, dynamic> json) => ProfessionModel(
    status: json["status"],
    code: json["code"],
    data: List<ProfessionDatum>.from(json["data"].map((x) => ProfessionDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProfessionDatum {
  ProfessionDatum({
    this.id,
    this.code,
    this.name,
  });

  int? id;
  String? code;
  String? name;

  factory ProfessionDatum.fromJson(Map<String, dynamic> json) => ProfessionDatum(
    id: json["id"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
  };
}
