import 'dart:convert';

MonthListModel monthListModelFromJson(String str) => MonthListModel.fromJson(json.decode(str));

String monthListModelToJson(MonthListModel data) => json.encode(data.toJson());

class MonthListModel {
  MonthListModel({
    required this.status,
    required this.code,
    required this.monthData,
  });

  String status;
  int code;
  List<MonthListData> monthData;

  factory MonthListModel.fromJson(Map<String, dynamic> json) => MonthListModel(
    status: json["status"],
    code: json["code"],
    monthData: List<MonthListData>.from(json["data"].map((x) => MonthListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(monthData.map((x) => x.toJson())),
  };
}

class MonthListData {
  MonthListData({
    this.id,
    this.uuid,
    this.code,
    this.commonName,
    this.monthNo,
    this.name,
    this.shortName,
  });

  int? id;
  String? uuid;
  String? code;
  String? commonName;
  int? monthNo;
  String? name;
  String? shortName;

  factory MonthListData.fromJson(Map<String, dynamic> json) => MonthListData(
    id: json["id"],
    uuid: json["uuid"],
    code: json["code"],
    commonName: json["common_name"],
    monthNo: json["month_no"],
    name: json["name"],
    shortName: json["short_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "code": code,
    "common_name": commonName,
    "month_no": monthNo,
    "name": name,
    "short_name": shortName,
  };
}
