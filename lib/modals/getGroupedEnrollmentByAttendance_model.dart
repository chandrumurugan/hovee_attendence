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
  StatusCounts? statusCounts;
  List<AttendanceDetails>? attendanceDetails;

  Data({this.batchId, this.date, this.statusCounts, this.attendanceDetails});

  Data.fromJson(Map<String, dynamic> json) {
    batchId = json['batchId'];
    date = json['date'];
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

  AttendanceDetails(
      {this.studentId,
      this.studentName,
      this.punchInTime,
      this.punchOutTime,
      this.attendanceStatus});

  AttendanceDetails.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    studentName = json['studentName'];
    punchInTime = json['punchInTime'];
    punchOutTime = json['punchOutTime'];
    attendanceStatus = json['attendanceStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['punchInTime'] = this.punchInTime;
    data['punchOutTime'] = this.punchOutTime;
    data['attendanceStatus'] = this.attendanceStatus;
    return data;
  }
}