class getGroupedEnrollmentByAttendanceTutee {
  int? statusCode;
  TuteeData? data;

  getGroupedEnrollmentByAttendanceTutee({this.statusCode, this.data});

  getGroupedEnrollmentByAttendanceTutee.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new TuteeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TuteeData {
  String? batchId;
  String? date;
  String? fromDate;
  String? toDate;
  String? month;
  StatusCounts? statusCounts;
  List<AttendanceDetails>? attendanceDetails;

  TuteeData(
      {this.batchId,
      this.date,
      this.fromDate,
      this.toDate,
      this.month,
      this.statusCounts,
      this.attendanceDetails});

  TuteeData.fromJson(Map<String, dynamic> json) {
    batchId = json['batchId'];
    date = json['date'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    month = json['month'];
    statusCounts = json['statusCounts'] != null
        ? new StatusCounts.fromJson(json['statusCounts'])
        : null;
    if (json['attendanceDetails'] != null) {
      attendanceDetails = <AttendanceDetails>[];
      json['attendanceDetails'].forEach((v) {
        attendanceDetails!.add(new AttendanceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batchId'] = this.batchId;
    data['date'] = this.date;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['month'] = this.month;
    if (this.statusCounts != null) {
      data['statusCounts'] = this.statusCounts!.toJson();
    }
    if (this.attendanceDetails != null) {
      data['attendanceDetails'] =
          this.attendanceDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusCounts {
  int? present;
  int? absent;
  int? leave;
  int? partialAttendance;
  int? totalStudents;

  StatusCounts(
      {this.present,
      this.absent,
      this.leave,
      this.partialAttendance,
      this.totalStudents});

  StatusCounts.fromJson(Map<String, dynamic> json) {
    present = json['Present'];
    absent = json['Absent'];
    leave = json['Leave'];
    partialAttendance = json['Partial Attendance'];
    totalStudents = json['totalStudents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Present'] = this.present;
    data['Absent'] = this.absent;
    data['Leave'] = this.leave;
    data['Partial Attendance'] = this.partialAttendance;
    data['totalStudents'] = this.totalStudents;
    return data;
  }
}

class AttendanceDetails {
  String? studentId;
  String? studentName;
  String? punchInTime;
  String? punchOutTime;
  String? attendanceStatus;
  BatchList? batchList;
  String? punchInDate;

  AttendanceDetails(
      {this.studentId,
      this.studentName,
      this.punchInTime,
      this.punchOutTime,
      this.attendanceStatus,
      this.batchList,
      this.punchInDate});

  AttendanceDetails.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    studentName = json['studentName'];
    punchInTime = json['punchInTime'];
    punchOutTime = json['punchOutTime'];
    attendanceStatus = json['attendanceStatus'];
    batchList = json['batchList'] != null
        ? new BatchList.fromJson(json['batchList'])
        : null;
    punchInDate = json['punchInDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['punchInTime'] = this.punchInTime;
    data['punchOutTime'] = this.punchOutTime;
    data['attendanceStatus'] = this.attendanceStatus;
    if (this.batchList != null) {
      data['batchList'] = this.batchList!.toJson();
    }
    data['punchInDate'] = this.punchInDate;
    return data;
  }
}

class BatchList {
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

  BatchList(
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

  BatchList.fromJson(Map<String, dynamic> json) {
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