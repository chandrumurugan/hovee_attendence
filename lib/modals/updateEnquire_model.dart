class UpdateEnquiryStatusModel {
  int? statusCode;
  String? message;
  Enquiry? enquiry;

  UpdateEnquiryStatusModel({this.statusCode, this.message, this.enquiry});

  UpdateEnquiryStatusModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    enquiry =
        json['enquiry'] != null ? new Enquiry.fromJson(json['enquiry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.enquiry != null) {
      data['enquiry'] = this.enquiry!.toJson();
    }
    return data;
  }
}

class Enquiry {
  String? sId;
  String? courseId;
  String? studentId;
  String? tutorId;
  String? enquiryMessage;
  String? enquiryType;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Enquiry(
      {this.sId,
      this.courseId,
      this.studentId,
      this.tutorId,
      this.enquiryMessage,
      this.enquiryType,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Enquiry.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseId = json['courseId'];
    studentId = json['studentId'];
    tutorId = json['tutorId'];
    enquiryMessage = json['enquiry_message'];
    enquiryType = json['enquiryType'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['courseId'] = this.courseId;
    data['studentId'] = this.studentId;
    data['tutorId'] = this.tutorId;
    data['enquiry_message'] = this.enquiryMessage;
    data['enquiryType'] = this.enquiryType;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}