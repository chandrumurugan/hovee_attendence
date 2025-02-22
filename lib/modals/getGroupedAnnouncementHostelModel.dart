class GetGroupedAnnouncementHostelModel {
    GetGroupedAnnouncementHostelModel({
        required this.statusCode,
        required this.message,
        required this.data,
        required this.pagination,
    });

    final int? statusCode;
    final String? message;
    final List<Datum> data;
    final Pagination? pagination;

    factory GetGroupedAnnouncementHostelModel.fromJson(Map<String, dynamic> json){ 
        return GetGroupedAnnouncementHostelModel(
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
        "pagination": pagination?.toJson(),
    };

}

class Datum {
    Datum({
        required this.title,
        required this.announcementId,
        required this.description,
        required this.hostelListsDetails,
        required this.hostellerObjectId,
    });

    final String? title;
    final String? announcementId;
    final String? description;
    final HostelListsDetails? hostelListsDetails;
    final List<HostellerObjectId> hostellerObjectId;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            title: json["title"],
            announcementId: json["announcementId"],
            description: json["description"],
            hostelListsDetails: json["hostel_lists_Details"] == null ? null : HostelListsDetails.fromJson(json["hostel_lists_Details"]),
            hostellerObjectId: json["hosteller_ObjectId"] == null ? [] : List<HostellerObjectId>.from(json["hosteller_ObjectId"]!.map((x) => HostellerObjectId.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "title": title,
        "announcementId": announcementId,
        "description": description,
        "hostel_lists_Details": hostelListsDetails?.toJson(),
        "hosteller_ObjectId": hostellerObjectId.map((x) => x?.toJson()).toList(),
    };

}

class HostelListsDetails {
    HostelListsDetails({
        required this.id,
        required this.hostelObjectId,
        required this.roomType,
        required this.hostelName,
        required this.registerNo,
        required this.shortName,
        required this.hostelType,
        required this.food,
        required this.categories,
        required this.remarks,
        required this.latitude,
        required this.longitude,
        required this.location,
        required this.doorNo,
        required this.street,
        required this.city,
        required this.state,
        required this.country,
        required this.pincode,
        required this.profileFilename,
        required this.profileUrl,
        required this.hostelTimingStart,
        required this.hostelTimingEnd,
        required this.hostelTimingStartMinutes,
        required this.hostelTimingEndMinutes,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.qrCodeUrl,
    });

    final String? id;
    final String? hostelObjectId;
    final String? roomType;
    final String? hostelName;
    final String? registerNo;
    final String? shortName;
    final String? hostelType;
    final String? food;
    final String? categories;
    final String? remarks;
    final double? latitude;
    final double? longitude;
    final Location? location;
    final String? doorNo;
    final String? street;
    final String? city;
    final String? state;
    final String? country;
    final String? pincode;
    final dynamic profileFilename;
    final dynamic profileUrl;
    final String? hostelTimingStart;
    final String? hostelTimingEnd;
    final int? hostelTimingStartMinutes;
    final int? hostelTimingEndMinutes;
    final int? isActive;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final String? qrCodeUrl;

    factory HostelListsDetails.fromJson(Map<String, dynamic> json){ 
        return HostelListsDetails(
            id: json["_id"],
            hostelObjectId: json["hostel_ObjectId"],
            roomType: json["room_type"],
            hostelName: json["hostel_name"],
            registerNo: json["register_no"],
            shortName: json["short_name"],
            hostelType: json["hostel_type"],
            food: json["food"],
            categories: json["categories"],
            remarks: json["remarks"],
            latitude: json["latitude"],
            longitude: json["longitude"],
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            doorNo: json["door_no"],
            street: json["street"],
            city: json["city"],
            state: json["state"],
            country: json["country"],
            pincode: json["pincode"],
            profileFilename: json["profile_filename"],
            profileUrl: json["profile_url"],
            hostelTimingStart: json["hostel_timing_start"],
            hostelTimingEnd: json["hostel_timing_end"],
            hostelTimingStartMinutes: json["hostel_timing_start_minutes"],
            hostelTimingEndMinutes: json["hostel_timing_end_minutes"],
            isActive: json["is_active"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            qrCodeUrl: json["qr_code_url"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "hostel_ObjectId": hostelObjectId,
        "room_type": roomType,
        "hostel_name": hostelName,
        "register_no": registerNo,
        "short_name": shortName,
        "hostel_type": hostelType,
        "food": food,
        "categories": categories,
        "remarks": remarks,
        "latitude": latitude,
        "longitude": longitude,
        "location": location?.toJson(),
        "door_no": doorNo,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
        "profile_filename": profileFilename,
        "profile_url": profileUrl,
        "hostel_timing_start": hostelTimingStart,
        "hostel_timing_end": hostelTimingEnd,
        "hostel_timing_start_minutes": hostelTimingStartMinutes,
        "hostel_timing_end_minutes": hostelTimingEndMinutes,
        "is_active": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "qr_code_url": qrCodeUrl,
    };

}

class Location {
    Location({
        required this.type,
        required this.coordinates,
    });

    final String? type;
    final List<double> coordinates;

    factory Location.fromJson(Map<String, dynamic> json){ 
        return Location(
            type: json["type"],
            coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates.map((x) => x).toList(),
    };

}

class HostellerObjectId {
    HostellerObjectId({
        required this.hostellerFirstName,
        required this.hostellerLastName,
        required this.hostellerObjectId,
    });

    final String? hostellerFirstName;
    final String? hostellerLastName;
    final String? hostellerObjectId;

    factory HostellerObjectId.fromJson(Map<String, dynamic> json){ 
        return HostellerObjectId(
            hostellerFirstName: json["hosteller_first_name"],
            hostellerLastName: json["hosteller_last_name"],
            hostellerObjectId: json["hosteller_ObjectId"],
        );
    }

    Map<String, dynamic> toJson() => {
        "hosteller_first_name": hostellerFirstName,
        "hosteller_last_name": hostellerLastName,
        "hosteller_ObjectId": hostellerObjectId,
    };

}

class Pagination {
    Pagination({
        required this.totalItems,
        required this.currentPage,
        required this.totalPages,
    });

    final int? totalItems;
    final int? currentPage;
    final int? totalPages;

    factory Pagination.fromJson(Map<String, dynamic> json){ 
        return Pagination(
            totalItems: json["totalItems"],
            currentPage: json["currentPage"],
            totalPages: json["totalPages"],
        );
    }

    Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "currentPage": currentPage,
        "totalPages": totalPages,
    };

}
