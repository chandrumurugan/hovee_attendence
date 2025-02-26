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
  String? attendanceId;
  String? hostellerObjectId;
  String? hostellerName;
  String? punchInTime;
  String? punchOutTime;
  String? attendanceStatus;
  HostelList? hostelList;
  Enrollement? enrollement;
  String? punchInDate;

  AttendanceDetails(
      {this.attendanceId,
      this.hostellerObjectId,
      this.hostellerName,
      this.punchInTime,
      this.punchOutTime,
      this.attendanceStatus,
      this.hostelList,
      this.enrollement,
      this.punchInDate});

  AttendanceDetails.fromJson(Map<String, dynamic> json) {
    attendanceId = json['attendanceId'];
    hostellerObjectId = json['hosteller_ObjectId'];
    hostellerName = json['hostellerName'];
    punchInTime = json['punchInTime'];
    punchOutTime = json['punchOutTime'];
    attendanceStatus = json['attendanceStatus'];
    hostelList = json['hostelList'] != null
        ? new HostelList.fromJson(json['hostelList'])
        : null;
    enrollement = json['enrollement'] != null
        ? new Enrollement.fromJson(json['enrollement'])
        : null;
    punchInDate = json['punchInDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendanceId'] = this.attendanceId;
    data['hosteller_ObjectId'] = this.hostellerObjectId;
    data['hostellerName'] = this.hostellerName;
    data['punchInTime'] = this.punchInTime;
    data['punchOutTime'] = this.punchOutTime;
    data['attendanceStatus'] = this.attendanceStatus;
    if (this.hostelList != null) {
      data['hostelList'] = this.hostelList!.toJson();
    }
    if (this.enrollement != null) {
      data['enrollement'] = this.enrollement!.toJson();
    }
    data['punchInDate'] = this.punchInDate;
    return data;
  }
}

class HostelList {
  Location? location;
  String? sId;
  String? hostelObjectId;
  String? roomType;
  String? hostelName;
  String? registerNo;
  String? shortName;
  String? hostelType;
  String? food;
  String? categories;
  String? remarks;
  double? latitude;
  double? longitude;
  String? doorNo;
  String? street;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? profileFilename;
  String? profileUrl;
  String? hostelTimingStart;
  String? hostelTimingEnd;
  int? hostelTimingStartMinutes;
  int? hostelTimingEndMinutes;
  String? qrCodeUrl;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  HostelList(
      {this.location,
      this.sId,
      this.hostelObjectId,
      this.roomType,
      this.hostelName,
      this.registerNo,
      this.shortName,
      this.hostelType,
      this.food,
      this.categories,
      this.remarks,
      this.latitude,
      this.longitude,
      this.doorNo,
      this.street,
      this.city,
      this.state,
      this.country,
      this.pincode,
      this.profileFilename,
      this.profileUrl,
      this.hostelTimingStart,
      this.hostelTimingEnd,
      this.hostelTimingStartMinutes,
      this.hostelTimingEndMinutes,
      this.qrCodeUrl,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.iV});

  HostelList.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    hostelObjectId = json['hostel_ObjectId'];
    roomType = json['room_type'];
    hostelName = json['hostel_name'];
    registerNo = json['register_no'];
    shortName = json['short_name'];
    hostelType = json['hostel_type'];
    food = json['food'];
    categories = json['categories'];
    remarks = json['remarks'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    doorNo = json['door_no'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    profileFilename = json['profile_filename'];
    profileUrl = json['profile_url'];
    hostelTimingStart = json['hostel_timing_start'];
    hostelTimingEnd = json['hostel_timing_end'];
    hostelTimingStartMinutes = json['hostel_timing_start_minutes'];
    hostelTimingEndMinutes = json['hostel_timing_end_minutes'];
    qrCodeUrl = json['qr_code_url'];
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['hostel_ObjectId'] = this.hostelObjectId;
    data['room_type'] = this.roomType;
    data['hostel_name'] = this.hostelName;
    data['register_no'] = this.registerNo;
    data['short_name'] = this.shortName;
    data['hostel_type'] = this.hostelType;
    data['food'] = this.food;
    data['categories'] = this.categories;
    data['remarks'] = this.remarks;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['door_no'] = this.doorNo;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['profile_filename'] = this.profileFilename;
    data['profile_url'] = this.profileUrl;
    data['hostel_timing_start'] = this.hostelTimingStart;
    data['hostel_timing_end'] = this.hostelTimingEnd;
    data['hostel_timing_start_minutes'] = this.hostelTimingStartMinutes;
    data['hostel_timing_end_minutes'] = this.hostelTimingEndMinutes;
    data['qr_code_url'] = this.qrCodeUrl;
    data['is_active'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Enrollement {
  String? sId;
  String? hostelId;
  String? rollNumber;
  String? startDate;
  String? endDate;
  String? status;

  Enrollement(
      {this.sId,
      this.hostelId,
      this.rollNumber,
      this.startDate,
      this.endDate,
      this.status});

  Enrollement.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    hostelId = json['hostelId'];
    rollNumber = json['rollNumber'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['hostelId'] = this.hostelId;
    data['rollNumber'] = this.rollNumber;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
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

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
