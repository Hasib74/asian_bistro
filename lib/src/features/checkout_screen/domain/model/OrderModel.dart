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
    lat_value = json["lat_value"];
    long_value = json["long_value"];
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
    data["lat_value"] = this.lat_value;
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

  OrderDetails(
      {this.productNameId, this.quantity, this.amount, this.product_name});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    productNameId = json['product_name_id'];
    quantity = json['quantity'];
    amount = json['amount'];
    product_name = json["product_name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name_id'] = this.productNameId;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data["product_name"] = this.product_name;
    return data;
  }
}
