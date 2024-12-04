class getLeaveListModel {
  int? statusCode;
  String? message;
  List<LeaveData>? data;

  getLeaveListModel({this.statusCode, this.message, this.data});

  getLeaveListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LeaveData>[];
      json['data'].forEach((v) {
        data!.add(new LeaveData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveData {
  String? sId;
  String? courseName;
  String? courseId;
  String? leaveType;
  String? fromDate;
  String? endDate;
  String? reason;
  String? userId;
  String? tutorId;
  String? status;
  int? isActive;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  BatchDetails? batchDetails;

  LeaveData(
      {this.sId,
      this.courseName,
      this.courseId,
      this.leaveType,
      this.fromDate,
      this.endDate,
      this.reason,
      this.userId,
      this.tutorId,
      this.status,
      this.isActive,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.batchDetails});

  LeaveData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseName = json['course_name'];
    courseId = json['courseId'];
    leaveType = json['leave_type'];
    fromDate = json['from_date'];
    endDate = json['end_date'];
    reason = json['reason'];
    userId = json['userId'];
    tutorId = json['tutorId'];
    status = json['status'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    batchDetails = json['batchDetails'] != null
        ? new BatchDetails.fromJson(json['batchDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['course_name'] = this.courseName;
    data['courseId'] = this.courseId;
    data['leave_type'] = this.leaveType;
    data['from_date'] = this.fromDate;
    data['end_date'] = this.endDate;
    data['reason'] = this.reason;
    data['userId'] = this.userId;
    data['tutorId'] = this.tutorId;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.batchDetails != null) {
      data['batchDetails'] = this.batchDetails!.toJson();
    }
    return data;
  }
}

class BatchDetails {
  String? sId;
  String? batchName;
  String? batchTeacher;
  String? batchMaximumSlots;
  String? batchTimingStart;
  String? batchTimingEnd;
  int? batchTimingStartMinutes;
  int? batchTimingEndMinutes;
  String? batchDays;
  String? batchMode;
  String? fees;
  String? month;
  String? userId;
  String? batchCode;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BatchDetails(
      {this.sId,
      this.batchName,
      this.batchTeacher,
      this.batchMaximumSlots,
      this.batchTimingStart,
      this.batchTimingEnd,
      this.batchTimingStartMinutes,
      this.batchTimingEndMinutes,
      this.batchDays,
      this.batchMode,
      this.fees,
      this.month,
      this.userId,
      this.batchCode,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BatchDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    batchTeacher = json['batch_teacher'];
    batchMaximumSlots = json['batch_maximum_slots'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
    batchTimingStartMinutes = json['batch_timing_start_minutes'];
    batchTimingEndMinutes = json['batch_timing_end_minutes'];
    batchDays = json['batch_days'];
    batchMode = json['batch_mode'];
    fees = json['fees'];
    month = json['month'];
    userId = json['userId'];
    batchCode = json['batch_code'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['batch_name'] = this.batchName;
    data['batch_teacher'] = this.batchTeacher;
    data['batch_maximum_slots'] = this.batchMaximumSlots;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    data['batch_timing_start_minutes'] = this.batchTimingStartMinutes;
    data['batch_timing_end_minutes'] = this.batchTimingEndMinutes;
    data['batch_days'] = this.batchDays;
    data['batch_mode'] = this.batchMode;
    data['fees'] = this.fees;
    data['month'] = this.month;
    data['userId'] = this.userId;
    data['batch_code'] = this.batchCode;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}