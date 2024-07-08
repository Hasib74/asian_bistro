import 'package:get/get.dart';

class OrderModel {
  var serviceProviderId;
  var offerId;
  var orderStatusId;
  var deliveryManId;
  var totalAmount;
  var discount;
  var deliveryFee;
  var paidAmount;
  var paymentType;
  var transactionId;
  var deliveryDatetime;
  var customerId;
  var payment_status;
  var payment_type;
  var user_id;
  var customer_email;
  var lat_value;
  var long_value;

  List<OrderDetails>? orderDetails;

  OrderModel(
      {this.serviceProviderId,
      this.offerId,
      this.orderStatusId,
      this.deliveryManId,
      this.totalAmount,
      this.discount,
      this.deliveryFee,
      this.paidAmount,
      this.paymentType,
      this.transactionId,
      this.deliveryDatetime,
      this.payment_status,
      this.payment_type,
      this.customerId,
      this.user_id,
      this.orderDetails,
      this.customer_email,
      required this.lat_value,
      required this.long_value});

  OrderModel.fromJson(json) {
    serviceProviderId = json['service_provider_id'];
    offerId = json['offer_id'];
    payment_status = json["payment_status"];
    payment_type = json["payment_type"];
    orderStatusId = json['order_status_id'];
    deliveryManId = json['delivery_man_id'];
    totalAmount = json['total_amount'];
    discount = json['discount'];
    deliveryFee = json['delivery_fee'];
    paidAmount = json['paid_amount'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'];
    deliveryDatetime = json['delivery_datetime'];
    customerId = json["customer_id"];
    customer_email = json["customer_email"];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails?.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    print("User IDDD ::: ${user_id}");

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["user_id"] = this.user_id;
    data["customer_id"] = this.user_id;
    data['service_provider_id'] = this.serviceProviderId;
    data['offer_id'] = this.offerId ?? 1;
    data['order_status_id'] = this.orderStatusId;
    data['delivery_man_id'] = this.deliveryManId;
    data['total_amount'] = this.totalAmount;
    data['discount'] = this.discount ?? 0;
    // data['delivery_fee'] = this.deliveryFee;
    data['paid_amount'] = this.paidAmount;
    data['payment_type'] = this.paymentType;
    data["payment_status"] = this.payment_status;
    data["payment_type"] = this.payment_type;
    data['transaction_id'] = this.transactionId;
    data['delivery_datetime'] = this.deliveryDatetime;
    data["customer_id"] = this.customerId;
    data["customer_email"] = this.customer_email;
    /* "lat_value":"37.0" , "long_value":"-122.66"*/
    data["lat_value"] = this.lat_value ?? "37.0";
    data["long_value"] = this.long_value;
    final orderDetails = this.orderDetails;
    if (orderDetails != null) {
      data['order_details'] = orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  String? productNameId;
  String? quantity;
  String? amount;
  String? product_name;

  String? productSize;

  List<OrderExtraItems>? extraItems = [];

  OrderDetails(
      {this.productNameId,
      this.quantity,
      this.amount,
      this.product_name,
      this.productSize,
      this.extraItems});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    productNameId = json['product_name_id'];
    quantity = json['quantity'];
    amount = json['amount'];
    product_name = json["product_name"];
    productSize = json["size_id"];
    if (json['extraItems'] != null) {
      extraItems = <OrderExtraItems>[];
      json['extraItems'].forEach((v) {
        extraItems?.add(new OrderExtraItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name_id'] = this.productNameId;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data["product_name"] = this.product_name;
    data["size_id"] = this.productSize;
    if (this.extraItems != null) {
      printInfo(info: "Extra Items ::: ${extraItems}");
      data['extra_items'] = this.extraItems?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderExtraItems {
  var extra_item_id;
  var extra_item_price;

  OrderExtraItems({this.extra_item_id, this.extra_item_price}) {
    print("Extra Item ID ::: ${extra_item_id}");
    print("Extra Item Price ::: ${extra_item_price}");
  }

  OrderExtraItems.fromJson(Map<String, dynamic> json) {
    extra_item_id = json['extra_item_id'];
    extra_item_price = json['extra_item_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['extra_item_id'] = this.extra_item_id;
    data['extra_item_price'] = this.extra_item_price;
    return data;
  }
}
