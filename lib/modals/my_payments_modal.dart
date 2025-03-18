class Mypayments {
    Mypayments({
        required this.success,
        required this.statusCode,
        required this.data,
        required this.currentPage,
        required this.totalPages,
        required this.totalCount,
    });

    final bool? success;
    final int? statusCode;
    final List<MypaymentData> data;
    final int? currentPage;
    final int? totalPages;
    final int? totalCount;

    factory Mypayments.fromJson(Map<String, dynamic> json){ 
        return Mypayments(
            success: json["success"],
            statusCode: json["statusCode"],
            data: json["data"] == null ? [] : List<MypaymentData>.from(json["data"]!.map((x) => MypaymentData.fromJson(x))),
            currentPage: json["currentPage"],
            totalPages: json["totalPages"],
            totalCount: json["totalCount"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "data": data.map((x) => x?.toJson()).toList(),
        "currentPage": currentPage,
        "totalPages": totalPages,
        "totalCount": totalCount,
    };

}

class MypaymentData {
    MypaymentData({
        required this.id,
        required this.subscriptionId,
        required this.planId,
        required this.durationType,
        required this.duration,
        required this.price,
        required this.totalPrice,
        required this.isActive,
        required this.expiredStatus,
        required this.purchaseDate,
        required this.expiryDate,
        required this.paymentTxtId,
        required this.invoiceId,
        required this.paymentStatus,
        required this.createdAt,
        required this.selectedPlan,
    });

    final String? id;
    final String? subscriptionId;
    final String? planId;
    final String? durationType;
    final int? duration;
    final int? price;
    final int? totalPrice;
    final String? isActive;
    final bool? expiredStatus;
    final String? purchaseDate;
    final String? expiryDate;
    final String? paymentTxtId;
    final String? invoiceId;
    final String? paymentStatus;
    final String? createdAt;
    final SelectedPlan? selectedPlan;

    factory MypaymentData.fromJson(Map<String, dynamic> json){ 
        return MypaymentData(
            id: json["_id"],
            subscriptionId: json["subscription_id"],
            planId: json["plan_id"],
            durationType: json["duration_type"],
            duration: json["duration"],
            price: json["price"],
            totalPrice: json["total_price"],
            isActive: json["is_active"],
            expiredStatus: json["expired_status"],
            purchaseDate: json["purchase_date"],
            expiryDate: json["expiry_date"],
            paymentTxtId: json["payment_txt_id"],
            invoiceId: json["invoice_id"],
            paymentStatus: json["payment_status"],
            createdAt: json["created_at"],
            selectedPlan: json["selectedPlan"] == null ? null : SelectedPlan.fromJson(json["selectedPlan"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "subscription_id": subscriptionId,
        "plan_id": planId,
        "duration_type": durationType,
        "duration": duration,
        "price": price,
        "total_price": totalPrice,
        "is_active": isActive,
        "expired_status": expiredStatus,
        "purchase_date": purchaseDate,
        "expiry_date": expiryDate,
        "payment_txt_id": paymentTxtId,
        "invoice_id": invoiceId,
        "payment_status": paymentStatus,
        "created_at": createdAt,
        "selectedPlan": selectedPlan?.toJson(),
    };

}

class SelectedPlan {
    SelectedPlan({
        required this.category,
        required this.duration,
        required this.durationType,
        required this.price,
        required this.description,
        required this.id,
        required this.colorCode,
    });

    final String? category;
    final String? duration;
    final String? durationType;
    final double? price;
    final List<String> description;
    final String? id;
    final String? colorCode;

    factory SelectedPlan.fromJson(Map<String, dynamic> json){ 
        return SelectedPlan(
            category: json["category"],
            duration: json["duration"],
            durationType: json["durationType"],
             price: (json["price"] as num?)?.toDouble(),
            description: json["description"] == null ? [] : List<String>.from(json["description"]!.map((x) => x)),
            id: json["_id"],
            colorCode: json["colorCode"]
        );
    }

    Map<String, dynamic> toJson() => {
        "category": category,
        "duration": duration,
        "durationType": durationType,
        "price": price,
        "description": description.map((x) => x).toList(),
        "_id": id,
       "colorCode" :colorCode
    };

}
