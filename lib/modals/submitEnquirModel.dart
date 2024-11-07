class submitEnquiryModel {
  int? statusCode;
  String? message;
  String? enquiryId;

  submitEnquiryModel({this.statusCode, this.message, this.enquiryId});

  submitEnquiryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    enquiryId = json['enquiryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['enquiryId'] = this.enquiryId;
    return data;
  }
}