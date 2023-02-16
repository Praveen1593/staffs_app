import 'dart:convert';

ProfileResponceModel ProfileResponceModelFromJson(String str) =>
    ProfileResponceModel.fromJson(json.decode(str));

String ProfileResponceModelToJson(ProfileResponceModel data) => json.encode(data.toJson());

class ProfileResponceModel {
  ProfileResponceModel({
    required this.status,
    required this.code,
    this.profileData,
  });

  String status;
  int code;
  ProfileData? profileData;

  factory ProfileResponceModel.fromJson(Map<String, dynamic> json) {
    print("json data $json");

    return ProfileResponceModel(
      status: json["status"],
      code: json["code"],
      profileData: json.containsKey("data")
          ? ProfileData.fromJson(json["data"])
          : ProfileData(),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": profileData!.toJson(),
      };
}

class ProfileData {
  ProfileData({
    this.userName,
    this.code,
    this.email,
    this.phone,
    this.photo,
    this.city,
    this.pincode,
    this.address,
    this.fatherDetail,
    this.motherDetail,
    this.passportDetail,
  });

  String? userName;
  String? code;
  dynamic email;
  String? phone;
  String? photo;
  dynamic city;
  dynamic pincode;
  String? address;
  MotherDetails? fatherDetail;
  MotherDetails? motherDetail;
  PassportDetail? passportDetail;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        userName: json["user_name"],
        code: json["code"],
        email: json["email"] ?? "",
        phone: json["phone"],
        photo: json["photo"],
        city: json["city"],
        pincode: json["pincode"] ?? "",
        address: json["address"],
        fatherDetail: json.containsKey("father_detail")
            ? MotherDetails.fromJson(json["father_detail"])
            : MotherDetails(),
        motherDetail: json.containsKey("mother_detail")
            ? MotherDetails.fromJson(json["mother_detail"])
            : MotherDetails(),
        passportDetail: json.containsKey("passport_detail")
            ? PassportDetail.fromJson(json["passport_detail"])
            : PassportDetail(),
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
        "passport_detail": passportDetail!.toJson(),
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
    this.enteredCountryDate,
  });

  dynamic passportNo;
  String? dateOfIssue;
  String? dateOfExpiry;
  dynamic placeOfIssue;
  dynamic civilIdNo;
  dynamic residencePermitNo;
  dynamic dateOfResPermitIssue;
  dynamic enteredCountryDate;

  factory PassportDetail.fromJson(Map<String, dynamic> json) => PassportDetail(
        passportNo: json["passport_no"] ?? "",
        dateOfIssue: json["date_of_issue"],
        dateOfExpiry: json["date_of_expiry"],
        placeOfIssue: json["place_of_issue"] ?? "",
        civilIdNo: json["civil_id_no"] ?? "",
        residencePermitNo: json["residence_permit_no"] ?? "",
        dateOfResPermitIssue: json["date_of_res_permit_issue"],
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
        "entered_country_date": enteredCountryDate,
      };
}


class MotherDetails {
  MotherDetails({
    this.profession,
    this.name,
    this.email,
    this.officeAddress,
    this.telephoneNo,
    this.phoneNo,
    this.whatsAppNo,
    this.religionId,
    this.religionName,
    this.professionId,
    this.faIncomePerMonth,
    this.professionName,
    this.photo,
  });

  dynamic profession;
  String? name;
  String? email;
  dynamic officeAddress;
  dynamic telephoneNo;
  dynamic phoneNo;
  String? whatsAppNo;
  dynamic religionId;
  String? religionName;
  dynamic professionId;
  String? faIncomePerMonth;
  String? professionName;
  String? photo;

  factory MotherDetails.fromJson(Map<String, dynamic> json) => MotherDetails(
    profession: json["profession"] ?? "",
    name: json["name"],
    email: json["email"],
    officeAddress: json["office_address"] ?? "",
    telephoneNo: json["telephone_no"] ?? "",
    phoneNo: json["phone_no"] ?? "",
    whatsAppNo: json["whats_app_no"],
    religionId: json["religion_id"],
    religionName: json["religion_name"],
    professionId: json["profession_id"],
    faIncomePerMonth: json["fa_income_per_month"],
    professionName: json["profession_name"],
    photo: json["photo"],
      );
}
