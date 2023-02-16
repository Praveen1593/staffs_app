// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.status,
    required this.code,
    required this.profileData,
  });

  String status;
  int code;
  ProfileData  profileData;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    code: json["code"],
    profileData: ProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": profileData.toJson(),
  };
}

class ProfileData {
  ProfileData({
    required this.userName,
    required this.code,
    this.email,
    required this.phone,
    required this.photo,
    required this.city,
    required this.pincode,
    required this.address,
    required this.fatherDetail,
    required this.motherDetail,
    required this.passportDetail,
  });

  String userName;
  String code;
  dynamic email;
  String phone;
  String photo;
  String city;
  String pincode;
  String address;
  FatherDetail fatherDetail;
  MotherDetail motherDetail;
  PassportDetail passportDetail;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    userName: json["user_name"],
    code: json["code"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    city: json["city"],
    pincode: json["pincode"],
    address: json["address"],
    fatherDetail: FatherDetail.fromJson(json["father_detail"]),
    motherDetail: MotherDetail.fromJson(json["mother_detail"]),
    passportDetail: PassportDetail.fromJson(json["passport_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "code": code,
    "email": email,
    "phone": phone,
    "photo": photo,
    "city": city,
    "pincode": pincode,
    "address": address,
    "father_detail": fatherDetail.toJson(),
    //"mother_detail": motherDetail.toJson(),
    "passport_detail": passportDetail.toJson(),
  };
}

class FatherDetail {
  FatherDetail({
    this.profession,
    required this.name,
    this.email,
    this.officeAddress,
    this.telephoneNo,
    required this.phoneNo,
    this.whatsAppNo,
    this.religionId,
    this.religionName,
    this.professionId,
    this.faIncomePerMonth,
    this.professionName,
    required this.photo,
  });

  dynamic profession;
  String name;
  dynamic email;
  dynamic officeAddress;
  dynamic telephoneNo;
  String phoneNo;
  dynamic whatsAppNo;
  dynamic religionId;
  dynamic religionName;
  dynamic professionId;
  dynamic faIncomePerMonth;
  dynamic professionName;
  String photo;

  factory FatherDetail.fromJson(Map<String, dynamic> json) => FatherDetail(
    profession: json["profession"],
    name: json["name"],
    email: json["email"],
    officeAddress: json["office_address"],
    telephoneNo: json["telephone_no"],
    phoneNo: json["phone_no"],
    whatsAppNo: json["whats_app_no"],
    religionId: json["religion_id"],
    religionName: json["religion_name"],
    professionId: json["profession_id"],
    faIncomePerMonth: json["fa_income_per_month"],
    professionName: json["profession_name"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "profession": profession,
    "name": name,
    "email": email,
    "office_address": officeAddress,
    "telephone_no": telephoneNo,
    "phone_no": phoneNo,
    "whats_app_no": whatsAppNo,
    "religion_id": religionId,
    "religion_name": religionName,
    "profession_id": professionId,
    "fa_income_per_month": faIncomePerMonth,
    "profession_name": professionName,
    "photo": photo,
  };
}

class MotherDetail {
  MotherDetail({
    this.profession,
    required this.name,
    this.email,
    this.officeAddress,
    this.telephoneNo,
    this.phoneNo,
    this.whatsAppNo,
    this.religionId,
    this.religionName,
    this.professionId,
    this.moIncomePerMonth,
    this.professionName,
    required this.photo,
  });

  dynamic profession;
  String name;
  dynamic email;
  dynamic officeAddress;
  dynamic telephoneNo;
  dynamic phoneNo;
  dynamic whatsAppNo;
  dynamic religionId;
  dynamic religionName;
  dynamic professionId;
  dynamic moIncomePerMonth;
  dynamic professionName;
  String photo;

  factory MotherDetail.fromJson(Map<String, dynamic> json) => MotherDetail(
    profession: json["profession"],
    name: json["name"],
    email: json["email"],
    officeAddress: json["office_address"],
    telephoneNo: json["telephone_no"],
    phoneNo: json["phone_no"],
    whatsAppNo: json["whats_app_no"],
    religionId: json["religion_id"],
    religionName: json["religion_name"],
    professionId: json["profession_id"],
    moIncomePerMonth: json["mo_income_per_month"],
    professionName: json["profession_name"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "profession": profession,
    "name": name,
    "email": email,
    "office_address": officeAddress,
    "telephone_no": telephoneNo,
    "phone_no": phoneNo,
    "whats_app_no": whatsAppNo,
    "religion_id": religionId,
    "religion_name": religionName,
    "profession_id": professionId,
    "mo_income_per_month": moIncomePerMonth,
    "profession_name": professionName,
    "photo": photo,
  };
}

class PassportDetail {
  PassportDetail({
    this.passportNo,
    this.dateOfIssue,
    this.dateOfExpiry,
    this.placeOfIssue,
    this.civilIdNo,
    this.residencePermitNo,
    this.dateOfResPermitIssue,
    this.dateOfResPermitExpiry,
    this.enteredCountryDate,
  });

  dynamic passportNo;
  dynamic dateOfIssue;
  dynamic dateOfExpiry;
  dynamic placeOfIssue;
  dynamic civilIdNo;
  dynamic residencePermitNo;
  dynamic dateOfResPermitIssue;
  dynamic dateOfResPermitExpiry;
  dynamic enteredCountryDate;

  factory PassportDetail.fromJson(Map<String, dynamic> json) => PassportDetail(
    passportNo: json["passport_no"],
    dateOfIssue: json["date_of_issue"],
    dateOfExpiry: json["date_of_expiry"],
    placeOfIssue: json["place_of_issue"],
    civilIdNo: json["civil_id_no"],
    residencePermitNo: json["residence_permit_no"],
    dateOfResPermitIssue: json["date_of_res_permit_issue"],
    dateOfResPermitExpiry: json["date_of_res_permit_expiry"],
    enteredCountryDate: json["entered_country_date"],
  );

  Map<String, dynamic> toJson() => {
    "passport_no": passportNo,
    "date_of_issue": dateOfIssue,
    "date_of_expiry": dateOfExpiry,
    "place_of_issue": placeOfIssue,
    "civil_id_no": civilIdNo,
    "residence_permit_no": residencePermitNo,
    "date_of_res_permit_issue": dateOfResPermitIssue,
    "date_of_res_permit_expiry": dateOfResPermitExpiry,
    "entered_country_date": enteredCountryDate,
  };
}
