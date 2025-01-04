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
        required this.className,
        required this.subject,
        required this.courseCode,
        required this.remarks,
        required this.board,
        required this.batchList,
        required this.batchGroupList,
        required this.workingDays,
        required this.noOfBatches,
        required this.address,
        required this.tuitionName,
        required this.alreadyExits,
        required this.tuteeInformation,
    });

    final String? tutorId;
    final TutorDetails? tutorDetails;
    final String? courseId;
    final String? className;
    final String? subject;
    final String? courseCode;
    final String? remarks;
    final String? board;
    final List<String> batchList;
    final List<BatchGroupList> batchGroupList;
    final List<String> workingDays;
    final int? noOfBatches;
    final String? address;
    final String? tuitionName;
    final bool? alreadyExits;
    final TuteeInformation? tuteeInformation;

    factory Data1.fromJson(Map<String, dynamic> json){ 
        return Data1(
            tutorId: json["TutorId"],
            tutorDetails: json["TutorDetails"] == null ? null : TutorDetails.fromJson(json["TutorDetails"]),
            courseId: json["courseId"],
            className: json["class_name"],
            subject: json["subject"],
            courseCode: json["course_code"],
            remarks: json["remarks"],
            board: json["board"],
            batchList: json["batchList"] == null ? [] : List<String>.from(json["batchList"]!.map((x) => x)),
            batchGroupList: json["batchGroupList"] == null ? [] : List<BatchGroupList>.from(json["batchGroupList"]!.map((x) => BatchGroupList.fromJson(x))),
          workingDays: json["working_days"] == null
    ? []
    : List<String>.from(json["working_days"]!.map((x) => x.toString())),

            noOfBatches: json["No_of_batches"],
            address: json["address"],
            tuitionName: json["tuitionName"],
            alreadyExits: json["alreadyExits"],
            tuteeInformation: json["tuteeInformation"] == null ? null : TuteeInformation.fromJson(json["tuteeInformation"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "TutorId": tutorId,
        "TutorDetails": tutorDetails?.toJson(),
        "courseId": courseId,
        "class_name": className,
        "subject": subject,
        "course_code": courseCode,
        "remarks": remarks,
        "board": board,
        "batchList": batchList.map((x) => x).toList(),
        "batchGroupList": batchGroupList.map((x) => x?.toJson()).toList(),
        "working_days": workingDays.map((x) => x).toList(),
        "No_of_batches": noOfBatches,
        "address": address,
        "tuitionName": tuitionName,
        "alreadyExits": alreadyExits,
        "tuteeInformation": tuteeInformation?.toJson(),
    };

}

class BatchGroupList {
    BatchGroupList({
        required this.batchName,
        required this.batchMode,
        required this.startDate,
        required this.endDate,
        required this.batchId,
        required this.batchTiming,
        required this.availableSlots,
        required this.isAvailable,
    });

    final String? batchName;
    final String? batchMode;
    final String? startDate;
    final String? endDate;
    final String? batchId;
    final String? batchTiming;
    final int? availableSlots;
    final bool? isAvailable;

    factory BatchGroupList.fromJson(Map<String, dynamic> json){ 
        return BatchGroupList(
            batchName: json["batch_name"],
            batchMode: json["batch_mode"],
            startDate: json["start_date"],
            endDate: json["end_date"],
            batchId: json["batchId"],
            batchTiming: json["batch_timing"],
            availableSlots: json["availableSlots"],
            isAvailable: json["isAvailable"],
        );
    }

    Map<String, dynamic> toJson() => {
        "batch_name": batchName,
        "batch_mode": batchMode,
        "start_date": startDate,
        "end_date": endDate,
        "batchId": batchId,
        "batch_timing": batchTiming,
        "availableSlots": availableSlots,
        "isAvailable": isAvailable,
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

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "phone_number": phoneNumber,
    };

}

class TutorDetails {
    TutorDetails({
        required this.id,
        required this.email,
        required this.phoneNumber,
        required this.pincode,
        required this.doorNo,
        required this.street,
        required this.city,
        required this.state,
        required this.country,
    });

    final String? id;
    final String? email;
    final String? phoneNumber;
    final int? pincode;
    final String? doorNo;
    final String? street;
    final String? city;
    final String? state;
    final String? country;

    factory TutorDetails.fromJson(Map<String, dynamic> json){ 
        return TutorDetails(
            id: json["_id"],
            email: json["email"],
            phoneNumber: json["phone_number"],
            pincode: json["pincode"],
            doorNo: json["door_no"],
            street: json["street"],
            city: json["city"],
            state: json["state"],
            country: json["country"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "phone_number": phoneNumber,
        "pincode": pincode,
        "door_no": doorNo,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
    };

}
