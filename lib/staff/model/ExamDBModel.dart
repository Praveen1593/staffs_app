// To parse this JSON data, do
//
//     final examDbModel = examDbModelFromJson(jsonString);

import 'dart:convert';

ExamDbModel examDbModelFromJson(String str) => ExamDbModel.fromJson(json.decode(str));

String examDbModelToJson(ExamDbModel data) => json.encode(data.toJson());

class ExamDbModel {
  ExamDbModel({
    required this.status,
    required this.code,
    required this.data,
  });

  String status;
  int code;
  List<Datum> data;

  factory ExamDbModel.fromJson(Map<String, dynamic> json) => ExamDbModel(
    status: json["status"],
    code: json["code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.studentId,
    required this.code,
    required this.fullName,
    required this.gender,
    required this.categoryName,
    this.firstLanguageId,
    this.secondLanguageId,
    this.thirdLanguageId,
    this.groupId,
    required this.academicId,
    required this.boardId,
    required this.examResult,
    required this.examOverallResult,
  });

  int id;
  int studentId;
  String code;
  String fullName;
  Gender gender;
  CategoryName categoryName;
  int? firstLanguageId;
  int? secondLanguageId;
  dynamic thirdLanguageId;
  dynamic groupId;
  int academicId;
  int boardId;
  List<ExamResult> examResult;
  ExamOverallResult examOverallResult;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    studentId: json["student_id"],
    code: json["code"],
    fullName: json["full_name"],
    gender: genderValues.map[json["gender"]]!,
    categoryName: categoryNameValues.map[json["category_name"]]!,
    firstLanguageId: json["first_language_id"],
    secondLanguageId: json["second_language_id"],
    thirdLanguageId: json["third_language_id"],
    groupId: json["group_id"],
    academicId: json["academic_id"],
    boardId: json["board_id"],
    examResult: List<ExamResult>.from(json["exam_result"].map((x) => ExamResult.fromJson(x))),
    examOverallResult: ExamOverallResult.fromJson(json["exam_overall_result"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_id": studentId,
    "code": code,
    "full_name": fullName,
    "gender": genderValues.reverse[gender],
    "category_name": categoryNameValues.reverse[categoryName],
    "first_language_id": firstLanguageId,
    "second_language_id": secondLanguageId,
    "third_language_id": thirdLanguageId,
    "group_id": groupId,
    "academic_id": academicId,
    "board_id": boardId,
    "exam_result": List<dynamic>.from(examResult.map((x) => x.toJson())),
    "exam_overall_result": examOverallResult.toJson(),
  };
}

enum CategoryName { GENERAL }

final categoryNameValues = EnumValues({
  "General": CategoryName.GENERAL
});

class ExamOverallResult {
  ExamOverallResult({
    required this.totalMark,
    required this.maxMark,
    required this.percentage,
    required this.grade,
    this.rank,
    required this.totalFails,
    required this.totalAbsent,
    required this.status,
  });

  int totalMark;
  int maxMark;
  int percentage;
  ExamOverallResultGrade grade;
  int? rank;
  int totalFails;
  int totalAbsent;
  int status;

  factory ExamOverallResult.fromJson(Map<String, dynamic> json) => ExamOverallResult(
    totalMark: json["total_mark"],
    maxMark: json["max_mark"],
    percentage: json["percentage"],
    grade: examOverallResultGradeValues.map[json["grade"]]!,
    rank: json["rank"],
    totalFails: json["total_fails"],
    totalAbsent: json["total_absent"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "total_mark": totalMark,
    "max_mark": maxMark,
    "percentage": percentage,
    "grade": examOverallResultGradeValues.reverse[grade],
    "rank": rank,
    "total_fails": totalFails,
    "total_absent": totalAbsent,
    "status": status,
  };
}

enum ExamOverallResultGrade { EMPTY }

final examOverallResultGradeValues = EnumValues({
  "-": ExamOverallResultGrade.EMPTY
});

class ExamResult {
  ExamResult({
    required this.id,
    required this.standardSubjectId,
    required this.standardSubjectItemId,
    required this.subjectListId,
    required this.examListId,
    this.gradeSystemId,
    this.gradeSystemItemId,
    required this.examAreaId,
    this.assessmentId,
    this.examMark,
    required this.practicalMark,
    this.totalMark,
    this.grade,
    required this.absent,
    required this.examResultTypeId,
    required this.examMarkTypeId,
    this.examMarkTypeItemId,
  });

  int id;
  int standardSubjectId;
  int standardSubjectItemId;
  int subjectListId;
  int examListId;
  int? gradeSystemId;
  int? gradeSystemItemId;
  int examAreaId;
  dynamic assessmentId;
  int? examMark;
  int practicalMark;
  int? totalMark;
  ExamResultGrade? grade;
  int absent;
  int examResultTypeId;
  int examMarkTypeId;
  int? examMarkTypeItemId;

  factory ExamResult.fromJson(Map<String, dynamic> json) => ExamResult(
    id: json["id"],
    standardSubjectId: json["standard_subject_id"],
    standardSubjectItemId: json["standard_subject_item_id"],
    subjectListId: json["subject_list_id"],
    examListId: json["exam_list_id"],
    gradeSystemId: json["grade_system_id"],
    gradeSystemItemId: json["grade_system_item_id"],
    examAreaId: json["exam_area_id"],
    assessmentId: json["assessment_id"],
    examMark: json["exam_mark"],
    practicalMark: json["practical_mark"],
    totalMark: json["total_mark"],
    grade: examResultGradeValues.map[json["grade"]]!,
    absent: json["absent"],
    examResultTypeId: json["exam_result_type_id"],
    examMarkTypeId: json["exam_mark_type_id"],
    examMarkTypeItemId: json["exam_mark_type_item_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "standard_subject_id": standardSubjectId,
    "standard_subject_item_id": standardSubjectItemId,
    "subject_list_id": subjectListId,
    "exam_list_id": examListId,
    "grade_system_id": gradeSystemId,
    "grade_system_item_id": gradeSystemItemId,
    "exam_area_id": examAreaId,
    "assessment_id": assessmentId,
    "exam_mark": examMark,
    "practical_mark": practicalMark,
    "total_mark": totalMark,
    "grade": examResultGradeValues.reverse[grade],
    "absent": absent,
    "exam_result_type_id": examResultTypeId,
    "exam_mark_type_id": examMarkTypeId,
    "exam_mark_type_item_id": examMarkTypeItemId,
  };
}

enum ExamResultGrade { C2, B2, D, C1, E }

final examResultGradeValues = EnumValues({
  "B2": ExamResultGrade.B2,
  "C1": ExamResultGrade.C1,
  "C2": ExamResultGrade.C2,
  "D": ExamResultGrade.D,
  "E": ExamResultGrade.E
});

enum Gender { MALE, FEMALE }

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.MALE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
