class getTuitionCourseListModel {
  int? statusCode;
  String? message;
  List<TutionData>? data;

  getTuitionCourseListModel({this.statusCode, this.message, this.data});

  getTuitionCourseListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TutionData>[];
      json['data'].forEach((v) {
        data!.add(new TutionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TutionData {
  String? sId;
  String? courseCode;
  String? courseId;
  String? batchId;
  String? batchName;
   String? board;
   String? subject;
  String? status;


  TutionData(
      {this.sId, this.courseCode, this.courseId, this.batchId, this.batchName,this.board,this.status,this.subject});

  TutionData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseCode = json['course_code'];
    courseId = json['courseId'];
    batchId = json['batchId'];
    batchName = json['batch_name'];
    board = json['board'];
    subject = json['subject'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['course_code'] = this.courseCode;
    data['courseId'] = this.courseId;
    data['batchId'] = this.batchId;
    data['batch_name'] = this.batchName;
      data['board'] = this.board;
        data['subject'] = this.subject;
          data['status'] = this.status;
    return data;
  }
}