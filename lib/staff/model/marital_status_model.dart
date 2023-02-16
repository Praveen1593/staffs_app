import 'dart:convert';

MaritalStatusModel maritalStatusModelFromJson(String str) => MaritalStatusModel.fromJson(json.decode(str));

String maritalStatusModelToJson(MaritalStatusModel data) => json.encode(data.toJson());

class MaritalStatusModel {
  MaritalStatusModel({
    required this.status,
    required this.code,
    this.maritalStatusData,
  });

  String status;
  int code;
  List<MaritalStatusData>? maritalStatusData;

  factory MaritalStatusModel.fromJson(Map<String, dynamic> json) => MaritalStatusModel(
    status: json["status"],
    code: json["code"],
    maritalStatusData: List<MaritalStatusData>.from(json["data"].map((x) => MaritalStatusData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(maritalStatusData!.map((x) => x.toJson())),
  };
}

class MaritalStatusData {
  MaritalStatusData({
    this.id,
    this.code,
    this.name,
  });

  int? id;
  String? code;
  String? name;

  factory MaritalStatusData.fromJson(Map<String, dynamic> json) => MaritalStatusData(
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
