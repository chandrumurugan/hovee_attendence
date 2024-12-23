class GetRatingTutorListModel {
    GetRatingTutorListModel({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final int? statusCode;
    final String? message;
    final RatingsData? data;

    factory GetRatingTutorListModel.fromJson(Map<String, dynamic> json){ 
        return GetRatingTutorListModel(
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? null : RatingsData.fromJson(json["data"]),
        );
    }

}

class RatingsData {
    RatingsData({
        required this.courseDetails,
        required this.batchDetails,
        required this.tutor,
        required this.totalReviews,
        required this.averageRating,
    });

    final CourseDetails? courseDetails;
    final BatchDetails? batchDetails;
    final Tutor? tutor;
    final int? totalReviews;
    final String? averageRating;

    factory RatingsData.fromJson(Map<String, dynamic> json){ 
        return RatingsData(
            courseDetails: json["courseDetails"] == null ? null : CourseDetails.fromJson(json["courseDetails"]),
            batchDetails: json["batchDetails"] == null ? null : BatchDetails.fromJson(json["batchDetails"]),
            tutor: json["tutor"] == null ? null : Tutor.fromJson(json["tutor"]),
            totalReviews: json["totalReviews"],
            averageRating: json["averageRating"],
        );
    }

}

class BatchDetails {
    BatchDetails({
        required this.id,
        required this.batchName,
    });

    final String? id;
    final String? batchName;

    factory BatchDetails.fromJson(Map<String, dynamic> json){ 
        return BatchDetails(
            id: json["_id"],
            batchName: json["batch_name"],
        );
    }

}

class CourseDetails {
    CourseDetails({
        required this.id,
        required this.batchName,
        required this.board,
        required this.className,
        required this.subject,
        required this.courseCode,
        required this.remarks,
        required this.batchId,
        required this.userId,
        required this.courseFilename,
        required this.courseUrl,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.address,
        required this.reviews,
    });

    final String? id;
    final String? batchName;
    final String? board;
    final String? className;
    final String? subject;
    final String? courseCode;
    final String? remarks;
    final String? batchId;
    final String? userId;
    final dynamic courseFilename;
    final dynamic courseUrl;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final String? address;
    final List<Review> reviews;

    factory CourseDetails.fromJson(Map<String, dynamic> json){ 
        return CourseDetails(
            id: json["_id"],
            batchName: json["batch_name"],
            board: json["board"],
            className: json["class_name"],
            subject: json["subject"],
            courseCode: json["course_code"],
            remarks: json["remarks"],
            batchId: json["batchId"],
            userId: json["userId"],
            courseFilename: json["course_filename"],
            courseUrl: json["course_url"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
            address: json["address"],
            reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
        );
    }

}

class Review {
    Review({
        required this.id,
        required this.comments,
        required this.star,
        required this.ratingPoints,
        required this.details,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.userId,
    });

    final String? id;
    final String? comments;
    final int? star;
    final String? ratingPoints;
    final List<String> details;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final Tutor? userId;

    factory Review.fromJson(Map<String, dynamic> json){ 
        return Review(
            id: json["_id"],
            comments: json["comments"],
            star: json["star"],
            ratingPoints: json["ratingPoints"],
            details: json["details"] == null ? [] : List<String>.from(json["details"]!.map((x) => x)),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
            userId: json["userId"] == null ? null : Tutor.fromJson(json["userId"]),
        );
    }

}

class Tutor {
    Tutor({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.pincode,
        required this.doorNo,
        required this.street,
        required this.city,
        required this.state,
        required this.country,
        required this.phoneNumber,
    });

    final String? id;
    final String? firstName;
    final String? lastName;
    final String? email;
    final int? pincode;
    final String? doorNo;
    final String? street;
    final String? city;
    final String? state;
    final String? country;
    final String? phoneNumber;

    factory Tutor.fromJson(Map<String, dynamic> json){ 
        return Tutor(
            id: json["_id"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            email: json["email"],
            pincode: json["pincode"],
            doorNo: json["door_no"],
            street: json["street"],
            city: json["city"],
            state: json["state"],
            country: json["country"],
            phoneNumber: json["phone_number"],
        );
    }

}
