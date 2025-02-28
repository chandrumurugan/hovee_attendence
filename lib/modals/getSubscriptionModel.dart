class GetSubscriptionModel {
    GetSubscriptionModel({
        required this.success,
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final bool? success;
    final int? statusCode;
    final String? message;
    final List<Datum> data;

    factory GetSubscriptionModel.fromJson(Map<String, dynamic> json){ 
        return GetSubscriptionModel(
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
        required this.subscriptionTitle,
        required this.subscriptionDescription,
        required this.duration,
        required this.plans,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? subscriptionTitle;
    final String? subscriptionDescription;
    final String? duration;
    final List<Plan> plans;
    final int? isActive;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["_id"],
            subscriptionTitle: json["subscription_title"],
            subscriptionDescription: json["subscription_description"],
            duration: json["duration"],
            plans: json["plans"] == null ? [] : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
            isActive: json["is_active"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "subscription_title": subscriptionTitle,
        "subscription_description": subscriptionDescription,
        "duration": duration,
        "plans": plans.map((x) => x?.toJson()).toList(),
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
    };

}

class Plan {
    Plan({
        required this.category,
        required this.duration,
        required this.durationType,
        required this.price,
        required this.description,
        required this.id,
    });

    final String? category;
    final String? duration;
    final String? durationType;
    final double? price;
    final List<String> description;
    final String? id;

    factory Plan.fromJson(Map<String, dynamic> json){ 
        return Plan(
            category: json["category"],
            duration: json["duration"],
            durationType: json["durationType"],
            price: json["price"],
            description: json["description"] == null ? [] : List<String>.from(json["description"]!.map((x) => x)),
            id: json["_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "category": category,
        "duration": duration,
        "durationType": durationType,
        "price": price,
        "description": description.map((x) => x).toList(),
        "_id": id,
    };

}
