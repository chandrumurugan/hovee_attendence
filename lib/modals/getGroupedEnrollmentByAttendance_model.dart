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

  Data.fromJson(Map<String, dynamic> json,) {
    batchId = json['batchId'];
    date = json['date'];
    statusCounts = json["statusCounts"];
   
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
    // data['presentStudents'] = this.presentStudents;
    if (this.attendanceDetails != null) {
      data['attendanceDetails'] =
          this.attendanceDetails!.map((v) => v.toJson()).toList();
    }
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
      this.punchInTime,
      this.punchOutTime,
      this.studentName,
      this.attendanceStatus});

  AttendanceDetails.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    punchInTime = json['punchInTime'];
    punchOutTime = json['punchOutTime'];
    attendanceStatus = json['attendanceStatus'];
    studentName = json['studentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['punchInTime'] = this.punchInTime;
    data['punchOutTime'] = this.punchOutTime;
    data['attendanceStatus'] = this.attendanceStatus;
    data['studentName'] = this.studentName;
    return data;
  }
}

class StatusCounts {
  StatusCounts({
    required this.present,
    required this.absent,
    required this.leave,
    required this.partialAttendance,
    required this.totalStudents,
  });

  final int present;
  final int absent;
  final int leave;
  final int partialAttendance;
  final int totalStudents;

  factory StatusCounts.fromJson(Map<String, dynamic> json) {
    return StatusCounts(
      present: json["Present"] ?? 0,
      absent: json["Absent"] ?? 0,
      leave: json["Leave"] ?? 0,
      partialAttendance: json["Partial Attendance"] ?? 0,
      totalStudents: json["totalStudents"] ?? 0,
    );
  }
}
