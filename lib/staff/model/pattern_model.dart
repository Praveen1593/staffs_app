import 'package:flutter_projects/parent/model/fee_invoice_single_model.dart';

class PatternModel {
  PatternModel({
    required this.status,
    required this.code,
    this.patternData,
  });

  String status;
  int code;
  PatternData? patternData;

  factory PatternModel.fromJson(Map<String, dynamic> json) => PatternModel(
        status: json["status"],
        code: json["code"],
        patternData: PatternData.fromJson(json["data"]),
      );
}

class PatternData {
  PatternData({
    this.id,
    this.standardSubjectId,
    this.subjectListId,
    this.subject,
    this.examType,
    this.examMarkTypeId,
    this.practicalType,
    this.practicalMark,
    this.examMark,
    this.staffAssignType,
    this.subjectType,
    this.baseType,
    this.oldBaseType,
    this.languageType,
    this.rootExamType,
    this.rootStaffAssignType,
    this.examMarkType,
    this.children,
  });

  int? id;
  int? standardSubjectId;
  int? subjectListId;
  PatternDataSubject? subject;
  int? examType;
  int? examMarkTypeId;
  int? practicalType;
  int? practicalMark;
  int? examMark;
  int? staffAssignType;
  int? subjectType;
  int? baseType;
  int? oldBaseType;
  int? languageType;
  bool? rootExamType;
  bool? rootStaffAssignType;
  ExamMarkType? examMarkType;
  List<dynamic>? children;


  factory PatternData.fromJson(Map<String, dynamic> json) => PatternData(
        id: json["id"],
        standardSubjectId: json["standard_subject_id"],
        subjectListId: json["subject_list_id"],
        subject: PatternDataSubject.fromJson(json["subject"]),
        examType: json["exam_type"],
        examMarkTypeId: json["exam_mark_type_id"],
        practicalType: json["practical_type"],
        practicalMark: json["practical_mark"],
        examMark: json["exam_mark"],
        staffAssignType: json["staff_assign_type"],
        subjectType: json["subject_type"],
        baseType: json["base_type"],
        oldBaseType: json["old_base_type"],
        languageType: json["language_type"],
        rootExamType: json["root_exam_type"],
        rootStaffAssignType: json["root_staff_assign_type"],
        examMarkType: ExamMarkType.fromJson(json["exam_mark_type"]),
        children: json["children"] == []
            ? []
            : List<dynamic>.from(json["children"].map((x) => x)),
      );
}


class ExamMarkType {
  ExamMarkType({
    this.id,
    this.name,
    this.minMark,
    this.maxMark,
    this.passMark,
    this.rowsLevel,
    this.columnsLevel,
    this.displayRowsLevel,
    this.displayColumnsLevel,
    this.gradeDisplayType,
    this.gradeSystemId,
    this.gradeSystem,
    this.items,
  });

  int? id;
  String? name;
  int? minMark;
  int? maxMark;
  int? passMark;
  int? rowsLevel;
  int? columnsLevel;
  int? displayRowsLevel;
  int? displayColumnsLevel;
  int? gradeDisplayType;
  int? gradeSystemId;
  GradeSystem? gradeSystem;
  List<Item>? items;

  factory ExamMarkType.fromJson(Map<String, dynamic> json) => ExamMarkType(
        id: json["id"],
        name: json["name"],
        minMark: json["min_mark"],
        maxMark: json["max_mark"],
        passMark: json["pass_mark"],
        rowsLevel: json["rows_level"],
        columnsLevel: json["columns_level"],
        displayRowsLevel: json["display_rows_level"],
        displayColumnsLevel: json["display_columns_level"],
        gradeDisplayType: json["grade_display_type"],
        gradeSystemId: json["grade_system_id"],
        gradeSystem: json["grade_system"] == null
            ? null
            : GradeSystem.fromJson(json["grade_system"]),
        items: json["items"] == []
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

}

class GradeSystem {
  GradeSystem({
    this.id,
    this.name,
    this.type,
    this.passMark,
    this.items,
  });

  int? id;
  String? name;
  int? type;
  int? passMark;
  List<GradeSystemItem>? items;

  factory GradeSystem.fromJson(Map<String, dynamic> json) => GradeSystem(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        passMark: json["pass_mark"],
        items: List<GradeSystemItem>.from(
            json["items"].map((x) => GradeSystemItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "pass_mark": passMark,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class GradeSystemItem {
  GradeSystemItem({
    this.id,
    this.grade,
    this.gradeSystemId,
    this.name,
    this.absent,
    this.minMark,
    this.maxMark,
    this.remark,
  });

  int? id;
  String? grade;
  int? gradeSystemId;
  String? name;
  int? absent;
  int? minMark;
  int? maxMark;
  dynamic remark;

  factory GradeSystemItem.fromJson(Map<String, dynamic> json) =>
      GradeSystemItem(
        id: json["id"],
        grade: json["grade"],
        gradeSystemId: json["grade_system_id"],
        name: json["name"],
        absent: json["absent"],
        minMark: json["min_mark"],
        maxMark: json["max_mark"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade": grade,
        "grade_system_id": gradeSystemId,
        "name": name,
        "absent": absent,
        "min_mark": minMark,
        "max_mark": maxMark,
        "remark": remark,
      };
}

class Item {
  Item({
    this.id,
    this.examMarkTypeId,
    this.name,
    this.gradeSystemId,
    this.examMarkDivisionId,
    this.minMark,
    this.maxMark,
    this.rowsLevel,
    this.columnsLevel,
    this.displayRowsLevel,
    this.displayColumnsLevel,
    this.markEntryDisplayType,
    this.total,
    this.bestOfCount,
    this.gradeDisplayType,
    this.children,
    this.gradeSystem,
    this.examMarkTypeCalculate,
    this.customMark =0
  });

  int? id;
  int? examMarkTypeId;
  String? name;
  int? gradeSystemId;
  dynamic examMarkDivisionId;
  int? minMark;
  int? maxMark;
  int? rowsLevel;
  int? columnsLevel;
  int? displayRowsLevel;
  int? displayColumnsLevel;
  int? markEntryDisplayType;
  int? total;
  int? bestOfCount;
  int? gradeDisplayType;
  List<dynamic>? children;
  GradeSystem? gradeSystem;
  List<ExamMarkTypeCalculate>? examMarkTypeCalculate;
  int customMark;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        examMarkTypeId: json["exam_mark_type_id"],
        name: json["name"],
        gradeSystemId: json["grade_system_id"],
        examMarkDivisionId: json["exam_mark_division_id"],
        minMark: json["min_mark"],
        maxMark: json["max_mark"],
        rowsLevel: json["rows_level"],
        columnsLevel: json["columns_level"],
        displayRowsLevel: json["display_rows_level"],
        displayColumnsLevel: json["display_columns_level"],
        markEntryDisplayType: json["mark_entry_display_type"],
        total: json["total"],
        bestOfCount: json["best_of_count"],
        gradeDisplayType: json["grade_display_type"],
        children: (json.containsKey("children") && json["children"] != [])
            ? List<Item>.from(json["children"].map((x) => Item.fromJson(x)))
            : [],
        gradeSystem: json["grade_system"] == null
            ? null
            : GradeSystem.fromJson(json["grade_system"]),
        examMarkTypeCalculate: json["exam_mark_type_calculate"] == []
            ? []
            : List<ExamMarkTypeCalculate>.from(json["exam_mark_type_calculate"]
                .map((x) => ExamMarkTypeCalculate.fromJson(x))),
      );
}

class ExamMarkTypeCalculate {
  ExamMarkTypeCalculate({
    this.id,
    this.examMarkTypeItemId,
    this.addMarkTypeItemId,
  });

  int? id;
  int? examMarkTypeItemId;
  int? addMarkTypeItemId;

  factory ExamMarkTypeCalculate.fromJson(Map<String, dynamic> json) =>
      ExamMarkTypeCalculate(
        id: json["id"],
        examMarkTypeItemId: json["exam_mark_type_item_id"],
        addMarkTypeItemId: json["add_mark_type_item_id"],
      );
}

class PatternDataSubject {
  PatternDataSubject({
    this.id,
    this.code,
    this.commonName,
    this.shortName,
    this.languageId,
    this.name,
    this.fullName,
  });

  int? id;
  String? code;
  String? commonName;
  String? shortName;
  int? languageId;
  String? name;
  String? fullName;

  factory PatternDataSubject.fromJson(Map<String, dynamic> json) =>
      PatternDataSubject(
        id: json["id"],
        code: json["code"],
        commonName: json["common_name"],
        shortName: json["short_name"],
        languageId: json["language_id"],
        name: json["name"],
        fullName: json["full_name"],
      );
}
