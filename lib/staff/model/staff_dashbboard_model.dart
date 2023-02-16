import 'dart:convert';

StaffDashboardModel staffDashboardModelFromJson(String str) => StaffDashboardModel.fromJson(json.decode(str));

String staffDashboardModelToJson(StaffDashboardModel data) => json.encode(data.toJson());

class StaffDashboardModel {
  StaffDashboardModel({
    required this.status,
    required this.code,
    this.sDashboarddata,
  });

  String status;
  int code;
  StaffDashboardData? sDashboarddata;

  factory StaffDashboardModel.fromJson(Map<String, dynamic> json) => StaffDashboardModel(
    status: json["status"],
    code: json["code"],
    sDashboarddata: StaffDashboardData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": sDashboarddata!.toJson(),
  };
}

class StaffDashboardData {
  StaffDashboardData({
    this.rateDealData,
    this.lastMonthSalary,
  });

  RateDealData? rateDealData;
  LastMonthSalary? lastMonthSalary;

  factory StaffDashboardData.fromJson(Map<String, dynamic> json) => StaffDashboardData(
    rateDealData: RateDealData.fromJson(json["rate_deal_data"]),
    lastMonthSalary: LastMonthSalary.fromJson(json["last_month_salary"]),
  );

  Map<String, dynamic> toJson() => {
    "rate_deal_data": rateDealData!.toJson(),
    "last_month_salary": lastMonthSalary!.toJson(),
  };
}

class LastMonthSalary {
  LastMonthSalary({
    this.allowance,
    this.allowanceName,
    this.deduction,
    this.deductionName,
    this.salary,
    this.lop,
    this.percentage,
  });

  String? allowance;
  String? allowanceName;
  String? deduction;
  String? deductionName;
  String? salary;
  int? lop;
  double? percentage;

  factory LastMonthSalary.fromJson(Map<String, dynamic> json) => LastMonthSalary(
    allowance: json["allowance"],
    allowanceName: json["allowance_name"],
    deduction: json["deduction"],
    deductionName: json["deduction_name"],
    salary: json["salary"],
    lop: json["lop"],
    percentage: json["percentage"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "allowance": allowance,
    "allowance_name": allowanceName,
    "deduction": deduction,
    "deduction_name": deductionName,
    "salary": salary,
    "lop": lop,
    "percentage": percentage,
  };
}

class RateDealData {
  RateDealData({
    this.totalStudent,
    this.subjectCount,
    this.homeworkCount,
    this.classTestCount,
    this.standardList,
    this.classTeacherCount,
  });

  int? totalStudent;
  int? subjectCount;
  int? homeworkCount;
  int? classTestCount;
  List<StandardList>? standardList;
  int? classTeacherCount;

  factory RateDealData.fromJson(Map<String, dynamic> json) => RateDealData(
    totalStudent: json["total_student"],
    subjectCount: json["subject_count"],
    homeworkCount: json["homework_count"],
    classTestCount: json["class_test_count"],
    standardList: List<StandardList>.from(json["standard_list"].map((x) => StandardList.fromJson(x))),
    classTeacherCount: json["class_teacher_count"],
  );

  Map<String, dynamic> toJson() => {
    "total_student": totalStudent,
    "subject_count": subjectCount,
    "homework_count": homeworkCount,
    "class_test_count": classTestCount,
    "standard_list": List<dynamic>.from(standardList!.map((x) => x.toJson())),
    "class_teacher_count": classTeacherCount,
  };
}

class StandardList {
  StandardList({
    this.standardName,
    this.studentCount,
  });

  String? standardName;
  int? studentCount;

  factory StandardList.fromJson(Map<String, dynamic> json) => StandardList(
    standardName: json["standard_name"],
    studentCount: json["student_count"],
  );

  Map<String, dynamic> toJson() => {
    "standard_name": standardName,
    "student_count": studentCount,
  };
}
