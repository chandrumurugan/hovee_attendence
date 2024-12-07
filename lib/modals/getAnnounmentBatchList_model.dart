class getAnnouncementBatchListModel {
  int? statusCode;
  List<BatchData>? data;

  getAnnouncementBatchListModel({this.statusCode, this.data});

  getAnnouncementBatchListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <BatchData>[];
      json['data'].forEach((v) {
        data!.add(new BatchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BatchData {
  String? sId;
  String? className;
  String? subject;
  String? courseCode;
  List<BatchList>? batchList;

  BatchData(
      {this.sId,
      this.className,
      this.subject,
      this.courseCode,
      this.batchList});

  BatchData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    className = json['class_name'];
    subject = json['subject'];
    courseCode = json['course_code'];
    if (json['batchList'] != null) {
      batchList = <BatchList>[];
      json['batchList'].forEach((v) {
        batchList!.add(new BatchList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['class_name'] = this.className;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    if (this.batchList != null) {
      data['batchList'] = this.batchList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BatchList {
  String? sId;
  String? batchName;
  String? batchTeacher;
  List<UserList>? userList;

  BatchList({this.sId, this.batchName, this.batchTeacher, this.userList});

  BatchList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    batchTeacher = json['batch_teacher'];
    if (json['userList'] != null) {
      userList = <UserList>[];
      json['userList'].forEach((v) {
        userList!.add(new UserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['batch_name'] = this.batchName;
    data['batch_teacher'] = this.batchTeacher;
    if (this.userList != null) {
      data['userList'] = this.userList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserList {
  String? studentId;
  String? studentFirstName;
  String? studentLastName;

  UserList({this.studentId, this.studentFirstName, this.studentLastName});

  UserList.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    studentFirstName = json['student_first_name'];
    studentLastName = json['student_last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['student_first_name'] = this.studentFirstName;
    data['student_last_name'] = this.studentLastName;
    return data;
  }
}