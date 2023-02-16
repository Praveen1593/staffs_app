// To parse this JSON data, do
//
//     final voiceOverallModel = voiceOverallModelFromJson(jsonString);

import 'dart:convert';

VoiceOverallModel voiceOverallModelFromJson(String str) => VoiceOverallModel.fromJson(json.decode(str));

String voiceOverallModelToJson(VoiceOverallModel data) => json.encode(data.toJson());

class VoiceOverallModel {
  VoiceOverallModel({
    this.data,
    this.links,
    required this.meta,
    required this.code,
    required this.status,
    required this.msg,
  });

  List<VoiceOverallData>? data;
  Links? links;
  Meta meta;
  int code;
  String status;
  String msg;

  factory VoiceOverallModel.fromJson(Map<String, dynamic> json) => VoiceOverallModel(
    data: List<VoiceOverallData>.from(json["data"].map((x) => VoiceOverallData.fromJson(x))),
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

class VoiceOverallData {
  VoiceOverallData({
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

  factory VoiceOverallData.fromJson(Map<String, dynamic> json) => VoiceOverallData(
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
