import 'dart:convert';

CalenderModel calenderModelFromJson(String str) =>
    CalenderModel.fromJson(json.decode(str));

String calenderModelToJson(CalenderModel data) => json.encode(data.toJson());

class CalenderModel {
  CalenderModel({
    this.calenderData,
    required this.code,
    required this.status,
    this.msg,
    this.error,
  });

  List<CalenderData>? calenderData;
  int code;
  String status;
  String? msg;
  String? error;

  factory CalenderModel.fromJson(Map<String, dynamic> json) => CalenderModel(
      calenderData: List<CalenderData>.from(
          json["data"].map((x) => CalenderData.fromJson(x))),
      code: json["code"],
      status: json["status"],
      msg: json["msg"],
      error: json.containsKey("error") ? json["error"] : "");

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(calenderData!.map((x) => x.toJson())),
        "code": code,
        "status": status,
        "msg": msg,
      };
}

class CalenderData {
  CalenderData({
    this.id,
    this.title,
    this.description,
    this.eventTypeId,
    this.eventTypeName,
    this.eventPrivacy,
    this.start,
    this.end,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.backgroundColor,
  });

  int? id;
  String? title;
  String? description;
  int? eventTypeId;
  String? eventTypeName;
  int? eventPrivacy;
  DateTime? start;
  DateTime? end;
  DateTime? startDate;
  String? startTime;
  DateTime? endDate;
  String? endTime;
  String? backgroundColor;

  factory CalenderData.fromJson(Map<String, dynamic> json) => CalenderData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        eventTypeId: json["event_type_id"],
        eventTypeName: json["event_type_name"],
        eventPrivacy: json["event_privacy"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        startDate: DateTime.parse(json["start_date"]),
        startTime: json["start_time"],
        endDate: DateTime.parse(json["end_date"]),
        endTime: json["end_time"],
        backgroundColor: json["backgroundColor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "event_type_id": eventTypeId,
        "event_type_name": eventTypeName,
        "event_privacy": eventPrivacy,
        "start": start!.toIso8601String(),
        "end": end!.toIso8601String(),
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "end_time": endTime,
        "backgroundColor": backgroundColor,
      };
}
