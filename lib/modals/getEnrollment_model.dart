// class getEnrollmentModel {
//   int? statusCode;
//   String? message;
//   List<Data>? data;

//   getEnrollmentModel({this.statusCode, this.message, this.data});

//   getEnrollmentModel.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   String? sId;
//   String? tutorId;
//   String? studentId;
//   String? courseId;
//   String? batchId;
//   String? rollNumber;
//   String? startDate;
//   String? endDate;
//   String? status;
//   String? entrollmentType;
//   String? createdAt;
//   int? iV;
//   String? tutorName;

//   Data(
//       {this.sId,
//       this.tutorId,
//       this.studentId,
//       this.courseId,
//       this.batchId,
//       this.rollNumber,
//       this.startDate,
//       this.endDate,
//       this.status,
//       this.entrollmentType,
//       this.createdAt,
//       this.iV,
//       this.tutorName});

//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     tutorId = json['tutorId'];
//     studentId = json['studentId'];
//     courseId = json['courseId'];
//     batchId = json['batchId'];
//     rollNumber = json['rollNumber'];
//     startDate = json['startDate'];
//     endDate = json['endDate'];
//     status = json['status'];
//     entrollmentType = json['entrollmentType'];
//     createdAt = json['createdAt'];
//     iV = json['__v'];
//     tutorName = json['tutorName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['tutorId'] = this.tutorId;
//     data['studentId'] = this.studentId;
//     data['courseId'] = this.courseId;
//     data['batchId'] = this.batchId;
//     data['rollNumber'] = this.rollNumber;
//     data['startDate'] = this.startDate;
//     data['endDate'] = this.endDate;
//     data['status'] = this.status;
//     data['entrollmentType'] = this.entrollmentType;
//     data['createdAt'] = this.createdAt;
//     data['__v'] = this.iV;
//     data['tutorName'] = this.tutorName;
//     return data;
//   }
// }

class GetEnrollmentModel {
    GetEnrollmentModel({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final int statusCode;
    final String message;
    final List<Datum> data;

    factory GetEnrollmentModel.fromJson(Map<String, dynamic> json){ 
        return GetEnrollmentModel(
            statusCode: json["statusCode"] ?? 0,
            message: json["message"] ?? "",
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.tutorId,
        required this.studentId,
        required this.courseId,
        required this.batchId,
        required this.rollNumber,
        required this.startDate,
        required this.endDate,
        required this.tutorName,
        required this.enquiryCode,
        required this.status,
        required this.entrollmentType,
        required this.createdAt,
        required this.v,
    });

    final String id;
    final Id? tutorId;
    final Id? studentId;
    final String courseId;
    final String batchId;
    final String rollNumber;
    final String startDate;
    final String endDate;
    final String tutorName;
    final String enquiryCode;
    final String status;
    final String entrollmentType;
    final DateTime? createdAt;
    final int v;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["_id"] ?? "",
            tutorId: json["tutorId"] == null ? null : Id.fromJson(json["tutorId"]),
            studentId: json["studentId"] == null ? null : Id.fromJson(json["studentId"]),
            courseId: json["courseId"] ?? "",
            batchId: json["batchId"] ?? "",
            rollNumber: json["rollNumber"] ?? "",
            startDate: json["startDate"] ?? "",
            endDate: json["endDate"] ?? "",
            tutorName: json["tutorName"] ?? "",
            enquiryCode: json["enquiryCode"] ?? "",
            status: json["status"] ?? "",
            entrollmentType: json["entrollmentType"] ?? "",
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            v: json["__v"] ?? 0,
        );
    }

}

class Id {
    Id({
        required this.id,
        required this.firstName,
        required this.lastName,
    });

    final String id;
    final String firstName;
    final String lastName;

    factory Id.fromJson(Map<String, dynamic> json){ 
        return Id(
            id: json["_id"] ?? "",
            firstName: json["first_name"] ?? "",
            lastName: json["last_name"] ?? "",
        );
    }

}
