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
  String? courseId;
  String? className;
  String? subject;
  String? courseCode;
  String? remarks;
  String? board;
  List<String>? batchList;
  List<String>? workingDays;
  int? noOfBatches;
  String? address;

  Data1(
      {this.tutorId,
      this.courseId,
      this.className,
      this.subject,
      this.courseCode,
      this.remarks,
      this.board,
      this.batchList,
      this.workingDays,
      this.noOfBatches,
      this.address});

  Data1.fromJson(Map<String, dynamic> json) {
    tutorId = json['TutorId'];
    courseId = json['courseId'];
    className = json['class_name'];
    subject = json['subject'];
    courseCode = json['course_code'];
    remarks = json['remarks'];
    board = json['board'];
    batchList = json['batchList'].cast<String>();
    workingDays = json['working_days'].cast<String>();
    noOfBatches = json['No_of_batches'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TutorId'] = this.tutorId;
    data['courseId'] = this.courseId;
    data['class_name'] = this.className;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    data['remarks'] = this.remarks;
    data['board'] = this.board;
    data['batchList'] = this.batchList;
    data['working_days'] = this.workingDays;
    data['No_of_batches'] = this.noOfBatches;
    data['address'] = this.address;
    return data;
  }
}