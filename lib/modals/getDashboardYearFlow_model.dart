class getdashboardYearflowModel {
  int? statusCode;
  Data? data;

  getdashboardYearflowModel({this.statusCode, this.data});

  getdashboardYearflowModel.fromJson(Map<String, dynamic> json) {
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
  List<Attendacemonth>? attendacemonth;
  List<AttendaceYrs>? attendaceYrs;
  Dailyattendance? dailyattendance;
   String? currentMonthYear;

  Data({this.attendacemonth, this.attendaceYrs, this.dailyattendance, this.currentMonthYear});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['attendacemonth'] != null) {
      attendacemonth = <Attendacemonth>[];
      json['attendacemonth'].forEach((v) {
        attendacemonth!.add(new Attendacemonth.fromJson(v));
      });
    }
    if (json['attendace_yrs'] != null) {
      attendaceYrs = <AttendaceYrs>[];
      json['attendace_yrs'].forEach((v) {
        attendaceYrs!.add(new AttendaceYrs.fromJson(v));
      });
    }
    dailyattendance = json['dailyattendance'] != null
        ? new Dailyattendance.fromJson(json['dailyattendance'])
        : null;
         currentMonthYear = json['currentMonthYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attendacemonth != null) {
      data['attendacemonth'] =
          this.attendacemonth!.map((v) => v.toJson()).toList();
    }
    if (this.attendaceYrs != null) {
      data['attendace_yrs'] =
          this.attendaceYrs!.map((v) => v.toJson()).toList();
    }
    if (this.dailyattendance != null) {
      data['dailyattendance'] = this.dailyattendance!.toJson();
    }
     data['currentMonthYear'] = this.currentMonthYear;
    return data;
  }
}

class Attendacemonth {
  int? iId;
  int? studentCount;
  String? month;

  Attendacemonth({this.iId, this.studentCount, this.month});

  Attendacemonth.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    studentCount = json['student_count'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['student_count'] = this.studentCount;
    data['month'] = this.month;
    return data;
  }
}

class AttendaceYrs {
  int? iId;
  int? year;
  int? studentCount;

  AttendaceYrs({this.iId, this.year, this.studentCount});

  AttendaceYrs.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    year = json['year'];
    studentCount = json['student_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['year'] = this.year;
    data['student_count'] = this.studentCount;
    return data;
  }
}

class Dailyattendance {
  int? present;
  int? absent;
  int? leave;
  int? partialAttendance;
  Percentage? percentage;

  Dailyattendance(
      {this.present,
      this.absent,
      this.leave,
      this.partialAttendance,
      this.percentage});

  Dailyattendance.fromJson(Map<String, dynamic> json) {
    present = json['Present'];
    absent = json['Absent'];
    leave = json['Leave'];
    partialAttendance = json['Partial Attendance'];
    percentage = json['percentage'] != null
        ? new Percentage.fromJson(json['percentage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Present'] = this.present;
    data['Absent'] = this.absent;
    data['Leave'] = this.leave;
    data['Partial Attendance'] = this.partialAttendance;
    if (this.percentage != null) {
      data['percentage'] = this.percentage!.toJson();
    }
    return data;
  }
}

class Percentage {
  String? present;
  String? absent;
  String? leave;
  String? partial;

  Percentage({this.present, this.absent, this.leave, this.partial});

  Percentage.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    absent = json['absent'];
    leave = json['leave'];
    partial = json['partial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present'] = this.present;
    data['absent'] = this.absent;
    data['leave'] = this.leave;
    data['partial'] = this.partial;
    return data;
  }
}