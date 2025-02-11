import 'package:hovee_attendence/modals/getGroupedEnrollmentByAttendanceTutee_model.dart';

class getGroupedEnrollmentByAttendanceModel {
 int? statusCode;
  Data? data;

  getGroupedEnrollmentByAttendanceModel({this.statusCode, this.data});

  getGroupedEnrollmentByAttendanceModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? batchId;
  String? date;
  String? month;
  StatusCounts? statusCounts;
  List<AttendanceDetails>? attendanceDetails;
  List<Holidays>? holidays;
  List<Holidays>? missPunch;
  List<Holidays>? present;
  List<Holidays>? absent;
  List<Leave>? leave;

  Data(
      {this.batchId,
      this.date,
      this.month,
      this.statusCounts,
      this.attendanceDetails,
      this.holidays,
       this.missPunch,
      this.present,
      this.absent,
       this.leave});

  Data.fromJson(Map<String, dynamic> json) {
    batchId = json['batchId'];
    date = json['date'];
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
    if (json['holidays'] != null) {
      holidays = <Holidays>[];
      json['holidays'].forEach((v) {
        holidays!.add(new Holidays.fromJson(v));
      });
    }
    if (json['miss_punch'] != null) {
      missPunch = <Holidays>[];
      json['miss_punch'].forEach((v) {
        missPunch!.add(new Holidays.fromJson(v));
      });
    }
    if (json['present'] != null) {
      present = <Holidays>[];
      json['present'].forEach((v) {
        present!.add(new Holidays.fromJson(v));
      });
    }
    if (json['absent'] != null) {
      absent = <Holidays>[];
      json['absent'].forEach((v) {
        absent!.add(new Holidays.fromJson(v));
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
    data['month'] = this.month;
    if (this.statusCounts != null) {
      data['statusCounts'] = this.statusCounts!.toJson();
    }
    if (this.attendanceDetails != null) {
      data['attendanceDetails'] =
          this.attendanceDetails!.map((v) => v.toJson()).toList();
    }
     if (this.holidays != null) {
      data['holidays'] = this.holidays!.map((v) => v.toJson()).toList();
    }
    if (this.missPunch != null) {
      data['miss_punch'] = this.missPunch!.map((v) => v.toJson()).toList();
    }
    if (this.present != null) {
      data['present'] = this.present!.map((v) => v.toJson()).toList();
    }
    if (this.absent != null) {
      data['absent'] = this.absent!.map((v) => v.toJson()).toList();
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
  int? totalStudents;
  int? missPunch;

  StatusCounts(
      {this.present,
      this.absent,
      this.leave,
      this.partialAttendance,
      this.totalStudents,
      this.missPunch});

  StatusCounts.fromJson(Map<String, dynamic> json) {
    present = json['Present'];
    absent = json['Absent'];
    leave = json['Leave'];
    partialAttendance = json['Partial Attendance'];
    totalStudents = json['totalStudents'];
    missPunch = json['Miss Punch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Present'] = this.present;
    data['Absent'] = this.absent;
    data['Leave'] = this.leave;
    data['Partial Attendance'] = this.partialAttendance;
    data['totalStudents'] = this.totalStudents;
      data['Miss Punch'] = this.missPunch;
    return data;
  }
}

class AttendanceDetails {
  String? studentId;
  String? studentName;
  String? punchInTime;
  String? punchOutTime;
  String? attendanceStatus;
  String? punchInDate;
   String? rollNo;

  AttendanceDetails(
      {this.studentId,
      this.studentName,
      this.punchInTime,
      this.punchOutTime,
       this.rollNo,
      this.attendanceStatus,
      this.punchInDate});

  AttendanceDetails.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    studentName = json['studentName'];
    punchInTime = json['punchInTime'];
    punchOutTime = json['punchOutTime'];
    attendanceStatus = json['attendanceStatus'];
    punchInDate = json['punchInDate'];
     rollNo = json['roll_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['punchInTime'] = this.punchInTime;
    data['punchOutTime'] = this.punchOutTime;
    data['attendanceStatus'] = this.attendanceStatus;
    data['punchInDate'] = this.punchInDate;
     data['roll_no'] = this.rollNo;
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
