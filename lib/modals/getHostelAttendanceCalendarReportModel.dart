class GetHostelAttendanceCalendarReportModel {
    GetHostelAttendanceCalendarReportModel({
        required this.statusCode,
        required this.data,
    });

    final int? statusCode;
    final CalendarReportData? data;

    factory GetHostelAttendanceCalendarReportModel.fromJson(Map<String, dynamic> json){ 
        return GetHostelAttendanceCalendarReportModel(
            statusCode: json["statusCode"],
            data: json["data"] == null ? null : CalendarReportData.fromJson(json["data"]),
        );
    }

}

class CalendarReportData {
    CalendarReportData({
        required this.status,
        required this.attendanceByDate,
    });

    final Status? status;
    final AttendanceByDate? attendanceByDate;

    factory CalendarReportData.fromJson(Map<String, dynamic> json){ 
        return CalendarReportData(
            status: json["status"] == null ? null : Status.fromJson(json["status"]),
            attendanceByDate: json["attendanceByDate"] == null ? null : AttendanceByDate.fromJson(json["attendanceByDate"]),
        );
    }

}

class AttendanceByDate {
    AttendanceByDate({
        required this.date,
    });

    final String? date;

    factory AttendanceByDate.fromJson(Map<String, dynamic> json){ 
        return AttendanceByDate(
            date: json["2025-03-19"],
        );
    }

}

class Status {
    Status({
        required this.totalDays,
        required this.totalPresent,
        required this.totalAbsent,
        required this.totalMisspunch,
    });

    final int? totalDays;
    final int? totalPresent;
    final int? totalAbsent;
    final int? totalMisspunch;

    factory Status.fromJson(Map<String, dynamic> json){ 
        return Status(
            totalDays: json["totalDays"],
            totalPresent: json["totalPresent"],
            totalAbsent: json["totalAbsent"],
            totalMisspunch: json["totalMisspunch"],
        );
    }

}
