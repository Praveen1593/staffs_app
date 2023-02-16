import 'dart:convert';

StudentsListModel studentsListModelFromJson(String str) =>
    StudentsListModel.fromJson(json.decode(str));

String studentsListModelToJson(StudentsListModel data) =>
    json.encode(data.toJson());

class StudentsListModel {
  StudentsListModel({
    this.studentsData,
    this.links,
    this.meta,
    required this.code,
    required this.status,
    this.msg,
  });

  List<StudentsData>? studentsData;
  Links? links;
  Meta? meta;
  int code;
  String status;
  String? msg;

  factory StudentsListModel.fromJson(Map<String, dynamic> json) =>
      StudentsListModel(
        studentsData: List<StudentsData>.from(
            json["data"].map((x) => StudentsData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        code: json["code"],
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(studentsData!.map((x) => x.toJson())),
        "links": links!.toJson(),
        "meta": meta!.toJson(),
        "code": code,
        "status": status,
        "msg": msg,
      };
}

class StudentsData {
  StudentsData(
      {this.id,
      this.uuid,
      this.code,
      this.studentId,
      this.firstName,
      this.gender,
      this.phoneNo,
      this.fatherName,
      this.motherName,
      this.doa,
      this.mobileNo,
      this.academic,
      this.photo,
      this.isExpanded = false});

  int? id;
  String? uuid;
  String? code;
  int? studentId;
  String? firstName;
  String? gender;
  dynamic phoneNo;
  String? fatherName;
  String? motherName;
  String? doa;
  dynamic mobileNo;
  Academic? academic;
  String? photo;
  bool isExpanded;

  factory StudentsData.fromJson(Map<String, dynamic> json) => StudentsData(
        id: json["id"],
        uuid: json["uuid"],
        code: json["code"],
        studentId: json["student_id"],
        firstName: json["first_name"],
        gender: json["gender"],
        phoneNo: json["phone_no"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        doa: json["doa"],
        mobileNo: json["mobile_no"],
        academic: Academic.fromJson(json["academic"]),
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "code": code,
        "student_id": studentId,
        "first_name": firstName,
        "gender": gender,
        "phone_no": phoneNo,
        "father_name": fatherName,
        "mother_name": motherName,
        "doa": doa,
        "mobile_no": mobileNo,
        "academic": academic!.toJson(),
      };
}

class Academic {
  Academic({
    this.id,
    this.uuid,
    this.academic,
    this.academicYear,
    this.standard,
    this.section,
    this.standardSection,
    this.categoryName,
  });

  int? id;
  String? uuid;
  int? academic;
  String? academicYear;
  String? standard;
  String? section;
  String? standardSection;
  dynamic categoryName;

  factory Academic.fromJson(Map<String?, dynamic> json) => Academic(
        id: json["id"],
        uuid: json["uuid"],
        academic: json["academic"],
        academicYear: json["academic_year"],
        standard: json["standard"],
        section: json["section"],
        standardSection: json["standard_section"],
        categoryName: json["category_name"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "academic": academic,
        "academic_year": academicYear,
        "standard": standard,
        "section": section,
        "standard_section": standardSection,
        "category_name": categoryName,
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
