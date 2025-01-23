// class getGroupedEnrollmentByAttendanceTutee {
//   int? statusCode;
//   TuteeData? data;

//   getGroupedEnrollmentByAttendanceTutee({this.statusCode, this.data});

//   getGroupedEnrollmentByAttendanceTutee.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     data = json['data'] != null ? new TuteeData.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class TuteeData {
//   String? batchId;
//   String? date;
//   String? fromDate;
//   String? toDate;
//   String? month;
//   StatusCounts? statusCounts;
//   List<AttendanceDetails>? attendanceDetails;

//   TuteeData(
//       {this.batchId,
//       this.date,
//       this.fromDate,
//       this.toDate,
//       this.month,
//       this.statusCounts,
//       this.attendanceDetails});

//   TuteeData.fromJson(Map<String, dynamic> json) {
//     batchId = json['batchId'];
//     date = json['date'];
//     fromDate = json['fromDate'];
//     toDate = json['toDate'];
//     month = json['month'];
//     statusCounts = json['statusCounts'] != null
//         ? new StatusCounts.fromJson(json['statusCounts'])
//         : null;
//     if (json['attendanceDetails'] != null) {
//       attendanceDetails = <AttendanceDetails>[];
//       json['attendanceDetails'].forEach((v) {
//         attendanceDetails!.add(new AttendanceDetails.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['batchId'] = this.batchId;
//     data['date'] = this.date;
//     data['fromDate'] = this.fromDate;
//     data['toDate'] = this.toDate;
//     data['month'] = this.month;
//     if (this.statusCounts != null) {
//       data['statusCounts'] = this.statusCounts!.toJson();
//     }
//     if (this.attendanceDetails != null) {
//       data['attendanceDetails'] =
//           this.attendanceDetails!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class StatusCounts {
//   int? present;
//   int? absent;
//   int? leave;
//   int? partialAttendance;
//   int? totalStudents;
//    int? missPunch;
//   StatusCounts(
//       {this.present,
//       this.absent,
//       this.leave,
//       this.partialAttendance,
//          this.missPunch,
//       this.totalStudents});

//   StatusCounts.fromJson(Map<String, dynamic> json) {
//     present = json['Present'];
//     absent = json['Absent'];
//     leave = json['Leave'];
//     partialAttendance = json['Partial Attendance'];
//     totalStudents = json['totalStudents'];
//      missPunch = json['Miss Punch'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Present'] = this.present;
//     data['Absent'] = this.absent;
//     data['Leave'] = this.leave;
//     data['Partial Attendance'] = this.partialAttendance;
//     data['totalStudents'] = this.totalStudents;
//      data['Miss Punch'] = this.missPunch;
//     return data;
//   }
// }

// class AttendanceDetails {
//   String? attendanceId;
//   String? studentId;
//   String? studentName;
//   String? punchInTime;
//   String? punchOutTime;
//   String? attendanceStatus;
//   BatchList? batchList;
//   String? punchInDate;

//   AttendanceDetails(
//       {this.studentId,
//         this.attendanceId,
//       this.studentName,
//       this.punchInTime,
//       this.punchOutTime,
//       this.attendanceStatus,
//       this.batchList,
//       this.punchInDate});

//   AttendanceDetails.fromJson(Map<String, dynamic> json) {
//      attendanceId = json['attendanceId'];
//     studentId = json['studentId'];
//     studentName = json['studentName'];
//     punchInTime = json['punchInTime'];
//     punchOutTime = json['punchOutTime'];
//     attendanceStatus = json['attendanceStatus'];
//     batchList = json['batchList'] != null
//         ? new BatchList.fromJson(json['batchList'])
//         : null;
//     punchInDate = json['punchInDate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//      data['attendanceId'] = this.attendanceId;
//     data['studentId'] = this.studentId;
//     data['studentName'] = this.studentName;
//     data['punchInTime'] = this.punchInTime;
//     data['punchOutTime'] = this.punchOutTime;
//     data['attendanceStatus'] = this.attendanceStatus;
//     if (this.batchList != null) {
//       data['batchList'] = this.batchList!.toJson();
//     }
//     data['punchInDate'] = this.punchInDate;
//     return data;
//   }
// }

// class BatchList {
//   String? sId;
//   String? batchName;
//   String? batchTeacher;
//   String? batchMaximumSlots;
//   String? batchTimingStart;
//   String? batchTimingEnd;
//   int? batchTimingStartMinutes;
//   int? batchTimingEndMinutes;
//   String? batchDays;
//   String? batchMode;
//   String? fees;
//   String? month;
//   String? userId;
//   String? batchCode;
//   int? isActive;
//   int? isDelete;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   BatchList(
//       {this.sId,
//       this.batchName,
//       this.batchTeacher,
//       this.batchMaximumSlots,
//       this.batchTimingStart,
//       this.batchTimingEnd,
//       this.batchTimingStartMinutes,
//       this.batchTimingEndMinutes,
//       this.batchDays,
//       this.batchMode,
//       this.fees,
//       this.month,
//       this.userId,
//       this.batchCode,
//       this.isActive,
//       this.isDelete,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   BatchList.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     batchName = json['batch_name'];
//     batchTeacher = json['batch_teacher'];
//     batchMaximumSlots = json['batch_maximum_slots'];
//     batchTimingStart = json['batch_timing_start'];
//     batchTimingEnd = json['batch_timing_end'];
//     batchTimingStartMinutes = json['batch_timing_start_minutes'];
//     batchTimingEndMinutes = json['batch_timing_end_minutes'];
//     batchDays = json['batch_days'];
//     batchMode = json['batch_mode'];
//     fees = json['fees'];
//     month = json['month'];
//     userId = json['userId'];
//     batchCode = json['batch_code'];
//     isActive = json['is_active'];
//     isDelete = json['is_delete'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['batch_name'] = this.batchName;
//     data['batch_teacher'] = this.batchTeacher;
//     data['batch_maximum_slots'] = this.batchMaximumSlots;
//     data['batch_timing_start'] = this.batchTimingStart;
//     data['batch_timing_end'] = this.batchTimingEnd;
//     data['batch_timing_start_minutes'] = this.batchTimingStartMinutes;
//     data['batch_timing_end_minutes'] = this.batchTimingEndMinutes;
//     data['batch_days'] = this.batchDays;
//     data['batch_mode'] = this.batchMode;
//     data['fees'] = this.fees;
//     data['month'] = this.month;
//     data['userId'] = this.userId;
//     data['batch_code'] = this.batchCode;
//     data['is_active'] = this.isActive;
//     data['is_delete'] = this.isDelete;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

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
  List<MissPunch>? missPunch;
  List<MissPunch>? parent;
  List<MissPunch>? absent;
  List<Holidays>? holidays;
  List<Leave>? leave;

  TuteeData(
      {this.batchId,
      this.date,
      this.fromDate,
      this.toDate,
      this.month,
      this.statusCounts,
      this.attendanceDetails,
      this.missPunch,
      this.parent,
      this.absent,
      this.holidays,
      this.leave});

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
    if (json['miss_punch'] != null) {
      missPunch = <MissPunch>[];
      json['miss_punch'].forEach((v) {
        missPunch!.add(new MissPunch.fromJson(v));
      });
    }
    if (json['parent'] != null) {
      parent = <MissPunch>[];
      json['parent'].forEach((v) {
        parent!.add(MissPunch.fromJson(v));
      });
    }
    if (json['absent'] != null) {
      absent = <MissPunch>[];
      json['absent'].forEach((v) {
        absent!.add(new MissPunch.fromJson(v));
      });
    }
     if (json['holidays'] != null) {
      holidays = <Holidays>[];
      json['holidays'].forEach((v) {
        holidays!.add(new Holidays.fromJson(v));
      });
    }
    if (json['leave'] != null) {
      leave = <Leave>[];
      json['leave'].forEach((v) {
        leave!.add(new Leave.fromJson(v));
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
    if (this.missPunch != null) {
      data['miss_punch'] = this.missPunch!.map((v) => v.toJson()).toList();
    }
    if (this.parent != null) {
      data['parent'] = this.parent!.map((v) => v.toJson()).toList();
    }
    if (this.absent != null) {
      data['absent'] = this.absent!.map((v) => v.toJson()).toList();
    }
     if (this.holidays != null) {
      data['holidays'] = this.holidays!.map((v) => v.toJson()).toList();
    }
    if (this.leave != null) {
      data['leave'] = this.leave!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusCounts {
  int? present;
  int? absent;
  int? leave;
  int? partialAttendance;
  int? missPunch;
  int? totalStudents;

  StatusCounts(
      {this.present,
      this.absent,
      this.leave,
      this.partialAttendance,
      this.missPunch,
      this.totalStudents});

  StatusCounts.fromJson(Map<String, dynamic> json) {
    present = json['Present'];
    absent = json['Absent'];
    leave = json['Leave'];
    partialAttendance = json['Partial Attendance'];
    missPunch = json['Miss Punch'];
    totalStudents = json['totalStudents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Present'] = this.present;
    data['Absent'] = this.absent;
    data['Leave'] = this.leave;
    data['Partial Attendance'] = this.partialAttendance;
    data['Miss Punch'] = this.missPunch;
    data['totalStudents'] = this.totalStudents;
    return data;
  }
}

class AttendanceDetails {
  String? attendanceId;
  String? studentId;
  String? studentName;
  String? punchInTime;
  String? punchOutTime;
  String? attendanceStatus;
  BatchList? batchList;
  String? punchInDate;

  AttendanceDetails(
      {this.attendanceId,
      this.studentId,
      this.studentName,
      this.punchInTime,
      this.punchOutTime,
      this.attendanceStatus,
      this.batchList,
      this.punchInDate});

  AttendanceDetails.fromJson(Map<String, dynamic> json) {
    attendanceId = json['attendanceId'];
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
    data['attendanceId'] = this.attendanceId;
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
    //batchDays = json['batch_days'];
     batchDays: json["batch_days"] == null
    ? []
    : (json["batch_days"] is String
        ? json["batch_days"].split(', ') // Handle string case
        : List<String>.from(json["batch_days"])); // Handle list case
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

class MissPunch {
  String? sId;
  String? punchInTime;

  MissPunch({this.sId, this.punchInTime});

  MissPunch.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    punchInTime = json['punchInTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['punchInTime'] = this.punchInTime;
    return data;
  }

  
}
class Holidays {
  String? sId;
  String? holidayDate;

  Holidays({this.sId, this.holidayDate});

  Holidays.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    holidayDate = json['holiday_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['holiday_date'] = this.holidayDate;
    return data;
  }
}

class Leave {
  String? sId;
  String? leaveDate;

  Leave({this.sId, this.leaveDate});

  Leave.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    leaveDate = json['leave_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['leave_date'] = this.leaveDate;
    return data;
  }
}
