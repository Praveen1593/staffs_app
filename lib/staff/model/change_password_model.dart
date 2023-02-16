import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) =>
    ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel data) =>
    json.encode(data.toJson());

class ChangePasswordModel {
  ChangePasswordModel(
      {required this.status, this.messages, required this.code, this.error});

  String status;
  String? messages;
  int code;
  String? error;

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordModel(
          status: json["status"],
          messages: json.containsKey("messages") ? json["messages"] : "",
          code: json["code"],
          error: json.containsKey("error") ? json["error"] : "");

  Map<String, dynamic> toJson() => {
        "status": status,
        "messages": messages,
        "code": code,
      };
}
