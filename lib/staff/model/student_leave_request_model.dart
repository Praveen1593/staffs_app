import 'dart:convert';

StudentLeaveRequestModel studentLeaveRequestModelFromJson(String str) =>
    StudentLeaveRequestModel.fromJson(json.decode(str));

String studentLeaveRequestModelToJson(StudentLeaveRequestModel data) =>
    json.encode(data.toJson());

class StudentLeaveRequestModel {
  StudentLeaveRequestModel({
    this.leaveRequestData,
    this.links,
    this.meta,
    required this.code,
    required this.status,
    this.msg,
  });

  List<StudentsLeaveRequestData>? leaveRequestData;
  Links? links;
  Meta? meta;
  int code;
  String status;
  String? msg;

  factory StudentLeaveRequestModel.fromJson(Map<String, dynamic> json) =>
      StudentLeaveRequestModel(
        leaveRequestData: List<StudentsLeaveRequestData>.from(json["data"].map((x) => StudentsLeaveRequestData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        code: json["code"],
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(leaveRequestData!.map((x) => x.toJson())),
        "links": links!.toJson(),
        "meta": meta!.toJson(),
        "code": code,
        "status": status,
        "msg": msg,
      };
}

class StudentsLeaveRequestData {
  StudentsLeaveRequestData({
    this.id,
    this.uuid,
    this.studentId,
    this.academicStudentId,
    this.firstName,
    this.phoneNo,
    this.fatherName,
    this.motherName,
    this.standardSection,
    this.applyDate,
    this.startDate,
    this.endDate,
    this.total,
    this.description,
    this.rejectRemark,
    this.halfDayLeave,
    this.status,
    this.statusName,
  });

  int? id;
  String? uuid;
  int? studentId;
  int? academicStudentId;
  String? firstName;
  dynamic phoneNo;
  String? fatherName;
  String? motherName;
  String? standardSection;
  String? applyDate;
  String? startDate;
  String? endDate;
  int? total;
  String? description;
  dynamic rejectRemark;
  int? halfDayLeave;
  int? status;
  String? statusName;

  factory StudentsLeaveRequestData.fromJson(Map<String, dynamic> json) => StudentsLeaveRequestData(
        id: json["id"],
        uuid: json["uuid"],
        studentId: json["student_id"],
        academicStudentId: json["academic_student_id"],
        firstName: json["first_name"],
        phoneNo: json["phone_no"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        standardSection: json["standard_section"],
        applyDate: json["apply_date"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        total: json["total"],
        description: json["description"],
        rejectRemark: json["reject_remark"],
        halfDayLeave: json["half_day_leave"],
        status: json["status"],
        statusName: json["status_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "student_id": studentId,
        "academic_student_id": academicStudentId,
        "first_name": firstName,
        "phone_no": phoneNo,
        "father_name": fatherName,
        "mother_name": motherName,
        "standard_section": standardSection,
        "apply_date": applyDate,
        "start_date": startDate,
        "end_date": endDate,
        "total": total,
        "description": description,
        "reject_remark": rejectRemark,
        "half_day_leave": halfDayLeave,
        "status": status,
        "status_name": statusName,
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
