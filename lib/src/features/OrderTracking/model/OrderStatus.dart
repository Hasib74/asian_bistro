class OrderStatus {
  String? success;
  String? statusCode;
  List<Order>? orders;
  String? error;

  OrderStatus({this.success, this.statusCode, this.orders, this.error});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    // print("message .............................." + json['message']);

    success = json['success'];
    statusCode = json['status_code'];
    if (json['message'] != null) {
      if (json['message'].toString().endsWith("Invalid:Data Not Found")) {
        orders = [];
      } else {
        orders = <Order>[];
        json['message'].forEach((v) {
          orders?.add(new Order.fromJson(v));
        });
      }
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.orders != null) {
      data['message'] = this.orders?.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Order {
  var id;
  var serviceProviderId;
  var customerId;
  var deliveryManId;
  String? orderCode;
  var offerId;
  var orderStatusId;
  var totalAmount;
  var discount;
  var deliveryFee;
  var paidAmount;
  var paymentType;
  var transactionId;
  var orderAddress;
  String? orderDatetime;
  var deliveryDatetime;
  String? createdAt;
  String? updatedAt;
  String? orderAcceptTime;
  String? deliveryTime;
  String? itemsPickTime;
  var distance;
  var deliverySpeed;

  Order(
      {this.id,
      this.serviceProviderId,
      this.customerId,
      this.deliveryManId,
      this.orderCode,
      this.offerId,
      this.orderStatusId,
      this.totalAmount,
      this.discount,
      this.deliveryFee,
      this.paidAmount,
      this.paymentType,
      this.transactionId,
      this.orderAddress,
      this.orderDatetime,
      this.deliveryDatetime,
      this.createdAt,
      this.updatedAt,
      this.orderAcceptTime,
      this.deliveryTime,
      this.itemsPickTime,
      this.distance,
      this.deliverySpeed});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceProviderId = json['service_provider_id'];
    customerId = json['customer_id'];
    deliveryManId = json['delivery_man_id'];
    orderCode = json['order_code'];
    offerId = json['offer_id'];
    orderStatusId = json['order_status'];
    totalAmount = json['total_amount'];
    discount = json['discount'];
    deliveryFee = json['delivery_fee'];
    paidAmount = json['paid_amount'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'];
    orderAddress = json['order_address'];
    orderDatetime = json['order_datetime'];
    deliveryDatetime = json['delivery_datetime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderAcceptTime = json['order_accept_time'];
    deliveryTime = json['delivery_time'];
    itemsPickTime = json['items_pick_time'];
    distance = json['distance'];
    deliverySpeed = json['delivery_speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_provider_id'] = this.serviceProviderId;
    data['customer_id'] = this.customerId;
    data['delivery_man_id'] = this.deliveryManId;
    data['order_code'] = this.orderCode;
    data['offer_id'] = this.offerId;
    data['order_status_id'] = this.orderStatusId;
    data['total_amount'] = this.totalAmount;
    data['discount'] = this.discount;
    data['delivery_fee'] = this.deliveryFee;
    data['paid_amount'] = this.paidAmount;
    data['payment_type'] = this.paymentType;
    data['transaction_id'] = this.transactionId;
    data['order_address'] = this.orderAddress;
    data['order_datetime'] = this.orderDatetime;
    data['delivery_datetime'] = this.deliveryDatetime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_accept_time'] = this.orderAcceptTime;
    data['delivery_time'] = this.deliveryTime;
    data['items_pick_time'] = this.itemsPickTime;
    data['distance'] = this.distance;
    data['delivery_speed'] = this.deliverySpeed;
    return data;
  }
}
