import 'dart:convert';

StudentDetailsModel studentDetailsModelFromJson(String str) => StudentDetailsModel.fromJson(json.decode(str));

String studentDetailsModelToJson(StudentDetailsModel data) => json.encode(data.toJson());

class StudentDetailsModel {
  StudentDetailsModel({
    required this.status,
    required this.code,
    required this.studentData,
  });

  String status;
  int code;
  List<StudentData> studentData;

  factory StudentDetailsModel.fromJson(Map<String, dynamic> json) => StudentDetailsModel(
    status: json["status"],
    code: json["code"],
    studentData: List<StudentData>.from(json["data"].map((x) => StudentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(studentData.map((x) => x.toJson())),
  };
}

class StudentData {
  StudentData({
    this.academicStudentId,
    this.studentId,
    this.studentName,
    this.standardSection,
    this.code,
    this.gender,
    this.dob,
    this.doj,
    this.phone,
    this.emisNo,
    this.nationality,
    this.motherTongue,
    this.bloodGroup,
    this.mediumOfStudy,
    this.community,
    this.caste,
    this.subCaste,
    this.studentType,
    this.discountCategory,
    this.permanentAddress,
    this.residentialAddress,
    this.board,
    this.boardId,
    this.placeOfBirth,
    this.boardName,
    this.academic,
    this.academicId,
    this.busStatus,
    this.hostelStatus,
    this.extraActivityStatus,
    this.photo,
  });

  int? academicStudentId;
  int? studentId;
  String? studentName;
  String? standardSection;
  String? code;
  String? gender;
  String? dob;
  String? doj;
  String? phone;
  String? emisNo;
  String? nationality;
  String? motherTongue;
  String? bloodGroup;
  String? mediumOfStudy;
  String? community;
  String? caste;
  dynamic subCaste;
  String? studentType;
  String? discountCategory;
  Address? permanentAddress;
  Address? residentialAddress;
  String? board;
  int? boardId;
  dynamic placeOfBirth;
  int? boardName;
  String? academic;
  int? academicId;
  int? busStatus;
  int? hostelStatus;
  int? extraActivityStatus;
  String? photo;

  factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
    academicStudentId: json["academic_student_id"],
    studentId: json["student_id"],
    studentName: json["student_name"],
    standardSection: json["standard_section"],
    code: json["code"],
    gender: json["gender"],
    dob: json["dob"],
    doj: json["doj"],
    phone: json["phone"],
    emisNo: json["emis_no"] ?? "",
    nationality: json["nationality"],
    motherTongue: json["mother_tongue"],
    bloodGroup: json["blood_group"],
    mediumOfStudy: json["medium_of_study"],
    community: json["community"],
    caste: json["caste"],
    subCaste: json["sub_caste"],
    studentType: json["student_type"],
    discountCategory: json["discount_category"],
    permanentAddress: Address.fromJson(json["permanent_address"]),
    residentialAddress: Address.fromJson(json["residential_address"]),
    board: json["board"],
    boardId: json["board_id"],
    placeOfBirth: json["place_of_birth"],
    boardName: json["board_name"],
    academic: json["academic"],
    academicId: json["academic_id"],
    busStatus: json["bus_status"],
    hostelStatus: json["hostel_status"],
    extraActivityStatus: json["extra_activity_status"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "academic_student_id": academicStudentId,
    "student_id": studentId,
    "student_name": studentName,
    "standard_section": standardSection,
    "code": code,
    "gender": gender,
    "dob": dob,
    "doj": doj,
    "phone": phone,
    "emis_no": emisNo ?? "",
    "nationality": nationality,
    "mother_tongue": motherTongue,
    "blood_group": bloodGroup,
    "medium_of_study": mediumOfStudy,
    "community": community,
    "caste": caste,
    "sub_caste": subCaste,
    "student_type": studentType,
    "discount_category": discountCategory,
    "permanent_address": permanentAddress!.toJson(),
    "residential_address": residentialAddress!.toJson(),
    "board": board,
    "board_id": boardId,
    "place_of_birth": placeOfBirth,
    "board_name": boardName,
    "academic": academic,
    "academic_id": academicId,
    "bus_status": busStatus,
    "hostel_status": hostelStatus,
    "extra_activity_status": extraActivityStatus,
    "photo": photo,
  };
}

class Address {
  Address({
    this.address,
    this.city,
    this.stateId,
    this.countryId,
    this.pinCode,
  });

  String? address;
  dynamic city;
  String? stateId;
  String? countryId;
  dynamic pinCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    city: json["city"],
    stateId: json["state_id"],
    countryId: json["country_id"],
    pinCode: json["pin_code"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "city": city,
    "state_id": stateId,
    "country_id": countryId,
    "pin_code": pinCode,
  };
}
