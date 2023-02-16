class OverAllExamResultModel {
  OverAllExamResultModel({
    required this.status,
    required this.code,
    this.overallExamResultData,
  });

  String status;
  int code;
  List<OverallExamResultData>? overallExamResultData;

  factory OverAllExamResultModel.fromJson(Map<String, dynamic> json) =>
      OverAllExamResultModel(
        status: json["status"],
        code: json["code"],
        overallExamResultData: List<OverallExamResultData>.from(
            json["data"].map((x) => OverallExamResultData.fromJson(x))),
      );
}

class OverallExamResultData {
  OverallExamResultData({
    this.id,
    this.studentId,
    this.code,
    this.fullName,
    this.gender,
    this.categoryName,
    this.firstLanguageId,
    this.secondLanguageId,
    this.thirdLanguageId,
    this.groupId,
    this.academicId,
    this.boardId,
    this.examResult,
    this.examOverallResult,
    this.totalMarkValue = "",
    this.absentValue = 0
  });

  int? id;
  int? studentId;
  String? code;
  String? fullName;
  String? gender;
  String? categoryName;
  dynamic firstLanguageId;
  dynamic secondLanguageId;
  dynamic thirdLanguageId;
  dynamic groupId;
  int? academicId;
  int? boardId;
  List<ExamResult>? examResult;
  ExamOverallResult? examOverallResult;
  dynamic totalMarkValue;
  int absentValue;

  factory OverallExamResultData.fromJson(Map<String, dynamic> json) =>
      OverallExamResultData(
        id: json["id"],
        studentId: json["student_id"],
        code: json["code"],
        fullName: json["full_name"],
        gender: json["gender"],
        categoryName: json["category_name"],
        firstLanguageId: json["first_language_id"],
        secondLanguageId: json["second_language_id"],
        thirdLanguageId: json["third_language_id"],
        groupId: json["group_id"],
        academicId: json["academic_id"],
        boardId: json["board_id"],
        examResult: json["exam_result"] == []
            ? []
            : List<ExamResult>.from(
                json["exam_result"].map((x) => ExamResult.fromJson(x))),
        examOverallResult:
            ExamOverallResult.fromJson(json["exam_overall_result"]),
      );
}

class ExamOverallResult {
  ExamOverallResult({
    this.totalMark,
    this.maxMark,
    this.percentage,
    this.grade,
    this.rank,
    this.totalFails,
    this.totalAbsent,
    this.status,
  });

  dynamic totalMark;
  int? maxMark;
  dynamic percentage;
  dynamic grade;
  dynamic rank;
  dynamic totalFails;
  dynamic totalAbsent;
  int? status;

  factory ExamOverallResult.fromJson(Map<String, dynamic> json) =>
      ExamOverallResult(
        totalMark: json["total_mark"],
        maxMark: json["max_mark"],
        percentage: json["percentage"],
        grade: json["grade"],
        rank: json["rank"],
        totalFails: json["total_fails"],
        totalAbsent: json["total_absent"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "total_mark": totalMark,
        "max_mark": maxMark,
        "percentage": percentage,
        "grade": grade,
        "rank": rank,
        "total_fails": totalFails,
        "total_absent": totalAbsent,
        "status": status,
      };
}

class ExamResult {
  ExamResult({
    this.id,
    this.standardSubjectId,
    this.standardSubjectItemId,
    this.subjectListId,
    this.examListId,
    this.gradeSystemId,
    this.gradeSystemItemId,
    this.examAreaId,
    this.assessmentId,
    this.examMark,
    this.practicalMark,
    this.totalMark,
    this.grade,
    this.absent,
    this.examResultTypeId,
    this.examMarkTypeId,
    this.examMarkTypeIteId,
    this.isCheck = false
  });

  int? id;
  int? standardSubjectId;
  int? standardSubjectItemId;
  int? subjectListId;
  int? examListId;
  dynamic gradeSystemId;
  dynamic gradeSystemItemId;
  int? examAreaId;
  int? assessmentId;
  int? examMark;
  int? practicalMark;
  int? totalMark;
  dynamic grade;
  int? absent;
  int? examResultTypeId;
  int? examMarkTypeId;
  dynamic examMarkTypeIteId;
  bool? isCheck;

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
        examMark: json["exam_mark"]??0,
        practicalMark: json["practical_mark"],
        totalMark: json["total_mark"],
        grade: json["grade"],
        absent: json["absent"],
        examResultTypeId: json["exam_result_type_id"],
        examMarkTypeId: json["exam_mark_type_id"],
        examMarkTypeIteId: json["exam_mark_type_item_id"],
      );
}

