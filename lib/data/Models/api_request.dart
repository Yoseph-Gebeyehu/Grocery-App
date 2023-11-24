class ApiRequest {
  String? email;
  String? amount;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? txRef;
  String? currency;
  String? callbackUrl;
  String? returnUrl;
  Customization? customization;

  ApiRequest({
    this.email,
    this.amount,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.txRef,
    this.currency,
    this.callbackUrl,
    this.returnUrl,
    this.customization,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data["email"] = email;
    data["amount"] = amount;
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["phone_number"] = phoneNumber;
    data["tx_ref"] = txRef;
    data["currency"] = currency;
    data["callback_url"] = callbackUrl;
    data["return_url"] = returnUrl;
    data["customization"] = customization!.toJson();

    return data;
  }
}

class Customization {
  String? title;
  String? description;

  Customization({
    this.title,
    this.description,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data["title"] = title;
    data["description"] = description;

    return data;
  }
}
