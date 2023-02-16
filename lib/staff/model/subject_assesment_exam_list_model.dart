import 'dart:convert';

SubjectAssesementExamListModel subjectAssesementExamListModelFromJson(
        String str) =>
    SubjectAssesementExamListModel.fromJson(json.decode(str));

String subjectAssesementExamListModelToJson(
        SubjectAssesementExamListModel data) =>
    json.encode(data.toJson());

class SubjectAssesementExamListModel {
  SubjectAssesementExamListModel({
    required this.status,
    required this.code,
    this.subjectExamListData,
  });

  String status;
  int code;
  SubjectExamListData? subjectExamListData;

  factory SubjectAssesementExamListModel.fromJson(Map<String, dynamic> json) =>
      SubjectAssesementExamListModel(
        status: json["status"],
        code: json["code"],
        subjectExamListData: SubjectExamListData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": subjectExamListData!.toJson(),
      };
}

class SubjectExamListData {
  SubjectExamListData({
    this.id,
    this.standardId,
    this.groupSectionId,
    this.type,
    this.standardExamId,
    this.examArea,
    this.examList,
    this.subjectList,
  });

  int? id;
  int? standardId;
  dynamic groupSectionId;
  int? type;
  int? standardExamId;
  List<ExamArea>? examArea;
  List<ExamList>? examList;
  List<SubjectList>? subjectList;

  factory SubjectExamListData.fromJson(Map<String, dynamic> json) =>
      SubjectExamListData(
        id: json["id"],
        standardId: json["standard_id"],
        groupSectionId: json["group_section_id"],
        type: json["type"],
        standardExamId: json["standard_exam_id"],
        examArea: json["exam_area"] != null
            ? List<ExamArea>.from(
                json["exam_area"].map((x) => ExamArea.fromJson(x)))
            : [],
        examList: json["exam_list"] != null
            ? List<ExamList>.from(
                json["exam_list"].map((x) => ExamList.fromJson(x)))
            : [],
        subjectList: json["subject_list"] != null
            ? List<SubjectList>.from(
                json["subject_list"].map((x) => SubjectList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "standard_id": standardId,
        "group_section_id": groupSectionId,
        "type": type,
        "standard_exam_id": standardExamId,
        "exam_area": List<dynamic>.from(examArea!.map((x) => x.toJson())),
        "exam_list": List<dynamic>.from(examList!.map((x) => x.toJson())),
        "subject_list": List<dynamic>.from(subjectList!.map((x) => x.toJson())),
      };
}

class ExamArea {
  ExamArea({
    this.id,
    this.name,
    this.type,
    this.assessment,
    this.stdExam,
  });

  int? id;
  String? name;
  int? type;
  List<Assessment>? assessment;
  List<StdExam>? stdExam;

  factory ExamArea.fromJson(Map<String, dynamic> json) => ExamArea(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        assessment: List<Assessment>.from(
            json["assessment"].map((x) => Assessment.fromJson(x))),
        stdExam: List<StdExam>.from(
            json["std_exam"].map((x) => StdExam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "assessment": List<dynamic>.from(assessment!.map((x) => x.toJson())),
        "std_exam": List<dynamic>.from(stdExam!.map((x) => x.toJson())),
      };
}

class Assessment {
  Assessment({
    this.id,
    this.name,
    this.subLevel,
    this.type,
    this.subItem,
  });

  int? id;
  String? name;
  int? subLevel;
  int? type;
  List<dynamic>? subItem;

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        id: json["id"],
        name: json["name"],
        subLevel: json["sub_level"],
        type: json["type"],
        subItem: List<dynamic>.from(json["sub_item"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sub_level": subLevel,
        "type": type,
        "sub_item": List<dynamic>.from(subItem!.map((x) => x)),
      };
}

class StdExam {
  StdExam({
    this.id,
    this.examAreaId,
    this.standardSubjectId,
    this.standardExamItemId,
    this.gradeSystemId,
  });

  int? id;
  int? examAreaId;
  int? standardSubjectId;
  int? standardExamItemId;
  int? gradeSystemId;

  factory StdExam.fromJson(Map<String, dynamic> json) => StdExam(
        id: json["id"],
        examAreaId: json["exam_area_id"],
        standardSubjectId: json["standard_subject_id"],
        standardExamItemId: json["standard_exam_item_id"],
        gradeSystemId:
            json["grade_system_id"] == null ? null : json["grade_system_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "exam_area_id": examAreaId,
        "standard_subject_id": standardSubjectId,
        "standard_exam_item_id": standardExamItemId,
        "grade_system_id": gradeSystemId == null ? null : gradeSystemId,
      };
}

class ExamList {
  ExamList({
    this.id,
    this.standardExamListId,
    this.examMarkTypeId,
    this.examListId,
    this.code,
    this.name,
    this.progressCardType,
    this.examConclusionList,
    this.startDate,
    this.endDate,
  });

  int? id;
  int? standardExamListId;
  int? examMarkTypeId;
  int? examListId;
  String? code;
  String? name;
  int? progressCardType;
  List<ExamConclusionList>? examConclusionList;
  DateTime? startDate;
  DateTime? endDate;

  factory ExamList.fromJson(Map<String, dynamic> json) => ExamList(
        id: json["id"],
        standardExamListId: json["standard_exam_list_id"],
        examMarkTypeId: json["exam_mark_type_id"],
        examListId: json["exam_list_id"],
        code: json["code"],
        name: json["name"],
        progressCardType: json["progress_card_type"],
        examConclusionList: List<ExamConclusionList>.from(
            json["exam_conclusion_list"]
                .map((x) => ExamConclusionList.fromJson(x))),
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "standard_exam_list_id": standardExamListId,
        "exam_mark_type_id": examMarkTypeId,
        "exam_list_id": examListId,
        "code": code,
        "name": name,
        "progress_card_type": progressCardType,
        "exam_conclusion_list":
            List<dynamic>.from(examConclusionList!.map((x) => x.toJson())),
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
      };
}

class ExamConclusionList {
  ExamConclusionList({
    this.id,
    this.name,
    this.shortName,
    this.priority,
  });

  int? id;
  String? name;
  String? shortName;
  int? priority;

  factory ExamConclusionList.fromJson(Map<String, dynamic> json) =>
      ExamConclusionList(
        id: json["id"],
        name: json["name"],
        shortName: json["short_name"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "short_name": shortName,
        "priority": priority,
      };
}

class SubjectList {
  SubjectList({
    this.id,
    this.standardSubjectId,
    this.subjectListId,
    this.subject,
    this.group,
    this.subSubject,
    this.examType,
    this.examMarkTypeId,
    this.practicalType,
    this.practicalMark,
    this.examMark,
    this.staffAssignType,
    this.subjectType,
    this.baseType,
    this.languageType,
    this.specificStdSubjectExamMarkType,
  });

  int? id;
  int? standardSubjectId;
  int? subjectListId;
  Subject? subject;
  List<dynamic>? group;
  List<dynamic>? subSubject;
  int? examType;
  int? examMarkTypeId;
  int? practicalType;
  int? practicalMark;
  int? examMark;
  int? staffAssignType;
  int? subjectType;
  int? baseType;
  int? languageType;
  List<dynamic>? specificStdSubjectExamMarkType;

  factory SubjectList.fromJson(Map<String, dynamic> json) => SubjectList(
        id: json["id"],
        standardSubjectId: json["standard_subject_id"],
        subjectListId: json["subject_list_id"],
        subject: Subject.fromJson(json["subject"]),
        group: List<dynamic>.from(json["group"].map((x) => x)),
        subSubject: List<dynamic>.from(json["sub_subject"].map((x) => x)),
        examType: json["exam_type"],
        examMarkTypeId: json["exam_mark_type_id"],
        practicalType: json["practical_type"],
        practicalMark: json["practical_mark"],
        examMark: json["exam_mark"],
        staffAssignType: json["staff_assign_type"],
        subjectType: json["subject_type"],
        baseType: json["base_type"],
        languageType: json["language_type"],
        specificStdSubjectExamMarkType: List<dynamic>.from(
            json["specific_std_subject_exam_mark_type"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "standard_subject_id": standardSubjectId,
        "subject_list_id": subjectListId,
        "subject": subject!.toJson(),
        "group": List<dynamic>.from(group!.map((x) => x)),
        "sub_subject": List<dynamic>.from(subSubject!.map((x) => x)),
        "exam_type": examType,
        "exam_mark_type_id": examMarkTypeId,
        "practical_type": practicalType,
        "practical_mark": practicalMark,
        "exam_mark": examMark,
        "staff_assign_type": staffAssignType,
        "subject_type": subjectType,
        "base_type": baseType,
        "language_type": languageType,
        "specific_std_subject_exam_mark_type":
            List<dynamic>.from(specificStdSubjectExamMarkType!.map((x) => x)),
      };
}

class Subject {
  Subject({
    this.id,
    this.code,
    this.name,
    this.fullName,
    this.languageType,
    this.subTree,
  });

  int? id;
  String? code;
  String? name;
  String? fullName;
  int? languageType;
  int? subTree;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        fullName: json["full_name"],
        languageType: json["language_type"],
        subTree: json["sub_tree"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "full_name": fullName,
        "language_type": languageType,
        "sub_tree": subTree,
      };
}
