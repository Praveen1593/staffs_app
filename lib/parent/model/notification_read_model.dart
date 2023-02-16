// To parse this JSON data, do
//
//     final notificationReadModel = notificationReadModelFromJson(jsonString);

import 'dart:convert';

NotificationReadModel notificationReadModelFromJson(String str) => NotificationReadModel.fromJson(json.decode(str));

String notificationReadModelToJson(NotificationReadModel data) => json.encode(data.toJson());

class NotificationReadModel {
  NotificationReadModel({
    required this.code,
    required this.status,
    this.msg,
    this.data,
  });

  int code;
  String status;
  String? msg;
  NotificationData? data;

  factory NotificationReadModel.fromJson(Map<String, dynamic> json) => NotificationReadModel(
    code: json["code"],
    status: json["status"],
    msg: json["msg"],
    data: NotificationData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "msg": msg,
    "data": data!.toJson(),
  };
}

class NotificationData {
  NotificationData({
    this.id,
    this.uuid,
    this.date,
    this.title,
    this.description,
    this.notifiedtableId,
    this.type,
    this.typeName,
    this.status,
    this.mobileAppStatus,
    this.postedBy,
    this.postedAt,
  });

  int? id;
  String? uuid;
  String? date;
  String? title;
  String? description;
  dynamic notifiedtableId;
  int? type;
  String? typeName;
  int? status;
  int? mobileAppStatus;
  dynamic postedBy;
  String? postedAt;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id: json["id"],
    uuid: json["uuid"],
    date: json["date"],
    title: json["title"],
    description: json["description"],
    notifiedtableId: json["notifiedtable_id"],
    type: json["type"],
    typeName: json["type_name"],
    status: json["status"],
    mobileAppStatus: json["mobile_app_status"],
    postedBy: json["posted_by"],
    postedAt: json["posted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "date": date,
    "title": title,
    "description": description,
    "notifiedtable_id": notifiedtableId,
    "type": type,
    "type_name": typeName,
    "status": status,
    "mobile_app_status": mobileAppStatus,
    "posted_by": postedBy,
    "posted_at": postedAt,
  };
}
