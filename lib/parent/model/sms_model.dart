import 'dart:convert';

SmsModel smsModelFromJson(String str) => SmsModel.fromJson(json.decode(str));

String smsModelToJson(SmsModel data) => json.encode(data.toJson());

class SmsModel {
  SmsModel({
    this.smsData,
    this.links,
    this.meta,
    required this.code,
    required this.status,
    this.msg,
  });

  List<SmsData>? smsData;
  Links? links;
  Meta? meta;
  int? code;
  String status;
  String? msg;

  factory SmsModel.fromJson(Map<String, dynamic> json) => SmsModel(
    smsData: List<SmsData>.from(json["data"].map((x) => SmsData.fromJson(x))),
    links: json.containsKey("links") ? Links.fromJson(json["links"]) : Links(),
    meta: json.containsKey("meta")?Meta.fromJson(json["meta"]):Meta(),
    code: json["code"],
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(smsData!.map((x) => x.toJson())),
    "links": links!.toJson(),
    "meta": meta!.toJson(),
    "code": code,
    "status": status,
    "msg": msg,
  };
}

class SmsData {
  SmsData({
    this.id,
    this.date,
    this.timeStamp,
    this.title,
    this.smsDetail,
  });

  int? id;
  String? date;
  int? timeStamp;
  String? title;
  String? smsDetail;

  factory SmsData.fromJson(Map<String, dynamic> json) => SmsData(
    id: json["id"],
    date: json["date"],
    timeStamp: json["time_stamp"],
    title: json["title"],
    smsDetail: json["sms_detail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "time_stamp": timeStamp,
    "title": title,
    "sms_detail": smsDetail,
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
  String? next;

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
