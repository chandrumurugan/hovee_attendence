// class getClassTuteeByIdModel {
//   int? statusCode;
//   String? message;
//   Data1? data;

//   getClassTuteeByIdModel({this.statusCode, this.message, this.data});

//   getClassTuteeByIdModel.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     message = json['message'];
//     data = json['data'] != null ? new Data1.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data1 {
//   String? tutorId;
//   TutorDetails? tutorDetails;
//   String? courseId;
//   String? className;
//   String? subject;
//   String? courseCode;
//   String? remarks;
//   String? board;
//   List<String>? batchList;
//   List<BatchGroupList>? batchGroupList;
//   List<String>? workingDays;
//   int? noOfBatches;
//   String? address;
//   bool? alreadyExits;
//   String? tuitionName;
//   TuteeInformation? tuteeInformation;
//   Data1(
//       {this.tutorId,
//       this.tutorDetails,
//       this.courseId,
//       this.className,
//       this.subject,
//       this.courseCode,
//       this.remarks,
//       this.board,
//       this.batchList,
//       this.batchGroupList,
//       this.workingDays,
//       this.noOfBatches,
//       this.address,
//       this.alreadyExits,
//        this.tuitionName,
//         this.tuteeInformation});

//   Data1.fromJson(Map<String, dynamic> json) {
//     tutorId = json['TutorId'];
//     tutorDetails = json['TutorDetails'] != null
//         ? new TutorDetails.fromJson(json['TutorDetails'])
//         : null;
//     courseId = json['courseId'];
//     className = json['class_name'];
//     subject = json['subject'];
//     courseCode = json['course_code'];
//     remarks = json['remarks'];
//     board = json['board'];
//     batchList = json['batchList'].cast<String>();
//     if (json['batchGroupList'] != null) {
//       batchGroupList = <BatchGroupList>[];
//       json['batchGroupList'].forEach((v) {
//         batchGroupList!.add(new BatchGroupList.fromJson(v));
//       });
//     }
//     workingDays = json['working_days'].cast<String>();
//     noOfBatches = json['No_of_batches'];
//     address = json['address'];
//     alreadyExits = json['alreadyExits'];
//      tuitionName = json['tuitionName'];
//       tuteeInformation = json['tuteeInformation'] != null
//         ? new TuteeInformation.fromJson(json['tuteeInformation'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['TutorId'] = this.tutorId;
//     if (this.tutorDetails != null) {
//       data['TutorDetails'] = this.tutorDetails!.toJson();
//     }
//     data['courseId'] = this.courseId;
//     data['class_name'] = this.className;
//     data['subject'] = this.subject;
//     data['course_code'] = this.courseCode;
//     data['remarks'] = this.remarks;
//     data['board'] = this.board;
//     data['batchList'] = this.batchList;
//     if (this.batchGroupList != null) {
//       data['batchGroupList'] =
//           this.batchGroupList!.map((v) => v.toJson()).toList();
//     }
//     data['working_days'] = this.workingDays;
//     data['No_of_batches'] = this.noOfBatches;
//     data['address'] = this.address;
//     data['alreadyExits'] = this.alreadyExits;
//     data['tuitionName'] = this.tuitionName;
//      if (this.tuteeInformation != null) {
//       data['tuteeInformation'] = this.tuteeInformation!.toJson();
//     }
//     return data;
//   }
// }

// class TutorDetails {
//   String? sId;
//   int? pincode;
//   String? doorNo;
//   String? street;
//   String? city;
//   String? state;
//   String? country;

//   TutorDetails(
//       {this.sId,
//       this.pincode,
//       this.doorNo,
//       this.street,
//       this.city,
//       this.state,
//       this.country});

//   TutorDetails.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     pincode = json['pincode'];
//     doorNo = json['door_no'];
//     street = json['street'];
//     city = json['city'];
//     state = json['state'];
//     country = json['country'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['pincode'] = this.pincode;
//     data['door_no'] = this.doorNo;
//     data['street'] = this.street;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['country'] = this.country;
//     return data;
//   }
// }

// class BatchGroupList {
//   String? batchName;
//   String? batchMode;
//   String? startDate;
//   String? endDate;
//   String? batchId;
//   String? batchTiming;
//   int? availableSlots;
//   bool? isAvailable;

//   BatchGroupList(
//       {this.batchName,
//       this.batchMode,
//       this.startDate,
//       this.endDate,
//       this.batchId,
//       this.batchTiming,
//       this.availableSlots,
//       this.isAvailable});

//   BatchGroupList.fromJson(Map<String, dynamic> json) {
//     batchName = json['batch_name'];
//     batchMode = json['batch_mode'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     batchId = json['batchId'];
//     batchTiming = json['batch_timing'];
//     availableSlots = json['availableSlots'];
//     isAvailable = json['isAvailable'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['batch_name'] = this.batchName;
//     data['batch_mode'] = this.batchMode;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['batchId'] = this.batchId;
//     data['batch_timing'] = this.batchTiming;
//     data['availableSlots'] = this.availableSlots;
//     data['isAvailable'] = this.isAvailable;
//     return data;
//   }
// }

// class TuteeInformation {
//   String? sId;
//   String? email;
//   String? phoneNumber;

//   TuteeInformation({this.sId, this.email, this.phoneNumber});

//   TuteeInformation.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     email = json['email'];
//     phoneNumber = json['phone_number'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['email'] = this.email;
//     data['phone_number'] = this.phoneNumber;
//     return data;
//   }
// }

import 'package:intl/intl.dart';

class GetClassTuteeByIdModel {
    GetClassTuteeByIdModel({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final int? statusCode;
    final String? message;
    final Data1? data;

    factory GetClassTuteeByIdModel.fromJson(Map<String, dynamic> json){ 
        return GetClassTuteeByIdModel(
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? null : Data1.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data?.toJson(),
    };

}

class Data1 {
    Data1({
        required this.tutorId,
        required this.tutorDetails,
        required this.courseId,
        required this.subject,
        required this.courseCode,
        required this.institudesDetails,
        required this.remarks,
        required this.board,
        required this.batches,
        required this.noOfBatches,
        required this.address,
        required this.tuitionName,
        required this.alreadyExits,
        required this.availableSlots,
        required this.tuteeInformation,
        required this.className
    });

    final String? tutorId;
    final TutorDetails? tutorDetails;
    final String? courseId;
    final String? subject;
    final String? courseCode;
    final InstitudesDetails? institudesDetails;
    final String? remarks;
    final String? board;
    final Batches? batches;
    final int? noOfBatches;
    final String? address;
    final String? tuitionName;
    final bool? alreadyExits;
    final int? availableSlots;
    final TuteeInformation? tuteeInformation;
    final String? className;

    factory Data1.fromJson(Map<String, dynamic> json){ 
        return Data1(
            tutorId: json["TutorId"],
            tutorDetails: json["TutorDetails"] == null ? null : TutorDetails.fromJson(json["TutorDetails"]),
            courseId: json["courseId"],
            subject: json["subject"],
            courseCode: json["course_code"],
            institudesDetails: json["institudesDetails"] == null ? null : InstitudesDetails.fromJson(json["institudesDetails"]),
            remarks: json["remarks"],
            board: json["board"],
            batches: json["batches"] == null ? null : Batches.fromJson(json["batches"]),
            noOfBatches: json["No_of_batches"],
            address: json["address"],
            tuitionName: json["tuitionName"],
            alreadyExits: json["alreadyExits"],
            availableSlots: json["availableSlots"],
           tuteeInformation: json["tuteeInformation"] == null ? null : TuteeInformation.fromJson(json["tuteeInformation"]),
           className: json["class_name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "TutorId": tutorId,
        "TutorDetails": tutorDetails?.toJson(),
        "courseId": courseId,
        "subject": subject,
        "course_code": courseCode,
        "institudesDetails": institudesDetails?.toJson(),
        "remarks": remarks,
        "board": board,
        "batches": batches?.toJson(),
        "No_of_batches": noOfBatches,
        "address": address,
        "tuitionName": tuitionName,
        "alreadyExits": alreadyExits,
        "availableSlots": availableSlots,
       "tuteeInformation": tuteeInformation,
        "class_name": className,
    };

}

class Batches {
    Batches({
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
    });

    final String? id;
    final String? batchShortName;
    final String? batchName;
    final dynamic branchName;
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

    factory Batches.fromJson(Map<String, dynamic> json){ 
        return Batches(
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
        batchDays: json["batch_days"] == null
    ? []
    : (json["batch_days"] is String
        ? json["batch_days"].split(', ') // Handle string case
        : List<String>.from(json["batch_days"])), // Handle list case
 batchMode: json["batch_mode"],
            fees: json["fees"],
            month: json["month"],
           startDate: json['start_date'],
    endDate :json['end_date'],
            userId: json["userId"],
            institudeName: json["institude_name"],
            institudeId: json["institudeId"],
            batchCode: json["batch_code"],
            isActive: json["is_active"],
            isDelete: json["is_delete"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "batch_short_name": batchShortName,
        "batch_name": batchName,
        "branch_name": branchName,
        "batch_teacher": batchTeacher,
        "batch_maximum_slots": batchMaximumSlots,
        "teacherId": teacherId,
        "batch_timing_start": batchTimingStart,
        "batch_timing_end": batchTimingEnd,
        "batch_timing_start_minutes": batchTimingStartMinutes,
        "batch_timing_end_minutes": batchTimingEndMinutes,
        "batch_days": batchDays.map((x) => x).toList(),
        "batch_mode": batchMode,
        "fees": fees,
        "month": month,
        "start_date": "${startDate!.toString()}}",
        "end_date": "${endDate!.toString()}}",
        "userId": userId,
        "institude_name": institudeName,
        "institudeId": institudeId,
        "batch_code": batchCode,
        "is_active": isActive,
        "is_delete": isDelete,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
    };

}

class InstitudesDetails {
    InstitudesDetails({
        required this.id,
        required this.institudeName,
        required this.registerNo,
        required this.address,
        required this.branchShortName,
        required this.doorNo,
        required this.pincode,
        required this.street,
        required this.country,
        required this.location,
        required this.city,
        required this.state,
        required this.landmark,
        required this.institudeFilename,
        required this.institudeUrl,
        required this.userId,
        required this.qrCode,
        required this.status,
        required this.isActive,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? institudeName;
    final String? registerNo;
    final String? address;
    final String? branchShortName;
    final String? doorNo;
    final String? pincode;
    final String? street;
    final String? country;
    final Location? location;
    final String? city;
    final String? state;
    final String? landmark;
    final String? institudeFilename;
    final String? institudeUrl;
    final String? userId;
    final String? qrCode;
    final String? status;
    final int? isActive;
    final int? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory InstitudesDetails.fromJson(Map<String, dynamic> json){ 
        return InstitudesDetails(
            id: json["_id"],
            institudeName: json["institude_name"],
            registerNo: json["register_no"],
            address: json["address"],
            branchShortName: json["branch_short_name"],
            doorNo: json["door_no"],
            pincode: json["pincode"],
            street: json["street"],
            country: json["country"],
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            city: json["city"],
            state: json["state"],
            landmark: json["landmark"],
            institudeFilename: json["institude_filename"],
            institudeUrl: json["institude_url"],
            userId: json["userId"],
            qrCode: json["qr_code"],
            status: json["status"],
            isActive: json["is_active"],
            isDeleted: json["is_deleted"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "institude_name": institudeName,
        "register_no": registerNo,
        "address": address,
        "branch_short_name": branchShortName,
        "door_no": doorNo,
        "pincode": pincode,
        "street": street,
        "country": country,
        "location": location?.toJson(),
        "city": city,
        "state": state,
        "landmark": landmark,
        "institude_filename": institudeFilename,
        "institude_url": institudeUrl,
        "userId": userId,
        "qr_code": qrCode,
        "status": status,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
    };

}

class Location {
    Location({
        required this.type,
        required this.coordinates,
    });

    final String? type;
    final List<double> coordinates;

    factory Location.fromJson(Map<String, dynamic> json){ 
        return Location(
            type: json["type"],
            coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates.map((x) => x).toList(),
    };

}

class TutorDetails {
    TutorDetails({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.wowId,
        required this.regNo,
        required this.email,
        required this.phoneNumber,
        required this.pincode,
        required this.userType,
        required this.otp,
        required this.accountVerificationToken,
        required this.accountVerified,
        required this.accountSetup,
        required this.doorNo,
        required this.street,
        required this.city,
        required this.state,
        required this.country,
        required this.countryCode,
        required this.idProof,
        required this.idProofLabel,
        required this.idProofFilename,
        required this.idProofUrl,
        required this.profileFilename,
        required this.profileUrl,
        required this.rolesId,
        required this.rolesTypeId,
        required this.latitude,
        required this.longitude,
        required this.location,
        required this.institudeBranchId,
        required this.institudeId,
        required this.fcmToken,
        required this.qrCodeUrl,
        required this.isActive,
        required this.isDeleted,
        required this.createdAt,
        required this.v,
        required this.token,
    });

    final String? id;
    final String? firstName;
    final String? lastName;
    final String? wowId;
    final String? regNo;
    final String? email;
    final String? phoneNumber;
    final int? pincode;
    final int? userType;
    final dynamic otp;
    final dynamic accountVerificationToken;
    final bool? accountVerified;
    final bool? accountSetup;
    final String? doorNo;
    final String? street;
    final String? city;
    final String? state;
    final String? country;
    final String? countryCode;
    final String? idProof;
    final String? idProofLabel;
    final String? idProofFilename;
    final String? idProofUrl;
    final String? profileFilename;
    final String? profileUrl;
    final String? rolesId;
    final String? rolesTypeId;
    final dynamic latitude;
    final dynamic longitude;
    final Location? location;
    final String? institudeBranchId;
    final String? institudeId;
    final String? fcmToken;
    final String? qrCodeUrl;
    final int? isActive;
    final int? isDeleted;
    final DateTime? createdAt;
    final int? v;
    final String? token;

    factory TutorDetails.fromJson(Map<String, dynamic> json){ 
        return TutorDetails(
            id: json["_id"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            wowId: json["wow_id"],
            regNo: json["reg_no"],
            email: json["email"],
            phoneNumber: json["phone_number"],
            pincode: json["pincode"],
            userType: json["user_type"],
            otp: json["otp"],
            accountVerificationToken: json["account_verification_token"],
            accountVerified: json["account_verified"],
            accountSetup: json["account_setup"],
            doorNo: json["door_no"],
            street: json["street"],
            city: json["city"],
            state: json["state"],
            country: json["country"],
            countryCode: json["country_code"],
            idProof: json["id_proof"],
            idProofLabel: json["id_proof_label"],
            idProofFilename: json["id_proof_filename"],
            idProofUrl: json["id_proof_url"],
            profileFilename: json["profile_filename"],
            profileUrl: json["profile_url"],
            rolesId: json["rolesId"],
            rolesTypeId: json["rolesTypeId"],
            latitude: json["latitude"],
            longitude: json["longitude"],
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            institudeBranchId: json["institude_branch_Id"],
            institudeId: json["institudeId"],
            fcmToken: json["fcm_token"],
            qrCodeUrl: json["qr_code_url"],
            isActive: json["is_active"],
            isDeleted: json["is_deleted"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            v: json["__v"],
            token: json["token"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "wow_id": wowId,
        "reg_no": regNo,
        "email": email,
        "phone_number": phoneNumber,
        "pincode": pincode,
        "user_type": userType,
        "otp": otp,
        "account_verification_token": accountVerificationToken,
        "account_verified": accountVerified,
        "account_setup": accountSetup,
        "door_no": doorNo,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "country_code": countryCode,
        "id_proof": idProof,
        "id_proof_label": idProofLabel,
        "id_proof_filename": idProofFilename,
        "id_proof_url": idProofUrl,
        "profile_filename": profileFilename,
        "profile_url": profileUrl,
        "rolesId": rolesId,
        "rolesTypeId": rolesTypeId,
        "latitude": latitude,
        "longitude": longitude,
        "location": location?.toJson(),
        "institude_branch_Id": institudeBranchId,
        "institudeId": institudeId,
        "fcm_token": fcmToken,
        "qr_code_url": qrCodeUrl,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "__v": v,
        "token": token,
    };

}

class TuteeInformation {
    TuteeInformation({
        required this.id,
        required this.email,
        required this.phoneNumber,
    });

    final String? id;
    final String? email;
    final String? phoneNumber;

    factory TuteeInformation.fromJson(Map<String, dynamic> json){ 
        return TuteeInformation(
            id: json["_id"],
            email: json["email"],
            phoneNumber: json["phone_number"],
        );
    }

}
