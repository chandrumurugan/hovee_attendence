class getClassTuteeByIdModel {
  int? statusCode;
  String? message;
  Data1? data;

  getClassTuteeByIdModel({this.statusCode, this.message, this.data});

  getClassTuteeByIdModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data1.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data1 {
  String? tutorId;
  TutorDetails? tutorDetails;
  String? courseId;
  String? className;
  String? subject;
  String? courseCode;
  String? remarks;
  String? board;
  List<String>? batchList;
  List<BatchGroupList>? batchGroupList;
  List<String>? workingDays;
  int? noOfBatches;
  String? address;
  bool? alreadyExits;

  Data1(
      {this.tutorId,
      this.tutorDetails,
      this.courseId,
      this.className,
      this.subject,
      this.courseCode,
      this.remarks,
      this.board,
      this.batchList,
      this.batchGroupList,
      this.workingDays,
      this.noOfBatches,
      this.address,
      this.alreadyExits});

  Data1.fromJson(Map<String, dynamic> json) {
    tutorId = json['TutorId'];
    tutorDetails = json['TutorDetails'] != null
        ? new TutorDetails.fromJson(json['TutorDetails'])
        : null;
    courseId = json['courseId'];
    className = json['class_name'];
    subject = json['subject'];
    courseCode = json['course_code'];
    remarks = json['remarks'];
    board = json['board'];
    batchList = json['batchList'].cast<String>();
    if (json['batchGroupList'] != null) {
      batchGroupList = <BatchGroupList>[];
      json['batchGroupList'].forEach((v) {
        batchGroupList!.add(new BatchGroupList.fromJson(v));
      });
    }
    workingDays = json['working_days'].cast<String>();
    noOfBatches = json['No_of_batches'];
    address = json['address'];
    alreadyExits = json['alreadyExits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TutorId'] = this.tutorId;
    if (this.tutorDetails != null) {
      data['TutorDetails'] = this.tutorDetails!.toJson();
    }
    data['courseId'] = this.courseId;
    data['class_name'] = this.className;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    data['remarks'] = this.remarks;
    data['board'] = this.board;
    data['batchList'] = this.batchList;
    if (this.batchGroupList != null) {
      data['batchGroupList'] =
          this.batchGroupList!.map((v) => v.toJson()).toList();
    }
    data['working_days'] = this.workingDays;
    data['No_of_batches'] = this.noOfBatches;
    data['address'] = this.address;
    data['alreadyExits'] = this.alreadyExits;
    return data;
  }
}

class TutorDetails {
  String? sId;
  int? pincode;
  String? doorNo;
  String? street;
  String? city;
  String? state;
  String? country;

  TutorDetails(
      {this.sId,
      this.pincode,
      this.doorNo,
      this.street,
      this.city,
      this.state,
      this.country});

  TutorDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    pincode = json['pincode'];
    doorNo = json['door_no'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['pincode'] = this.pincode;
    data['door_no'] = this.doorNo;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}

class BatchGroupList {
  String? batchName;
  String? batchMode;
  String? startDate;
  String? endDate;
  String? batchId;
  String? batchTiming;
  int? availableSlots;
  bool? isAvailable;

  BatchGroupList(
      {this.batchName,
      this.batchMode,
      this.startDate,
      this.endDate,
      this.batchId,
      this.batchTiming,
      this.availableSlots,
      this.isAvailable});

  BatchGroupList.fromJson(Map<String, dynamic> json) {
    batchName = json['batch_name'];
    batchMode = json['batch_mode'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    batchId = json['batchId'];
    batchTiming = json['batch_timing'];
    availableSlots = json['availableSlots'];
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_name'] = this.batchName;
    data['batch_mode'] = this.batchMode;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['batchId'] = this.batchId;
    data['batch_timing'] = this.batchTiming;
    data['availableSlots'] = this.availableSlots;
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}