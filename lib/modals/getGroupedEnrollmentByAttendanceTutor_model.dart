class GetGroupedEnrollmentByAttendanceTutorModel {
    GetGroupedEnrollmentByAttendanceTutorModel({
        required this.statusCode,
        required this.data,
    });

    final int? statusCode;
    final Data? data;

    factory GetGroupedEnrollmentByAttendanceTutorModel.fromJson(Map<String, dynamic> json){ 
        return GetGroupedEnrollmentByAttendanceTutorModel(
            statusCode: json["statusCode"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data?.toJson(),
    };

}

class Data {
    Data({
        required this.batchId,
        required this.date,
        required this.fromDate,
        required this.toDate,
        required this.month,
        required this.statusCounts,
        required this.attendanceDetails,
        required this.missPunch,
        required this.parent,
        required this.absent,
        required this.holidays,
        required this.leave,
    });

    final String? batchId;
    final String? date;
    final String? fromDate;
    final String? toDate;
    final String? month;
    final StatusCounts? statusCounts;
    final List<AttendanceDetail> attendanceDetails;
    final List<Holiday> missPunch;
    final List<Holiday> parent;
    final List<Holiday> absent;
    final List<Holiday> holidays;
    final List<Holiday> leave;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            batchId: json["batchId"],
            date: json["date"],
            fromDate: json["fromDate"],
            toDate: json["toDate"],
            month: json["month"],
            statusCounts: json["statusCounts"] == null ? null : StatusCounts.fromJson(json["statusCounts"]),
            attendanceDetails: json["attendanceDetails"] == null ? [] : List<AttendanceDetail>.from(json["attendanceDetails"]!.map((x) => AttendanceDetail.fromJson(x))),
            missPunch: json["miss_punch"] == null ? [] : List<Holiday>.from(json["miss_punch"]!.map((x) => x)),
            parent: json["parent"] == null ? [] : List<Holiday>.from(json["parent"]!.map((x) => x)),
            absent: json["absent"] == null ? [] : List<Holiday>.from(json["absent"]!.map((x) => x)),
            holidays: json["holidays"] == null ? [] : List<Holiday>.from(json["holidays"]!.map((x) => Holiday.fromJson(x))),
            leave: json["leave"] == null ? [] : List<Holiday>.from(json["leave"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "batchId": batchId,
        "date": date,
        "fromDate": fromDate,
        "toDate": toDate,
        "month": month,
        "statusCounts": statusCounts?.toJson(),
        "attendanceDetails": attendanceDetails.map((x) => x?.toJson()).toList(),
        "miss_punch": missPunch.map((x) => x).toList(),
        "parent": parent.map((x) => x).toList(),
        "absent": absent.map((x) => x).toList(),
        "holidays": holidays.map((x) => x?.toJson()).toList(),
        "leave": leave.map((x) => x).toList(),
    };

}

class AttendanceDetail {
    AttendanceDetail({
        required this.studentId,
        required this.studentName,
        required this.rollNo,
        required this.punchInTime,
        required this.punchOutTime,
        required this.attendanceStatus,
        required this.punchInDate,
    });

    final String? studentId;
    final String? studentName;
    final String? rollNo;
    final String? punchInTime;
    final dynamic punchOutTime;
    final String? attendanceStatus;
    final String? punchInDate;

    factory AttendanceDetail.fromJson(Map<String, dynamic> json){ 
        return AttendanceDetail(
            studentId: json["studentId"],
            studentName: json["studentName"],
            rollNo: json["roll_no"],
            punchInTime: json["punchInTime"],
            punchOutTime: json["punchOutTime"],
            attendanceStatus: json["attendanceStatus"],
            punchInDate: json["punchInDate"],
        );
    }

    Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "studentName": studentName,
        "roll_no": rollNo,
        "punchInTime": punchInTime,
        "punchOutTime": punchOutTime,
        "attendanceStatus": attendanceStatus,
        "punchInDate": punchInDate,
    };

}

class Holiday {
    Holiday({
        required this.id,
        required this.holidayDate,
    });

    final String? id;
    final String? holidayDate;

    factory Holiday.fromJson(Map<String, dynamic> json){ 
        return Holiday(
            id: json["_id"],
            holidayDate: json["holiday_date"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "holiday_date": holidayDate,
    };

}

class StatusCounts {
    StatusCounts({
        required this.present,
        required this.absent,
        required this.leave,
        required this.partialAttendance,
        required this.missPunch,
        required this.totalStudents,
        required this.holiday,
    });

    final int? present;
    final int? absent;
    final int? leave;
    final int? partialAttendance;
    final int? missPunch;
    final int? totalStudents;
    final int? holiday;

    factory StatusCounts.fromJson(Map<String, dynamic> json){ 
        return StatusCounts(
            present: json["Present"],
            absent: json["Absent"],
            leave: json["Leave"],
            partialAttendance: json["Partial Attendance"],
            missPunch: json["Miss Punch"],
            totalStudents: json["totalStudents"],
            holiday: json["Holiday"],
        );
    }

    Map<String, dynamic> toJson() => {
        "Present": present,
        "Absent": absent,
        "Leave": leave,
        "Partial Attendance": partialAttendance,
        "Miss Punch": missPunch,
        "totalStudents": totalStudents,
        "Holiday": holiday,
    };

}
