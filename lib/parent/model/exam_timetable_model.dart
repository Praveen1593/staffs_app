import 'dart:convert';

ExamTimeTableModel examTimeTableModelFromJson(String str) =>
    ExamTimeTableModel.fromJson(json.decode(str));

String examTimeTableModelToJson(ExamTimeTableModel data) =>
    json.encode(data.toJson());

class ExamTimeTableModel {
  ExamTimeTableModel(
      {required this.status,
      required this.code,
      this.examTimeTableData,
      this.error});

  String status;
  int code;
  ExamTimeTableData? examTimeTableData;
  String? error;

  factory ExamTimeTableModel.fromJson(Map<String, dynamic> json) =>
      ExamTimeTableModel(
          status: json["status"],
          code: json["code"],
          examTimeTableData: json.containsKey("data")
              ? ExamTimeTableData.fromJson(json["data"])
              : ExamTimeTableData(),
          error: json.containsKey("error") ? json["error"] : "");

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": examTimeTableData!.toJson(),
      };
}

class ExamTimeTableData {
  ExamTimeTableData({
    this.id,
    this.standardName,
    this.examListName,
    this.timeTable,
  });

  dynamic id;
  String? standardName;
  String? examListName;
  String? timeTable;

  factory ExamTimeTableData.fromJson(Map<String, dynamic> json) =>
      ExamTimeTableData(
        id: json["id"],
        standardName: json["standard_name"],
        examListName: json["exam_list_name"],
        timeTable: json["time_table"] ??"",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "standard_name": standardName,
        "exam_list_name": examListName,
        "time_table": timeTable,
      };
}
