class GetHostelAttendanceCalendarReportModel {
    GetHostelAttendanceCalendarReportModel({
        required this.statusCode,
        required this.data,
    });

    final int? statusCode;
    final CalendarData? data;

    factory GetHostelAttendanceCalendarReportModel.fromJson(Map<String, dynamic> json){ 
        return GetHostelAttendanceCalendarReportModel(
            statusCode: json["statusCode"],
            data: json["data"] == null ? null : CalendarData.fromJson(json["data"]),
        );
    }

}

class CalendarData {
    CalendarData({
        required this.status,
        required this.percentageSummary,
        required this.attendanceByStatus,
    });

    final Status? status;
    final PercentageSummary? percentageSummary;
    final AttendanceByStatus? attendanceByStatus;

    factory CalendarData.fromJson(Map<String, dynamic> json){ 
        return CalendarData(
            status: json["status"] == null ? null : Status.fromJson(json["status"]),
            percentageSummary: json["percentageSummary"] == null ? null : PercentageSummary.fromJson(json["percentageSummary"]),
            attendanceByStatus: json["attendanceByStatus"] == null ? null : AttendanceByStatus.fromJson(json["attendanceByStatus"]),
        );
    }

}

class AttendanceByStatus {
    AttendanceByStatus({
        required this.present,
        required this.absent,
        required this.missPunch,
    });

    final List<Sent> present;
    final List<Sent> absent;
    final List<Sent> missPunch;

    factory AttendanceByStatus.fromJson(Map<String, dynamic> json){ 
        return AttendanceByStatus(
            present: json["present"] == null ? [] : List<Sent>.from(json["present"]!.map((x) => Sent.fromJson(x))),
            absent: json["absent"] == null ? [] : List<Sent>.from(json["absent"]!.map((x) => Sent.fromJson(x))),
            missPunch: json["missPunch"] == null ? [] : List<Sent>.from(json["missPunch"]!.map((x) => x)),
        );
    }

}

class Sent {
    Sent({
        required this.date,
        required this.count,
    });

    final String? date;
    final int? count;

    factory Sent.fromJson(Map<String, dynamic> json){ 
        return Sent(
            date: json["date"],
            count: json["count"],
        );
    }

}

class PercentageSummary {
    PercentageSummary({
        required this.present,
        required this.absent,
        required this.missPunch,
    });

    final String? present;
    final String? absent;
    final String? missPunch;

    factory PercentageSummary.fromJson(Map<String, dynamic> json){ 
        return PercentageSummary(
            present: json["Present"],
            absent: json["Absent"],
            missPunch: json["Miss_Punch"],
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
