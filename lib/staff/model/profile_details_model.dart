// To parse this JSON data, do
//
//     final profileDetailsModel = profileDetailsModelFromJson(jsonString);

import 'dart:convert';

ProfileDetailsModel profileDetailsModelFromJson(String str) => ProfileDetailsModel.fromJson(json.decode(str));

String profileDetailsModelToJson(ProfileDetailsModel data) => json.encode(data.toJson());

class ProfileDetailsModel {
  ProfileDetailsModel({
    required this.status,
    required this.code,
    this.profileData,
  });

  String status;
  int code;
  ProfileData? profileData;

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) => ProfileDetailsModel(
    status: json["status"],
    code: json["code"],
    profileData: ProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": profileData!.toJson(),
  };
}

class ProfileData {
  ProfileData({
    this.code,
    this.firstName,
    this.lastName,
    this.userName,
    this.motherTongue,
    this.dob,
    this.doj,
    this.gender,
    this.email,
    this.phone,
    this.bloodGroup,
    this.religion,
    this.caste,
    this.subcaste,
    this.maritalStatus,
    this.maritalStatusId,
    this.jobType,
    this.nationality,
    this.salarytype,
    this.designation,
    this.qualification,
    this.experiences,
    this.whatsappNo,
    this.landLineNo,
    this.photo,
    this.permanentAddress,
    this.residentialAddress,
    this.passportDetail,
    this.busDetail,
    this.bankDetail,
  });

  String? code;
  String? firstName;
  String? lastName;
  String? userName;
  String? motherTongue;
  String? dob;
  String? doj;
  String? gender;
  dynamic email;
  String? phone;
  String? bloodGroup;
  String? religion;
  dynamic caste;
  dynamic subcaste;
  String? maritalStatus;
  int? maritalStatusId;
  String? jobType;
  String? nationality;
  dynamic salarytype;
  dynamic designation;
  dynamic qualification;
  dynamic experiences;
  dynamic whatsappNo;
  dynamic landLineNo;
  String? photo;
  Address? permanentAddress;
  Address? residentialAddress;
  List<dynamic>? passportDetail;
  List<dynamic>? busDetail;
  List<dynamic>? bankDetail;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    code: json["code"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userName: json["user_name"],
    motherTongue: json["mother_tongue"],
    dob: json["dob"],
    doj: json["doj"],
    gender: json["gender"],
    email: json["email"],
    phone: json["phone"],
    bloodGroup: json["blood_group"],
    religion: json["religion"],
    caste: json["caste"],
    subcaste: json["subcaste"],
    maritalStatus: json["marital_status"],
    maritalStatusId: json["marital_status_id"],
    jobType: json["job_type"],
    nationality: json["nationality"],
    salarytype: json["salarytype"],
    designation: json["designation"],
    qualification: json["qualification"],
    experiences: json["experiences"],
    whatsappNo: json["whatsapp_no"],
    landLineNo: json["land_line_no"],
    photo: json["photo"],
    permanentAddress: Address.fromJson(json["permanent_address"]),
    residentialAddress: Address.fromJson(json["residential_address"]),
    passportDetail: List<dynamic>.from(json["passport_detail"].map((x) => x)),
    busDetail: List<dynamic>.from(json["bus_detail"].map((x) => x)),
    bankDetail: List<dynamic>.from(json["bank_detail"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "first_name": firstName,
    "last_name": lastName,
    "user_name": userName,
    "mother_tongue": motherTongue,
    "dob": dob,
    "doj": doj,
    "gender": gender,
    "email": email,
    "phone": phone,
    "blood_group": bloodGroup,
    "religion": religion,
    "caste": caste,
    "subcaste": subcaste,
    "marital_status": maritalStatus,
    "marital_status_id": maritalStatusId,
    "job_type": jobType,
    "nationality": nationality,
    "salarytype": salarytype,
    "designation": designation,
    "qualification": qualification,
    "experiences": experiences,
    "whatsapp_no": whatsappNo,
    "land_line_no": landLineNo,
    "photo": photo,
    "permanent_address": permanentAddress!.toJson(),
    "residential_address": residentialAddress!.toJson(),
    "passport_detail": List<dynamic>.from(passportDetail!.map((x) => x)),
    "bus_detail": List<dynamic>.from(busDetail!.map((x) => x)),
    "bank_detail": List<dynamic>.from(bankDetail!.map((x) => x)),
  };
}

class Address {
  Address({
    this.address,
    this.city,
    this.country,
    this.state,
    this.countryId,
    this.stateId,
    this.pinCode,
  });

  String? address;
  dynamic city;
  String? country;
  String? state;
  int? countryId;
  int? stateId;
  dynamic pinCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    city: json["city"],
    country: json["country"],
    state: json["state"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    pinCode: json["pin_code"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "city": city,
    "country": country,
    "state": state,
    "country_id": countryId,
    "state_id": stateId,
    "pin_code": pinCode,
  };
}
