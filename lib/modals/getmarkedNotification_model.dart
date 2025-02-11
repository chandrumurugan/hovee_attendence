class getMarkNotificationAsReadModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  getMarkNotificationAsReadModel(
      {this.statusCode, this.success, this.message, this.data});

  getMarkNotificationAsReadModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? userId;
  String? role;
  String? type;
  String? head;
  String? message;
  String? redirectTo;
  bool? isRead;
  String? createdAt;
  int? iV;
  String? batchId;
  String? tabType;

  Data(
      {this.sId,
      this.userId,
      this.role,
      this.type,
      this.head,
      this.message,
      this.redirectTo,
      this.isRead,
      this.createdAt,
      this.iV,
      this.batchId,
      this.tabType,});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    role = json['role'];
    type = json['type'];
    head = json['head'];
    message = json['message'];
    redirectTo = json['redirectTo'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
    iV = json['__v'];
     batchId = json['batchId'];
    tabType = json['tab_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['role'] = this.role;
    data['type'] = this.type;
    data['head'] = this.head;
    data['message'] = this.message;
    data['redirectTo'] = this.redirectTo;
    data['isRead'] = this.isRead;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['batchId'] = this.batchId;
    data['tab_type'] = this.tabType;
    return data;
  }
}