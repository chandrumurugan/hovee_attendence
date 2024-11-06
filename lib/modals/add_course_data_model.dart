class AddCourseDataModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  AddCourseDataModel({this.statusCode, this.success, this.message, this.data});

  AddCourseDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? batchName;
  String? categories;
  String? board;
  String? className;
  String? subject;
  String? courseCode;
  String? remarks;
  String? batchId;
  String? userId;
  Null? courseFilename;
  Null? courseUrl;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.batchName,
      this.categories,
      this.board,
      this.className,
      this.subject,
      this.courseCode,
      this.remarks,
      this.batchId,
      this.userId,
      this.courseFilename,
      this.courseUrl,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    batchName = json['batch_name'];
    categories = json['categories'];
    board = json['board'];
    className = json['class_name'];
    subject = json['subject'];
    courseCode = json['course_code'];
    remarks = json['remarks'];
    batchId = json['batchId'];
    userId = json['userId'];
    courseFilename = json['course_filename'];
    courseUrl = json['course_url'];
    sId = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_name'] = this.batchName;
    data['categories'] = this.categories;
    data['board'] = this.board;
    data['class_name'] = this.className;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    data['remarks'] = this.remarks;
    data['batchId'] = this.batchId;
    data['userId'] = this.userId;
    data['course_filename'] = this.courseFilename;
    data['course_url'] = this.courseUrl;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}