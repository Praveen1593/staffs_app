import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.status,
    required this.code,
    this.loginData,
    this.message,
  });

  String status;
  int code;
  LoginData? loginData;
  String? message;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      status: json["status"],
      code: json["code"],
      loginData: json.containsKey("data")
          ? LoginData.fromJson(json["data"])
          : LoginData(),
      message: json.containsKey("message") ? json["message"] : "");

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": loginData!.toJson(),
      };
}

class LoginData {
  LoginData({
    this.token,
    this.id,
    this.uuid,
    this.code,
    this.username,
    this.phone,
    this.studentId,
    this.photo,
    this.tokenType,
    this.error,
    this.message,
    this.expiresAt,
    this.studentPhoto,
  });

  String? token;
  int? id;
  String? uuid;
  String? code;
  String? username;
  String? phone;
  int? studentId;
  String? photo;
  String? tokenType;
  bool? error;
  String? message;
  DateTime? expiresAt;
  String? studentPhoto;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json["token"],
        id: json["id"],
        uuid: json["uuid"],
        code: json["code"],
        username: json["username"],
        phone: json["phone"],
        studentId: json["student_id"],
        photo: json["photo"],
        tokenType: json["token_type"],
        error: json["error"],
        message: json["message"],
        expiresAt: DateTime.parse(json["expires_at"]),
        studentPhoto: json["student_photo"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
        "uuid": uuid,
        "code": code,
        "username": username,
        "phone": phone,
        "student_id": studentId,
        "photo": photo,
        "token_type": tokenType,
        "error": error,
        "message": message,
        "expires_at": expiresAt!.toIso8601String(),
      };
}
