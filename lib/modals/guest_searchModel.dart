class GuestsearchModel {
    GuestsearchModel({
        required this.institutes,
        required this.courses,
        required this.hostels,
    });

    final List<Institute> institutes;
    final List<Course> courses;
    final List<Hostel> hostels;

    factory GuestsearchModel.fromJson(Map<String, dynamic> json){ 
        return GuestsearchModel(
            institutes: json["institutes"] == null ? [] : List<Institute>.from(json["institutes"]!.map((x) => Institute.fromJson(x))),
            courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
            hostels: json["hostels"] == null ? [] : List<Hostel>.from(json["hostels"]!.map((x) => Hostel.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "institutes": institutes.map((x) => x?.toJson()).toList(),
        "courses": courses.map((x) => x?.toJson()).toList(),
        "hostels": hostels.map((x) => x?.toJson()).toList(),
    };

}

class Course {
    Course({
        required this.id,
        required this.batchName,
        required this.categories,
        required this.board,
        required this.className,
        required this.subject,
        required this.courseCode,
    });

    final String? id;
    final String? batchName;
    final String? categories;
    final String? board;
    final String? className;
    final String? subject;
    final String? courseCode;

    factory Course.fromJson(Map<String, dynamic> json){ 
        return Course(
            id: json["_id"],
            batchName: json["batch_name"],
            categories: json["categories"],
            board: json["board"],
            className: json["class_name"],
            subject: json["subject"],
            courseCode: json["course_code"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "batch_name": batchName,
        "categories": categories,
        "board": board,
        "class_name": className,
        "subject": subject,
        "course_code": courseCode,
    };

}

class Hostel {
    Hostel({
        required this.location,
        required this.id,
        required this.roomType,
        required this.hostelName,
        required this.shortName,
        required this.hostelType,
        required this.categories,
        required this.doorNo,
        required this.street,
        required this.city,
        required this.state,
        required this.country,
        required this.pincode,
        required this.profileFilename,
        required this.profileUrl,
    });

    final Location? location;
    final String? id;
    final String? roomType;
    final String? hostelName;
    final String? shortName;
    final String? hostelType;
    final String? categories;
    final String? doorNo;
    final String? street;
    final String? city;
    final String? state;
    final String? country;
    final String? pincode;
    final String? profileFilename;
    final String? profileUrl;

    factory Hostel.fromJson(Map<String, dynamic> json){ 
        return Hostel(
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            id: json["_id"],
            roomType: json["room_type"],
            hostelName: json["hostel_name"],
            shortName: json["short_name"],
            hostelType: json["hostel_type"],
            categories: json["categories"],
            doorNo: json["door_no"],
            street: json["street"],
            city: json["city"],
            state: json["state"],
            country: json["country"],
            pincode: json["pincode"],
            profileFilename: json["profile_filename"],
            profileUrl: json["profile_url"],
        );
    }

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "room_type": roomType,
        "hostel_name": hostelName,
        "short_name": shortName,
        "hostel_type": hostelType,
        "categories": categories,
        "door_no": doorNo,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
        "profile_filename": profileFilename,
        "profile_url": profileUrl,
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

class Institute {
    Institute({
        required this.location,
        required this.id,
        required this.institudeName,
        required this.address,
        required this.branchShortName,
        required this.doorNo,
        required this.pincode,
        required this.street,
        required this.country,
        required this.city,
        required this.state,
        required this.landmark,
        required this.institudeFilename,
        required this.institudeUrl,
    });

    final Location? location;
    final String? id;
    final String? institudeName;
    final String? address;
    final String? branchShortName;
    final String? doorNo;
    final String? pincode;
    final String? street;
    final String? country;
    final String? city;
    final String? state;
    final String? landmark;
    final String? institudeFilename;
    final String? institudeUrl;

    factory Institute.fromJson(Map<String, dynamic> json){ 
        return Institute(
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            id: json["_id"],
            institudeName: json["institude_name"],
            address: json["address"],
            branchShortName: json["branch_short_name"],
            doorNo: json["door_no"],
            pincode: json["pincode"],
            street: json["street"],
            country: json["country"],
            city: json["city"],
            state: json["state"],
            landmark: json["landmark"],
            institudeFilename: json["institude_filename"],
            institudeUrl: json["institude_url"],
        );
    }

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "institude_name": institudeName,
        "address": address,
        "branch_short_name": branchShortName,
        "door_no": doorNo,
        "pincode": pincode,
        "street": street,
        "country": country,
        "city": city,
        "state": state,
        "landmark": landmark,
        "institude_filename": institudeFilename,
        "institude_url": institudeUrl,
    };

}
