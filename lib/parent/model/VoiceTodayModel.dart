// To parse this JSON data, do
//
//     final voiceTodayModel = voiceTodayModelFromJson(jsonString);

import 'dart:convert';

VoiceTodayModel voiceTodayModelFromJson(String str) =>
    VoiceTodayModel.fromJson(json.decode(str));

String voiceTodayModelToJson(VoiceTodayModel data) =>
    json.encode(data.toJson());

class VoiceTodayModel {
  VoiceTodayModel({
    this.data,
    required this.code,
    required this.status,
    required this.msg,
  });

  List<VoiceTodayData>? data;
  int code;
  String status;
  String msg;

  factory VoiceTodayModel.fromJson(Map<String, dynamic> json) =>
      VoiceTodayModel(
        data: List<VoiceTodayData>.from(
            json["data"].map((x) => VoiceTodayData.fromJson(x))),
        code: json["code"],
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
        "status": status,
        "msg": msg,
      };
}

class VoiceTodayData {
  VoiceTodayData({
    this.id,
    this.date,
    this.timeStamp,
    this.title,
    this.voiceMsgFile,
  });

  int? id;
  String? date;
  int? timeStamp;
  String? title;
  String? voiceMsgFile;

  factory VoiceTodayData.fromJson(Map<String, dynamic> json) => VoiceTodayData(
        id: json["id"],
        date: json["date"],
        timeStamp: json["time_stamp"],
        title: json["title"],
        voiceMsgFile: json["voice_msg_file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "time_stamp": timeStamp,
        "title": title,
        "voice_msg_file": voiceMsgFile,
      };
}
