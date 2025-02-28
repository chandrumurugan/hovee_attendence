class PostPaymentModel {
    PostPaymentModel({
        required this.success,
        required this.statusCode,
        required this.data,
        required this.message,
    });

    final bool? success;
    final int? statusCode;
    final Data? data;
    final String? message;

    factory PostPaymentModel.fromJson(Map<String, dynamic> json){ 
        return PostPaymentModel(
            success: json["success"],
            statusCode: json["statusCode"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "data": data?.toJson(),
        "message": message,
    };

}

class Data {
    Data({
        required this.userId,
        required this.subscriptionId,
        required this.planId,
        required this.durationType,
        required this.duration,
        required this.price,
        required this.totalPrice,
        required this.isActive,
        required this.purchaseDate,
        required this.expiryDate,
        required this.paymentTxtId,
        required this.invoiceId,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? userId;
    final String? subscriptionId;
    final String? planId;
    final String? durationType;
    final int? duration;
    final int? price;
    final int? totalPrice;
    final int? isActive;
    final DateTime? purchaseDate;
    final DateTime? expiryDate;
    final String? paymentTxtId;
    final String? invoiceId;
    final String? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            userId: json["user_id"],
            subscriptionId: json["subscription_id"],
            planId: json["plan_id"],
            durationType: json["duration_type"],
            duration: json["duration"],
            price: json["price"],
            totalPrice: json["total_price"],
            isActive: json["is_active"],
            purchaseDate: DateTime.tryParse(json["purchase_date"] ?? ""),
            expiryDate: DateTime.tryParse(json["expiry_date"] ?? ""),
            paymentTxtId: json["payment_txt_id"],
            invoiceId: json["invoice_id"],
            id: json["_id"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "subscription_id": subscriptionId,
        "plan_id": planId,
        "duration_type": durationType,
        "duration": duration,
        "price": price,
        "total_price": totalPrice,
        "is_active": isActive,
        "purchase_date": purchaseDate?.toIso8601String(),
        "expiry_date": expiryDate?.toIso8601String(),
        "payment_txt_id": paymentTxtId,
        "invoice_id": invoiceId,
        "_id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
    };

}
