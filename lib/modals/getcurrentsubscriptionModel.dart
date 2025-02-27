// class GetcurrentsubscriptionModel {
//     GetcurrentsubscriptionModel({
//         required this.success,
//         required this.statusCode,
//         required this.data,
//         required this.message,
//     });

//     final bool? success;
//     final int? statusCode;
//     final List<Data>? data;
//     final String? message;

//     factory GetcurrentsubscriptionModel.fromJson(Map<String, dynamic> json) {
//         return GetcurrentsubscriptionModel(
//             success: json["success"],
//             statusCode: json["statusCode"],
//             data: json["data"] == null 
//                 ? null 
//                 : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
//             message: json["message"],
//         );
//     }

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "statusCode": statusCode,
//         "data": data?.map((x) => x.toJson()).toList(),
//         "message": message,
//     };
// }

// class Data {
//     Data({
//         required this.id,
//         required this.subscriptionId,
//         required this.planId,
//         required this.planName,
//         required this.durationType,
//         required this.duration,
//         required this.price,
//         required this.totalPrice,
//         required this.isActive,
//         required this.purchaseDate,
//         required this.expiryDate,
//         required this.paymentTxtId,
//         required this.invoiceId,
//         required this.createdAt,
//     });

//     final String? id;
//     final String? subscriptionId;
//     final String? planId;
//     final String? planName;
//     final String? durationType;
//     final int? duration;
//     final int? price;
//     final int? totalPrice;
//     final int? isActive;
//     final String? purchaseDate;
//     final String? expiryDate;
//     final String? paymentTxtId;
//     final String? invoiceId;
//     final DateTime? createdAt;

//     factory Data.fromJson(Map<String, dynamic> json) {
//         return Data(
//             id: json["id"],
//             subscriptionId: json["subscription_id"],
//             planId: json["plan_id"],
//             planName: json["plan_name"],
//             durationType: json["duration_type"],
//             duration: json["duration"],
//             price: json["price"],
//             totalPrice: json["total_price"],
//             isActive: json["is_active"],
//             purchaseDate: json["purchase_date"],
//             expiryDate: json["expiry_date"],
//             paymentTxtId: json["payment_txt_id"],
//             invoiceId: json["invoice_id"],
//             createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
//         );
//     }

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "subscription_id": subscriptionId,
//         "plan_id": planId,
//         "plan_name": planName,
//         "duration_type": durationType,
//         "duration": duration,
//         "price": price,
//         "total_price": totalPrice,
//         "is_active": isActive,
//         "purchase_date": purchaseDate,
//         "expiry_date": expiryDate,
//         "payment_txt_id": paymentTxtId,
//         "invoice_id": invoiceId,
//         "created_at": createdAt?.toIso8601String(),
//     };
// }


class GetcurrentsubscriptionModel {
    GetcurrentsubscriptionModel({
        required this.success,
        required this.statusCode,
        required this.data,
        required this.message,
    });

    final bool? success;
    final int? statusCode;
    final Data? data;
    final String? message;

    factory GetcurrentsubscriptionModel.fromJson(Map<String, dynamic> json){ 
        return GetcurrentsubscriptionModel(
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
        required this.id,
        required this.subscriptionId,
        required this.planId,
        required this.planName,
        required this.durationType,
        required this.duration,
        required this.price,
        required this.totalPrice,
        required this.isActive,
        required this.purchaseDate,
        required this.expiryDate,
        required this.paymentTxtId,
        required this.invoiceId,
        required this.createdAt,
    });

    final String? id;
    final String? subscriptionId;
    final String? planId;
    final String? planName;
    final String? durationType;
    final int? duration;
    final int? price;
    final int? totalPrice;
    final int? isActive;
    final String? purchaseDate;
    final String? expiryDate;
    final String? paymentTxtId;
    final String? invoiceId;
    final DateTime? createdAt;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            subscriptionId: json["subscription_id"],
            planId: json["plan_id"],
            planName: json["plan_name"],
            durationType: json["duration_type"],
            duration: json["duration"],
            price: json["price"],
            totalPrice: json["total_price"],
            isActive: json["is_active"],
            purchaseDate: json["purchase_date"],
            expiryDate: json["expiry_date"],
            paymentTxtId: json["payment_txt_id"],
            invoiceId: json["invoice_id"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "subscription_id": subscriptionId,
        "plan_id": planId,
        "plan_name": planName,
        "duration_type": durationType,
        "duration": duration,
        "price": price,
        "total_price": totalPrice,
        "is_active": isActive,
        "purchase_date": purchaseDate,
        "expiry_date": expiryDate,
        "payment_txt_id": paymentTxtId,
        "invoice_id": invoiceId,
        "created_at": createdAt?.toIso8601String(),
    };

}
