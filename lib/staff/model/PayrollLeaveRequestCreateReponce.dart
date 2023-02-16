// To parse this JSON data, do
//
//     final payrollLeaveRequestCreateReponce = payrollLeaveRequestCreateReponceFromJson(jsonString);

import 'dart:convert';

PayrollLeaveRequestCreateReponce payrollLeaveRequestCreateReponceFromJson(String str) => PayrollLeaveRequestCreateReponce.fromJson(json.decode(str));

String payrollLeaveRequestCreateReponceToJson(PayrollLeaveRequestCreateReponce data) => json.encode(data.toJson());

class PayrollLeaveRequestCreateReponce {
  PayrollLeaveRequestCreateReponce({
    required this.status,
    required this.code,
    this.leaveRequestCreateData,
  });

  String status;
  int code;
  LeaveRequestCreateData? leaveRequestCreateData;

  factory PayrollLeaveRequestCreateReponce.fromJson(Map<String, dynamic> json) => PayrollLeaveRequestCreateReponce(
    status: json["status"],
    code: json["code"],
    leaveRequestCreateData: LeaveRequestCreateData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": leaveRequestCreateData!.toJson(),
  };
}

class LeaveRequestCreateData {
  LeaveRequestCreateData({
    this.id,
    this.leaveTypeId,
    this.leaveType,
    this.applyDate,
    this.startDate,
    this.endDate,
    this.total,
    this.description,
    this.halfDayLeave,
    this.status,
    this.statusName,
  });

  int? id;
  String? leaveTypeId;
  LeaveType? leaveType;
  String? applyDate;
  String? startDate;
  String? endDate;
  int? total;
  String? description;
  int? halfDayLeave;
  int? status;
  String? statusName;

  factory LeaveRequestCreateData.fromJson(Map<String, dynamic> json) => LeaveRequestCreateData(
    id: json["id"],
    leaveTypeId: json["leave_type_id"],
    leaveType: LeaveType.fromJson(json["leave_type"]),
    applyDate: json["apply_date"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    total: json["total"],
    description: json["description"],
    halfDayLeave: json["half_day_leave"],
    status: json["status"],
    statusName: json["status_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "leave_type_id": leaveTypeId,
    "leave_type": leaveType!.toJson(),
    "apply_date": applyDate,
    "start_date": startDate,
    "end_date": endDate,
    "total": total,
    "description": description,
    "half_day_leave": halfDayLeave,
    "status": status,
    "status_name": statusName,
  };
}

class LeaveType {
  LeaveType({
    this.id,
    this.uuid,
    this.commonName,
    this.createdBy,
    this.type,
    this.status,
    this.priority,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  int? id;
  String? uuid;
  String? commonName;
  int? createdBy;
  int? type;
  int? status;
  dynamic priority;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
    id: json["id"],
    uuid: json["uuid"],
    commonName: json["common_name"],
    createdBy: json["created_by"],
    type: json["type"],
    status: json["status"],
    priority: json["priority"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "common_name": commonName,
    "created_by": createdBy,
    "type": type,
    "status": status,
    "priority": priority,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "name": name,
  };
}
