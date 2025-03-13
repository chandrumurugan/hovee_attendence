class GetBatchtuteelistModel {
    GetBatchtuteelistModel({
        required this.success,
        required this.data,
    });

    final bool? success;
    final List<Datum> data;

    factory GetBatchtuteelistModel.fromJson(Map<String, dynamic> json){ 
        return GetBatchtuteelistModel(
            success: json["success"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.batchShortName,
        required this.batchName,
        required this.branchName,
        required this.batchTeacher,
        required this.batchMaximumSlots,
        required this.teacherId,
        required this.batchTimingStart,
        required this.batchTimingEnd,
        required this.batchTimingStartMinutes,
        required this.batchTimingEndMinutes,
        required this.batchDays,
        required this.batchMode,
        required this.fees,
        required this.month,
        required this.startDate,
        required this.endDate,
        required this.userId,
        required this.institudeName,
        required this.institudeId,
        required this.batchCode,
        required this.isActive,
        required this.isDelete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.tutees,
    });

    final String? id;
    final String? batchShortName;
    final String? batchName;
    final String? branchName;
    final String? batchTeacher;
    final String? batchMaximumSlots;
    final String? teacherId;
    final String? batchTimingStart;
    final String? batchTimingEnd;
    final int? batchTimingStartMinutes;
    final int? batchTimingEndMinutes;
    final List<String> batchDays;
    final String? batchMode;
    final String? fees;
    final String? month;
    final String? startDate;
    final String? endDate;
    final String? userId;
    final String? institudeName;
    final String? institudeId;
    final String? batchCode;
    final int? isActive;
    final int? isDelete;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final List<Tutee> tutees;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["_id"],
            batchShortName: json["batch_short_name"],
            batchName: json["batch_name"],
            branchName: json["branch_name"],
            batchTeacher: json["batch_teacher"],
            batchMaximumSlots: json["batch_maximum_slots"],
            teacherId: json["teacherId"],
            batchTimingStart: json["batch_timing_start"],
            batchTimingEnd: json["batch_timing_end"],
            batchTimingStartMinutes: json["batch_timing_start_minutes"],
            batchTimingEndMinutes: json["batch_timing_end_minutes"],
             batchDays: json["batch_days"] is String 
            ? [json["batch_days"]]  // Convert single string to a list
            : List<String>.from(json["batch_days"] ?? []), // Convert list properly
            batchMode: json["batch_mode"],
            fees: json["fees"],
            month: json["month"],
            startDate: json["start_date"],
            endDate: json["end_date"],
            userId: json["userId"],
            institudeName: json["institude_name"],
            institudeId: json["institudeId"],
            batchCode: json["batch_code"],
            isActive: json["is_active"],
            isDelete: json["is_delete"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
            tutees: json["tutees"] == null ? [] : List<Tutee>.from(json["tutees"]!.map((x) => Tutee.fromJson(x))),
        );
    }

}

class Tutee {
    Tutee({
        required this.rollNumber,
        required this.status,
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneNumber,
        required this.profileFilename,
        required this.profileUrl,
    });

    final String? rollNumber;
    final String? status;
    final String? id;
    final String? firstName;
    final String? lastName;
    final String? email;
    final String? phoneNumber;
    final String? profileFilename;
    final String? profileUrl;

    factory Tutee.fromJson(Map<String, dynamic> json){ 
        return Tutee(
            rollNumber: json["rollNumber"],
            status: json["status"],
            id: json["_id"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            email: json["email"],
            phoneNumber: json["phone_number"],
            profileFilename: json["profile_filename"],
            profileUrl: json["profile_url"],
        );
    }

}
