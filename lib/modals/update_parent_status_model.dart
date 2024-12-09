class UpdateParentStausModel {
	int? statusCode;
	bool? success;
	String? message;
	Data? data;
	Location? location;
	String? sId;
	List<String>? userId;

	UpdateParentStausModel({this.statusCode, this.success, this.message, this.data, this.location, this.sId, this.userId});

	UpdateParentStausModel.fromJson(Map<String, dynamic> json) {
		statusCode = json['statusCode'];
		success = json['success'];
		message = json['message'];
		data = json['data'] != null ? new Data.fromJson(json['data']) : null;
		location = json['location'] != null ? new Location.fromJson(json['location']) : null;
		sId = json['_id'];
		userId = json['userId'].cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['statusCode'] = this.statusCode;
		data['success'] = this.success;
		data['message'] = this.message;
		if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
		if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
		data['_id'] = this.sId;
		data['userId'] = this.userId;
		return data;
	}
}

class Data {
	String? sId;
	String? firstName;
	String? lastName;
	String? wowId;
	String? email;
	String? dob;
	String? address;
	String? phoneNumber;
	int? pincode;
	String? doorNo;
	String? street;
	String? city;
	String? state;
	String? country;
	Null? latitude;
	Null? longitude;
	bool? parentRegister;
	String? otp;
	String? accountVerificationToken;
	int? isActive;
	int? isDeleted;
	String? createdAt;
	String? token;

	Data({this.sId, this.firstName, this.lastName, this.wowId, this.email, this.dob, this.address, this.phoneNumber, this.pincode, this.doorNo, this.street, this.city, this.state, this.country, this.latitude, this.longitude, this.parentRegister, this.otp, this.accountVerificationToken, this.isActive, this.isDeleted, this.createdAt, this.token});

	Data.fromJson(Map<String, dynamic> json) {
		sId = json['_id'];
		firstName = json['first_name'];
		lastName = json['last_name'];
		wowId = json['wow_id'];
		email = json['email'];
		dob = json['dob'];
		address = json['address'];
		phoneNumber = json['phone_number'];
		pincode = json['pincode'];
		doorNo = json['door_no'];
		street = json['street'];
		city = json['city'];
		state = json['state'];
		country = json['country'];
		latitude = json['latitude'];
		longitude = json['longitude'];
		parentRegister = json['parentRegister'];
		otp = json['otp'];
		accountVerificationToken = json['account_verification_token'];
		isActive = json['is_active'];
		isDeleted = json['is_deleted'];
		createdAt = json['created_at'];
		token = json['token'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = this.sId;
		data['first_name'] = this.firstName;
		data['last_name'] = this.lastName;
		data['wow_id'] = this.wowId;
		data['email'] = this.email;
		data['dob'] = this.dob;
		data['address'] = this.address;
		data['phone_number'] = this.phoneNumber;
		data['pincode'] = this.pincode;
		data['door_no'] = this.doorNo;
		data['street'] = this.street;
		data['city'] = this.city;
		data['state'] = this.state;
		data['country'] = this.country;
		data['latitude'] = this.latitude;
		data['longitude'] = this.longitude;
		data['parentRegister'] = this.parentRegister;
		data['otp'] = this.otp;
		data['account_verification_token'] = this.accountVerificationToken;
		data['is_active'] = this.isActive;
		data['is_deleted'] = this.isDeleted;
		data['created_at'] = this.createdAt;
		data['token'] = this.token;
		return data;
	}
}

class Location {
	String? type;
	//List<Null>? coordinates;

	Location({this.type});

	Location.fromJson(Map<String, dynamic> json) {
		type = json['type'];
		if (json['coordinates'] != null) {
			// coordinates = <Null>[];
			// json['coordinates'].forEach((v) { coordinates!.add(new Null.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['type'] = this.type;
		// if (this.coordinates != null) {
    //   data['coordinates'] = this.coordinates!.map((v) => v.toJson()).toList();
    // }
		return data;
	}
}

// class Coordinates {


// 	Coordinates({});

// 	Coordinates.fromJson(Map<String, dynamic> json) {
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		return data;
// 	}
