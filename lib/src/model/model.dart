
class InitModel {
    String? status;
    int? code;
    String? reason;
    String? token;
    String? checkoutUrl;

    InitModel({
         this.status,
         this.code,
         this.reason,
         this.token,
         this.checkoutUrl,
    });

    factory InitModel.fromJson(Map<String, dynamic> json) => InitModel(
        status: json["status"],
        code: json["code"],
        reason: json["reason"],
        token: json["token"],
        checkoutUrl: json["checkout_url"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "reason": reason,
        "token": token,
        "checkout_url": checkoutUrl,
    };
}
