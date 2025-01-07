// class getTuitionCourseListModel {
//   int? statusCode;
//   String? message;
//   List<TutionData>? data;

//   getTuitionCourseListModel({this.statusCode, this.message, this.data});

//   getTuitionCourseListModel.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <TutionData>[];
//       json['data'].forEach((v) {
//         data!.add(new TutionData.fromJson(v));
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

// class TutionData {
//   String? sId;
//   String? board;
//   String? className;
//   String? subject;
//   String? courseCode;
//   String? courseId;
//   String? batchId;
//   String? batchName;
//   String? batchMaximumSlots;
//   String? batchTimingStart;
//   String? batchTimingEnd;
//   List<String>? batchDays; // Changed to List<String>
//   String? batchMode;
//   String? fees;
  // String? startDate;
  // String? endDate;
  // String? status;

//   TutionData({
//     this.sId,
//     this.board,
//     this.className,
//     this.subject,
//     this.courseCode,
//     this.courseId,
//     this.batchId,
//     this.batchName,
//     this.batchMaximumSlots,
//     this.batchTimingStart,
//     this.batchTimingEnd,
//     this.batchDays,
//     this.batchMode,
//     this.fees,
//     this.startDate,
//     this.endDate,
//     this.status,
//   });

//   TutionData.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     board = json['board'];
//     className = json['class_name'];
//     subject = json['subject'];
//     courseCode = json['course_code'];
//     courseId = json['courseId'];
//     batchId = json['batchId'];
//     batchName = json['batch_name'];
//     batchMaximumSlots = json['batch_maximum_slots'];
//     batchTimingStart = json['batch_timing_start'];
//     batchTimingEnd = json['batch_timing_end'];

    // // Handling String or List for batch_days
    // if (json['batch_days'] != null) {
    //   if (json['batch_days'] is String) {
    //     batchDays = [json['batch_days']]; // Convert String to List
    //   } else if (json['batch_days'] is List) {
    //     batchDays = List<String>.from(json['batch_days']); // Convert List<dynamic> to List<String>
    //   }
    // }

//     batchMode = json['batch_mode'];
//     fees = json['fees'];
    // startDate = json['start_date'];
    // endDate = json['end_date'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = this.sId;
//     data['board'] = this.board;
//     data['class_name'] = this.className;
//     data['subject'] = this.subject;
//     data['course_code'] = this.courseCode;
//     data['courseId'] = this.courseId;
//     data['batchId'] = this.batchId;
//     data['batch_name'] = this.batchName;
//     data['batch_maximum_slots'] = this.batchMaximumSlots;
//     data['batch_timing_start'] = this.batchTimingStart;
//     data['batch_timing_end'] = this.batchTimingEnd;

    // // Convert List<String> to JSON
    // if (this.batchDays != null) {
    //   data['batch_days'] = this.batchDays;
    // }

//     data['batch_mode'] = this.batchMode;
//     data['fees'] = this.fees;
    // data['start_date'] = this.startDate;
    // data['end_date'] = this.endDate;
//     data['status'] = this.status;
//     return data;
//   }
// }


class getTuitionCourseListModel {
  int? statusCode;
  bool? success;
  List<TutionData>? data;
  Pagination? pagination;
  Counts? counts;

  getTuitionCourseListModel(
      {this.statusCode, this.success, this.data, this.pagination, this.counts});

  getTuitionCourseListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    if (json['data'] != null) {
      data = <TutionData>[];
      json['data'].forEach((v) {
        data!.add(new TutionData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    counts =
        json['counts'] != null ? new Counts.fromJson(json['counts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.counts != null) {
      data['counts'] = this.counts!.toJson();
    }
    return data;
  }
}

class TutionData {
  String? sId;
  String? status;
  String? createdAt;
  bool? hasRating;
  String? batchName;
  String? board;
  String? subject;
  String? courseCode;
  String? batchId;
  String? courseId;
  String? batchMode;
  String? fees;
  List<String>? batchDays;
  String? batchStartDate;
  String? batchEndDate;
  String? batchTimingStart;
  String? batchTimingEnd;
  String? tutorName;
  String? className;
    String? startDate;
  String? endDate;
   String? batchMaximumSlots;

  TutionData(
      {this.sId,
      this.status,
      this.createdAt,
      this.hasRating,
      this.batchName,
      this.board,
      this.subject,
      this.courseCode,
      this.batchId,
      this.courseId,
      this.batchMode,
      this.fees,
      this.batchDays,
      this.batchStartDate,
      this.batchEndDate,
      this.batchTimingStart,
      this.batchTimingEnd,
      this.tutorName,
      this.className,
      this.startDate,
      this.endDate,
      this.batchMaximumSlots});

  TutionData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    createdAt = json['created_at'];
    hasRating = json['hasRating'];
    batchName = json['batch_name'];
    board = json['board'];
    subject = json['subject'];
    courseCode = json['course_code'];
    batchId = json['batchId'];
    courseId = json['courseId'];
    batchMode = json['batch_mode'];
    fees = json['fees'];
    
    // Handling String or List for batch_days
    if (json['batch_days'] != null) {
      if (json['batch_days'] is String) {
        batchDays = [json['batch_days']]; // Convert String to List
      } else if (json['batch_days'] is List) {
        batchDays = List<String>.from(json['batch_days']); // Convert List<dynamic> to List<String>
      }
    }
    batchStartDate = json['batch_start_date'];
    batchEndDate = json['batch_end_date'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
    tutorName = json['tutor_name'];
    className = json['class_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
     batchMaximumSlots = json['batch_maximum_slots'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['hasRating'] = this.hasRating;
    data['batch_name'] = this.batchName;
    data['board'] = this.board;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    data['batchId'] = this.batchId;
    data['courseId'] = this.courseId;
    data['batch_mode'] = this.batchMode;
    data['fees'] = this.fees;
        // Convert List<String> to JSON
    if (this.batchDays != null) {
      data['batch_days'] = this.batchDays;
    }

    data['batch_start_date'] = this.batchStartDate;
    data['batch_end_date'] = this.batchEndDate;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    data['tutor_name'] = this.tutorName;
    data['class_name'] = this.className;
        data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
     data['batch_maximum_slots'] = this.batchMaximumSlots;
    return data;
  }
}

class Pagination {
  int? totalItems;
  int? currentPage;
  int? totalPages;

  Pagination({this.totalItems, this.currentPage, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Counts {
  int? draft;
  int? public;

  Counts({this.draft, this.public});

  Counts.fromJson(Map<String, dynamic> json) {
    draft = json['Draft'];
    public = json['Public'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Draft'] = this.draft;
    data['Public'] = this.public;
    return data;
  }
}