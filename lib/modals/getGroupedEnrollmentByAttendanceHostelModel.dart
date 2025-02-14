class GetGroupedEnrollmentByAttendanceHostelModel {
    GetGroupedEnrollmentByAttendanceHostelModel({
        required this.statusCode,
        required this.data,
    });

    final int? statusCode;
    final Data? data;

    factory GetGroupedEnrollmentByAttendanceHostelModel.fromJson(Map<String, dynamic> json){ 
        return GetGroupedEnrollmentByAttendanceHostelModel(
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
        required this.date,
        required this.fromDate,
        required this.toDate,
        required this.month,
        required this.statusCounts,
        required this.percentageSummary,
        required this.attendanceDetails,
        required this.missPunch,
        required this.present,
        required this.absent,
    });

    final String? date;
    final String? fromDate;
    final String? toDate;
    final String? month;
    final StatusCounts? statusCounts;
    final PercentageSummary? percentageSummary;
    final List<dynamic> attendanceDetails;
    final List<dynamic> missPunch;
    final List<dynamic> present;
    final List<dynamic> absent;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            date: json["date"],
            fromDate: json["fromDate"],
            toDate: json["toDate"],
            month: json["month"],
            statusCounts: json["statusCounts"] == null ? null : StatusCounts.fromJson(json["statusCounts"]),
            percentageSummary: json["percentageSummary"] == null ? null : PercentageSummary.fromJson(json["percentageSummary"]),
            attendanceDetails: json["attendanceDetails"] == null ? [] : List<dynamic>.from(json["attendanceDetails"]!.map((x) => x)),
            missPunch: json["miss_punch"] == null ? [] : List<dynamic>.from(json["miss_punch"]!.map((x) => x)),
            present: json["present"] == null ? [] : List<dynamic>.from(json["present"]!.map((x) => x)),
            absent: json["absent"] == null ? [] : List<dynamic>.from(json["absent"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "date": date,
        "fromDate": fromDate,
        "toDate": toDate,
        "month": month,
        "statusCounts": statusCounts?.toJson(),
        "percentageSummary": percentageSummary?.toJson(),
        "attendanceDetails": attendanceDetails.map((x) => x).toList(),
        "miss_punch": missPunch.map((x) => x).toList(),
        "present": present.map((x) => x).toList(),
        "absent": absent.map((x) => x).toList(),
    };

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

    Map<String, dynamic> toJson() => {
        "Present": present,
        "Absent": absent,
        "Miss_Punch": missPunch,
    };

}

class StatusCounts {
    StatusCounts({
        required this.present,
        required this.absent,
        required this.missPunch,
    });

    final int? present;
    final int? absent;
    final int? missPunch;

    factory StatusCounts.fromJson(Map<String, dynamic> json){ 
        return StatusCounts(
            present: json["Present"],
            absent: json["Absent"],
            missPunch: json["Miss Punch"],
        );
    }

    Map<String, dynamic> toJson() => {
        "Present": present,
        "Absent": absent,
        "Miss Punch": missPunch,
    };

}
