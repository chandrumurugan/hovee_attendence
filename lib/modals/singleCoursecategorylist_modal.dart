class SingleCourseCategoryList {
  int? statusCode;
  String? message;
  List<Data>? data;

  SingleCourseCategoryList({this.statusCode, this.message, this.data});

  SingleCourseCategoryList.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? fees;
  String? courseCode;
  String? batchName;
  String? batchMaximumSlots;
  String? batchTimingStart;
  String? batchTimingEnd;
  String? batchMode;
  String? courseId;
  String? createdAt;
  Null? distance;
  String? tutorName;
  TutorLocation? tutorLocation;
  String? tutorAddress;
  String? className;
  String? subject;
  String? tutorId;
  Ratings? ratings;
  Data(
      {this.fees,
      this.courseCode,
      this.batchName,
      this.batchMaximumSlots,
      this.batchTimingStart,
      this.batchTimingEnd,
      this.batchMode,
      this.courseId,
      this.createdAt,
      this.distance,
      this.tutorName,
      this.tutorLocation,
      this.tutorAddress,
      this.className,
      this.subject,
      this.tutorId,
      this.ratings,});

  Data.fromJson(Map<String, dynamic> json) {
    fees = json['fees'];
    courseCode = json['course_code'];
    batchName = json['batch_name'];
    batchMaximumSlots = json['batch_maximum_slots'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
    batchMode = json['batch_mode'];
    courseId = json['courseId'];
    createdAt = json['created_at'];
    distance = json['distance'];
    tutorName = json['tutor_name'];
    tutorLocation = json['tutor_location'] != null
        ? new TutorLocation.fromJson(json['tutor_location'])
        : null;
    tutorAddress = json['tutor_address'];
    className = json['className'];
    subject = json['subject'];
    tutorId = json['TutorId'];
    ratings =
        json['ratings'] != null ? new Ratings.fromJson(json['ratings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fees'] = this.fees;
    data['course_code'] = this.courseCode;
    data['batch_name'] = this.batchName;
    data['batch_maximum_slots'] = this.batchMaximumSlots;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    data['batch_mode'] = this.batchMode;
    data['courseId'] = this.courseId;
    data['created_at'] = this.createdAt;
    data['distance'] = this.distance;
    data['tutor_name'] = this.tutorName;
    if (this.tutorLocation != null) {
      data['tutor_location'] = this.tutorLocation!.toJson();
    }
    data['tutor_address'] = this.tutorAddress;
    data['className'] = this.className;
    data['subject'] = this.subject;
    data['TutorId'] = this.tutorId;
     if (this.ratings != null) {
      data['ratings'] = this.ratings!.toJson();
    }
    return data;
  }
}

class TutorLocation {
  String? type;
  List<double>? coordinates;

  TutorLocation({this.type, this.coordinates});

  TutorLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Ratings {
  String? nId;
  int? averageRating;
  int? totalRatings;

  Ratings({this.nId, this.averageRating, this.totalRatings});

  Ratings.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    
    // Convert double to int if needed
    averageRating = (json['averageRating'] is double) 
        ? (json['averageRating'] as double).toInt() 
        : json['averageRating'];

    totalRatings = (json['totalRatings'] is double) 
        ? (json['totalRatings'] as double).toInt() 
        : json['totalRatings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = nId;
    data['averageRating'] = averageRating;
    data['totalRatings'] = totalRatings;
    return data;
  }
}
