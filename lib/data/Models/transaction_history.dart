class TransactionHistory {
  String? message;
  String? status;
  Data? data;

  TransactionHistory({this.message, this.status, this.data});

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? firstName;
  String? lastName;
  String? email;
  String? currency;
  double? amount;
  double? charge;
  String? mode;
  String? method;
  String? type;
  String? status;
  String? reference;
  String? txRef;
  Customization? customization;
  // Null? meta;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.firstName,
      this.lastName,
      this.email,
      this.currency,
      this.amount,
      this.charge,
      this.mode,
      this.method,
      this.type,
      this.status,
      this.reference,
      this.txRef,
      this.customization,
      // this.meta,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    currency = json['currency'];
    amount = (json['amount'] as num).toDouble();
    charge = json['charge'] != null ? (json['charge'] as num).toDouble() : null;
    mode = json['mode'];
    method = json['method'];
    type = json['type'];
    status = json['status'];
    reference = json['reference'];
    txRef = json['tx_ref'];
    customization = json['customization'] != null
        ? Customization.fromJson(json['customization'])
        : null;
    // meta = json['meta'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['currency'] = currency;
    data['amount'] = amount;
    data['charge'] = charge;
    data['mode'] = mode;
    data['method'] = method;
    data['type'] = type;
    data['status'] = status;
    data['reference'] = reference;
    data['tx_ref'] = txRef;
    if (customization != null) {
      data['customization'] = customization!.toJson();
    }
    // data['meta'] = this.meta;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Customization {
  String? title;
  String? description;
  // Null? logo;

  Customization({
    this.title,
    this.description,
    // this.logo,
  });

  Customization.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    // logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    // data['logo'] = this.logo;
    return data;
  }
}
