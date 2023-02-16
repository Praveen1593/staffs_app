// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.code,
    required this.status,
    required this.msg,
    this.data,
  });

  int code;
  String status;
  String msg;
  List<NotificationData>? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    code: json["code"],
    status: json["status"],
    msg: json["msg"],
    data: List<NotificationData>.from(json["data"].map((x) => NotificationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
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
    description: json["description"] == null ? null : json["description"],
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
    "description": description == null ? null : description,
    "notifiedtable_id": notifiedtableId,
    "type": type,
    "type_name": typeName,
    "status": status,
    "mobile_app_status": mobileAppStatus,
    "posted_by": postedBy,
    "posted_at": postedAt,
  };
}
