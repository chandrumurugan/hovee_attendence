class GetTestimonialsModel {
    GetTestimonialsModel({
        required this.success,
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final bool? success;
    final int? statusCode;
    final String? message;
    final List<Datum> data;

    factory GetTestimonialsModel.fromJson(Map<String, dynamic> json){ 
        return GetTestimonialsModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
    };

}

class Datum {
    Datum({
        required this.id,
        required this.userName,
        required this.testimonial,
        required this.testimonialImage,
        required this.testimonialFilename,
        required this.isActive,
        required this.isDelete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.testimonialUrl,
    });

    final String? id;
    final String? userName;
    final String? testimonial;
    final String? testimonialImage;
    final String? testimonialFilename;
    final int? isActive;
    final int? isDelete;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final String? testimonialUrl;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["_id"],
            userName: json["userName"],
            testimonial: json["testimonial"],
            testimonialImage: json["testimonial_image"],
            testimonialFilename: json["testimonial_filename"],
            isActive: json["is_active"],
            isDelete: json["is_delete"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
            testimonialUrl: json["testimonial_url"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
        "testimonial": testimonial,
        "testimonial_image": testimonialImage,
        "testimonial_filename": testimonialFilename,
        "is_active": isActive,
        "is_delete": isDelete,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "testimonial_url": testimonialUrl,
    };

}
