// To parse this JSON data, do
//
//     final basicSettingsmodel = basicSettingsmodelFromJson(jsonString);

import 'dart:convert';

BasicSettingsmodel basicSettingsmodelFromJson(String str) => BasicSettingsmodel.fromJson(json.decode(str));

String basicSettingsmodelToJson(BasicSettingsmodel data) => json.encode(data.toJson());

class BasicSettingsmodel {
  BasicSettingsmodel({
    required this.status,
    required this.code,
    this.data,
  });

  String status;
  int code;
  SettingsData? data;

  factory BasicSettingsmodel.fromJson(Map<String, dynamic> json) => BasicSettingsmodel(
    status: json["status"],
    code: json["code"],
    data: SettingsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data!.toJson(),
  };
}

class SettingsData {
  SettingsData({
    this.staffHomeworkApprovalType,
    this.classTeacherHomeworkApprovalType,
    this.staffClassTestApprovalType,
    this.classClassTestApprovalType,
    this.payrollMenuType,
    this.classTeacherCount,
  });

  int? staffHomeworkApprovalType;
  int? classTeacherHomeworkApprovalType;
  int? staffClassTestApprovalType;
  int? classClassTestApprovalType;
  int? payrollMenuType;
  int? classTeacherCount;

  factory SettingsData.fromJson(Map<String, dynamic> json) => SettingsData(
    staffHomeworkApprovalType: json["staff_homework_approval_type"],
    classTeacherHomeworkApprovalType: json["class_teacher_homework_approval_type"],
    staffClassTestApprovalType: json["staff_class_test_approval_type"],
    classClassTestApprovalType: json["class_class_test_approval_type"],
    payrollMenuType: json["payroll_menu_type"],
    classTeacherCount: json["class_teacher_count"],
  );

  Map<String, dynamic> toJson() => {
    "staff_homework_approval_type": staffHomeworkApprovalType,
    "class_teacher_homework_approval_type": classTeacherHomeworkApprovalType,
    "staff_class_test_approval_type": staffClassTestApprovalType,
    "class_class_test_approval_type": classClassTestApprovalType,
    "payroll_menu_type": payrollMenuType,
    "class_teacher_count": classTeacherCount,
  };
}
