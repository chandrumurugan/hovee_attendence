class GetRatingDashboardListModel {
  int? statusCode;
  DasRatingData? data;

  GetRatingDashboardListModel({this.statusCode, this.data});

  GetRatingDashboardListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new DasRatingData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DasRatingData {
  String? sId;
  String? firstName;
  String? lastName;
  String? wowId;
  String? email;
  String? dob;
  String? phoneNumber;
  String? doorNo;
  String? street;
  String? city;
  String? state;
  String? country;
  Ratings? ratings;

  DasRatingData(
      {this.sId,
      this.firstName,
      this.lastName,
      this.wowId,
      this.email,
      this.dob,
      this.phoneNumber,
      this.doorNo,
      this.street,
      this.city,
      this.state,
      this.country,
      this.ratings});

  DasRatingData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    wowId = json['wow_id'];
    email = json['email'];
    dob = json['dob'];
    phoneNumber = json['phone_number'];
    doorNo = json['door_no'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    ratings =
        json['ratings'] != null ? new Ratings.fromJson(json['ratings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['wow_id'] = this.wowId;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['phone_number'] = this.phoneNumber;
    data['door_no'] = this.doorNo;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.toJson();
    }
    return data;
  }
}

class Ratings {
  String? averageRating;
  int? totalRatings;
  List<BestReviews>? bestReviews;
  List<CourseDetails>? courseDetails;

  Ratings(
      {this.averageRating,
      this.totalRatings,
      this.bestReviews,
      this.courseDetails});

  Ratings.fromJson(Map<String, dynamic> json) {
    averageRating = json['averageRating'];
    totalRatings = json['totalRatings'];
    if (json['bestReviews'] != null) {
      bestReviews = <BestReviews>[];
      json['bestReviews'].forEach((v) {
        bestReviews!.add(new BestReviews.fromJson(v));
      });
    }
    if (json['courseDetails'] != null) {
      courseDetails = <CourseDetails>[];
      json['courseDetails'].forEach((v) {
        courseDetails!.add(new CourseDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['averageRating'] = this.averageRating;
    data['totalRatings'] = this.totalRatings;
    if (this.bestReviews != null) {
      data['bestReviews'] = this.bestReviews!.map((v) => v.toJson()).toList();
    }
    if (this.courseDetails != null) {
      data['courseDetails'] =
          this.courseDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BestReviews {
  String? ratingPoints;
  List<String>? details;

  BestReviews({this.ratingPoints, this.details});

  BestReviews.fromJson(Map<String, dynamic> json) {
    ratingPoints = json['ratingPoints'];
    details = json['details'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ratingPoints'] = this.ratingPoints;
    data['details'] = this.details;
    return data;
  }
}

class CourseDetails {
  String? sId;
  String? batchName;
  String? board;
  String? className;
  String? subject;
  String? courseCode;
  String? remarks;
  String? batchId;
  String? userId;
  Null? courseFilename;
  Null? courseUrl;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CourseDetails(
      {this.sId,
      this.batchName,
      this.board,
      this.className,
      this.subject,
      this.courseCode,
      this.remarks,
      this.batchId,
      this.userId,
      this.courseFilename,
      this.courseUrl,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CourseDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    board = json['board'];
    className = json['class_name'];
    subject = json['subject'];
    courseCode = json['course_code'];
    remarks = json['remarks'];
    batchId = json['batchId'];
    userId = json['userId'];
    courseFilename = json['course_filename'];
    courseUrl = json['course_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['batch_name'] = this.batchName;
    data['board'] = this.board;
    data['class_name'] = this.className;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    data['remarks'] = this.remarks;
    data['batchId'] = this.batchId;
    data['userId'] = this.userId;
    data['course_filename'] = this.courseFilename;
    data['course_url'] = this.courseUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}