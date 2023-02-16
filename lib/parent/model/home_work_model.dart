import 'dart:convert';

HomeWorkModel homeWorkModelFromJson(String str) =>
    HomeWorkModel.fromJson(json.decode(str));

String homeWorkModelToJson(HomeWorkModel data) => json.encode(data.toJson());

class HomeWorkModel {
  HomeWorkModel({
    this.homeworkData,
    this.links,
    this.meta,
    required this.code,
    required this.status,
    this.msg,
  });

  List<HomeWorkData>? homeworkData;
  Links? links;
  Meta? meta;
  int? code;
  String status;
  String? msg;

  factory HomeWorkModel.fromJson(Map<String, dynamic> json) => HomeWorkModel(
        homeworkData: json.containsKey("data")
            ? List<HomeWorkData>.from(
                json["data"].map((x) => HomeWorkData.fromJson(x)))
            : [],
        links:
            json.containsKey("links") ? Links.fromJson(json["links"]) : Links(),
        meta: json.containsKey("meta") ? Meta.fromJson(json["meta"]) : Meta(),
        code: json["code"],
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(homeworkData!.map((x) => x.toJson())),
        "links": links!.toJson(),
        "meta": meta!.toJson(),
        "code": code,
        "status": status,
        "msg": msg,
      };
}

class HomeWorkData {
  HomeWorkData({
    this.id,
    this.date,
    this.description,
    this.postedAt,
    this.subject,
  });

  int? id;
  String? date;
  String? description;
  String? postedAt;
  List<Subject>? subject;

  factory HomeWorkData.fromJson(Map<String, dynamic> json) => HomeWorkData(
        id: json["id"],
        date: json["date"],
        description: json["description"],
        postedAt: json["posted_at"],
        subject: json.containsKey("subject")
            ? List<Subject>.from(
                json["subject"].map((x) => Subject.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "description": description,
        "posted_at": postedAt,
        "subject": List<dynamic>.from(subject!.map((x) => x.toJson())),
      };
}

class Subject {
  Subject({
    this.id,
    this.date,
    this.subjectListId,
    this.subjectName,
    this.icon,
    this.title,
    this.description,
    this.postedBy,
    this.postedAt,
    this.homeworkReply,
    this.checkVisible = false,
    this.attachFile,
  });

  int? id;
  String? date;
  int? subjectListId;
  String? subjectName;
  String? icon;
  String? title;
  String? description;
  String? postedBy;
  String? postedAt;
  HomeworkReply? homeworkReply;
  bool? checkVisible;
  List<AttachFile>? attachFile;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        date: json["date"],
        subjectListId: json["subject_list_id"],
        subjectName: json["subject_name"],
        icon: json["icon"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"],
        postedBy: json["posted_by"] == null ? null : json["posted_by"],
        postedAt: json["posted_at"],
        homeworkReply: json["homework_reply"] == null
            ? null
            : HomeworkReply.fromJson(json["homework_reply"]),
        checkVisible: false,
        attachFile: json["attach_file"] == []
            ? []
            : List<AttachFile>.from(
                json["attach_file"].map((x) => AttachFile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "subject_list_id": subjectListId,
        "subject_name": subjectName,
        "icon": icon,
        "title": title == null ? null : title,
        "description": description,
        "posted_by": postedBy == null ? null : postedBy,
        "posted_at": postedAt,
        "homework_reply":
            homeworkReply == null ? null : homeworkReply!.toJson(),
      };
}

class AttachFile {
  AttachFile({
    this.attachFile,
    this.attachType,
    this.attachExtension,
    this.attachSize,
  });

  String? attachFile;
  String? attachType;
  String? attachExtension;
  String? attachSize;

  factory AttachFile.fromJson(Map<String, dynamic> json) => AttachFile(
        attachFile: json["attach_file"],
        attachType: json["attach_type"],
        attachExtension: json["attach_extension"],
        attachSize: json["attach_size"],
      );

  Map<String, dynamic> toJson() => {
        "attach_file": attachFile,
        "attach_type": attachType,
        "attach_extension": attachExtension,
        "attach_size": attachSize,
      };
}

class HomeworkReply {
  HomeworkReply({
    this.id,
    this.studentReply,
    this.staffReply,
  });

  int? id;
  StudentReply? studentReply;
  StaffReply? staffReply;

  factory HomeworkReply.fromJson(Map<String, dynamic> json) => HomeworkReply(
        id: json["id"],
        studentReply: json.containsKey("student_reply")
            ? StudentReply.fromJson(json["student_reply"])
            : StudentReply(),
        staffReply: json.containsKey("staff_reply")
            ? StaffReply.fromJson(json["staff_reply"])
            : StaffReply(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_reply": studentReply!.toJson(),
        "staff_reply": staffReply!.toJson(),
      };
}

class StaffReply {
  StaffReply({
    this.staffName,
    this.staffDate,
    this.staffDescription,
    this.staffRating,
  });

  dynamic staffName;
  dynamic staffDate;
  dynamic staffDescription;
  dynamic staffRating;

  factory StaffReply.fromJson(Map<String, dynamic> json) => StaffReply(
        staffName: json["staff_name"],
        staffDate: json["staff_date"],
        staffDescription: json["staff_description"],
        staffRating: json["staff_rating"],
      );

  Map<String, dynamic> toJson() => {
        "staff_name": staffName,
        "staff_date": staffDate,
        "staff_description": staffDescription,
        "staff_rating": staffRating,
      };
}

class StudentReply {
  StudentReply({
    this.date,
    this.stuDescription,
    this.stuHomeworkFile,
  });

  String? date;
  String? stuDescription;
  List<StuHomeworkFile>? stuHomeworkFile;

  factory StudentReply.fromJson(Map<String, dynamic> json) => StudentReply(
        date: json["date"],
        stuDescription: json["stu_description"],
        stuHomeworkFile: List<StuHomeworkFile>.from(
            json["stu_homework_file"].map((x) => StuHomeworkFile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "stu_description": stuDescription,
        "stu_homework_file": List<dynamic>.from(stuHomeworkFile!.map((x) => x)),
      };
}

class StuHomeworkFile {
  StuHomeworkFile({
    this.id,
    this.attachFile,
    this.staffCorrectedFile,
    this.staffRemark,
  });

  int? id;
  String? attachFile;
  String? staffCorrectedFile;
  dynamic staffRemark;

  factory StuHomeworkFile.fromJson(Map<String, dynamic> json) =>
      StuHomeworkFile(
        id: json["id"],
        attachFile: json["attach_file"],
        staffCorrectedFile: json["staff_corrected_file"],
        staffRemark: json["staff_remark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attach_file": attachFile,
        "staff_corrected_file": staffCorrectedFile,
        "staff_remark": staffRemark,
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
