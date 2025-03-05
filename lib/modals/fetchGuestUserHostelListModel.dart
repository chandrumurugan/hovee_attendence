class FetchGuestUserHostelListModel {
    FetchGuestUserHostelListModel({
        required this.success,
        required this.statusCode,
        required this.data,
    });

    final bool? success;
    final num? statusCode;
    final Data1? data;

    factory FetchGuestUserHostelListModel.fromJson(Map<String, dynamic> json){ 
        return FetchGuestUserHostelListModel(
            success: json["success"],
            statusCode: json["statusCode"],
            data: json["data"] == null ? null : Data1.fromJson(json["data"]),
        );
    }

}

class Data1 {
    Data1({
        required this.totalRecords,
        required this.records,
        required this.roleName,
        required this.totalPages,
        required this.currentPage,
    });

    final num? totalRecords;
    final List<Record> records;
    final String? roleName;
    final num? totalPages;
    final num? currentPage;

    factory Data1.fromJson(Map<String, dynamic> json){ 
        return Data1(
            totalRecords: json["totalRecords"],
            records: json["records"] == null ? [] : List<Record>.from(json["records"]!.map((x) => Record.fromJson(x))),
            roleName: json["roleName"],
            totalPages: json["totalPages"],
            currentPage: json["currentPage"],
        );
    }

}

class Record {
    Record({
        required this.location,
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
        required this.qrCodeUrl,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final Location? location;
    final String? id;
    final String? hostelObjectId;
    final RoomType? roomType;
    final String? hostelName;
    final String? registerNo;
    final String? shortName;
    final String? hostelType;
    final String? food;
    final String? categories;
    final String? remarks;
    final num? latitude;
    final num? longitude;
    final String? doorNo;
    final String? street;
    final String? city;
    final String? state;
    final String? country;
    final String? pincode;
    final String? profileFilename;
    final String? profileUrl;
    final String? hostelTimingStart;
    final String? hostelTimingEnd;
    final num? hostelTimingStartMinutes;
    final num? hostelTimingEndMinutes;
    final String? qrCodeUrl;
    final num? isActive;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final num? v;

    factory Record.fromJson(Map<String, dynamic> json){ 
        return Record(
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            id: json["_id"],
            hostelObjectId: json["hostel_ObjectId"],
            roomType: json["room_type"] == null ? null : RoomType.fromJson(json["room_type"]),
            hostelName: json["hostel_name"],
            registerNo: json["register_no"],
            shortName: json["short_name"],
            hostelType: json["hostel_type"],
            food: json["food"],
            categories: json["categories"],
            remarks: json["remarks"],
            latitude: json["latitude"],
            longitude: json["longitude"],
            doorNo: json["door_no"],
            street: json["street"],
            city: json["city"],
            state: json["state"],
            country:
json["country"],
            pincode: json["pincode"],
            profileFilename: json["profile_filename"],
            profileUrl: json["profile_url"],
            hostelTimingStart: json["hostel_timing_start"],
            hostelTimingEnd: json["hostel_timing_end"],
            hostelTimingStartMinutes: json["hostel_timing_start_minutes"],
            hostelTimingEndMinutes: json["hostel_timing_end_minutes"],
            qrCodeUrl: json["qr_code_url"],
            isActive: json["is_active"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Location {
    Location({
        required this.type,
        required this.coordinates,
    });

    final String? type;
    final List<num> coordinates;

    factory Location.fromJson(Map<String, dynamic> json){ 
        return Location(
            type: json["type"],
            coordinates: json["coordinates"] == null ? [] : List<num>.from(json["coordinates"]!.map((x) => x)),
        );
    }

}

class RoomType {
    RoomType({
        required this.id,
        required this.price,
    });

    final String? id;
    final num? price;

    factory RoomType.fromJson(Map<String, dynamic> json){ 
        return RoomType(
            id: json["_id"],
            price: json["price"],
        );
    }

}