class OrderModel {
  int? id;
  int? quantity;
  int? price;
  Null? discount;
  Null? vAT;
  String? orderDateAndTime;
  User? user;
  Payment? payment;
  OrderStatus? orderStatus;

  OrderModel(
      {this.id,
      this.quantity,
      this.price,
      this.discount,
      this.vAT,
      this.orderDateAndTime,
      this.user,
      this.payment,
      this.orderStatus});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    discount = json['discount'];
    vAT = json['VAT'];
    orderDateAndTime = json['order_date_and_time'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    payment =
        json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    orderStatus = json['order_status'] != null
        ? OrderStatus.fromJson(json['order_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['price'] = price;
    data['discount'] = discount;
    data['VAT'] = vAT;
    data['order_date_and_time'] = orderDateAndTime;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    if (orderStatus != null) {
      data['order_status'] = orderStatus!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Payment {
  int? paymentStatus;

  Payment({this.paymentStatus});

  Payment.fromJson(Map<String, dynamic> json) {
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_status'] = paymentStatus;
    return data;
  }
}

class OrderStatus {
  User? orderStatusCategory;

  OrderStatus({this.orderStatusCategory});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    orderStatusCategory = json['order_status_category'] != null
        ? User.fromJson(json['order_status_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderStatusCategory != null) {
      data['order_status_category'] = orderStatusCategory!.toJson();
    }
    return data;
  }
}
