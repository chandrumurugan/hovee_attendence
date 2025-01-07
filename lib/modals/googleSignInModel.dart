class GoogleSignInModel {
    GoogleSignInModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Data? data;

    factory GoogleSignInModel.fromJson(Map<String, dynamic> json){ 
        return GoogleSignInModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };

}

class Data {
    Data({
        required this.token,
        required this.otp,
        required this.accountSetup,
        required this.accountVerified,
        required this.user,
    });

    final String? token;
    final String? otp;
    final bool? accountSetup;
    final bool? accountVerified;
    final User? user;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            token: json["token"],
            otp: json["otp"],
            accountSetup: json["account_setup"],
            accountVerified: json["account_verified"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "token": token,
        "otp": otp,
        "account_setup": accountSetup,
        "account_verified": accountVerified,
        "user": user?.toJson(),
    };

}

class User {
    User({
        required this.id,
        required this.email,
        required this.name,
    });

    final String? id;
    final String? email;
    final String? name;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["id"],
            email: json["email"],
            name: json["name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
    };

}