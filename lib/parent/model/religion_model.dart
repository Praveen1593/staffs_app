
import 'dart:convert';

ReligionModel religionModelFromJson(String str) => ReligionModel.fromJson(json.decode(str));

String religionModelToJson(ReligionModel data) => json.encode(data.toJson());

class ReligionModel {
  ReligionModel({
    required this.status,
    required this.code,
    required this.data,
  });

  String status;
  int code;
  List<Datum> data;

  factory ReligionModel.fromJson(Map<String, dynamic> json) => ReligionModel(
    status: json["status"],
    code: json["code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.code,
    this.name,
  });

  int? id;
  String? code;
  String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
