import 'dart:convert';

GenderListModel genderListModelFromJson(String str) =>
    GenderListModel.fromJson(json.decode(str));

String genderListModelToJson(GenderListModel data) =>
    json.encode(data.toJson());

class GenderListModel {
  GenderListModel({
    required this.status,
    required this.code,
    required this.genderData,
  });

  String status;
  int code;
  List<GenderData> genderData;

  factory GenderListModel.fromJson(Map<String, dynamic> json) =>
      GenderListModel(
        status: json["status"],
        code: json["code"],
        genderData: List<GenderData>.from(
            json["data"].map((x) => GenderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": List<dynamic>.from(genderData.map((x) => x.toJson())),
      };
}

class GenderData {
  GenderData({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory GenderData.fromJson(Map<String, dynamic> json) => GenderData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
