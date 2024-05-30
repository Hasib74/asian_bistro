/// success : "true"
/// status_code : "200"
/// message : {"order":{"service_provider_id":"3","customer_id":1,"total_amount":"-9.152000000000015","offer_id":"1","discount":"104","delivery_fee":"0","paid_amount":"228.8","payment_type":null,"payment_status":"pending","customer_payment_id":"","order_address":"1600 Amphitheatre Pkwy,,Mountain View,United States","order_datetime":"2022-04-18T18:50:02.997689Z","delivery_man_id":null,"order_code":"OR-11","updated_at":"2022-04-18T18:50:02.000000Z","created_at":"2022-04-18T18:50:02.000000Z","id":11},"orderDetails":[{"product_name_id":"2","quantity":"1","amount":"228.8"}]}

class OrderSuccessModel {
  OrderSuccessModel({
    String? success,
    String? statusCode,
    Message? message,
  }) {
    _success = success!;
    _statusCode = statusCode!;
    _message = message!;
  }

  OrderSuccessModel.fromJson(dynamic json) {
    _success = json['success'];
    _statusCode = json['status_code'];
    _message =
        (json['message'] != null ? Message.fromJson(json['message']) : null)!;
  }

  String? _success;
  String? _statusCode;
  Message? _message;

  String? get success => _success;

  String? get statusCode => _statusCode;

  Message? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['status_code'] = _statusCode;
    final _message = this._message;
    if (_message != null) {
      map['message'] = _message.toJson();
    }
    return map;
  }
}

/// order : {"service_provider_id":"3","customer_id":1,"total_amount":"-9.152000000000015","offer_id":"1","discount":"104","delivery_fee":"0","paid_amount":"228.8","payment_type":null,"payment_status":"pending","customer_payment_id":"","order_address":"1600 Amphitheatre Pkwy,,Mountain View,United States","order_datetime":"2022-04-18T18:50:02.997689Z","delivery_man_id":null,"order_code":"OR-11","updated_at":"2022-04-18T18:50:02.000000Z","created_at":"2022-04-18T18:50:02.000000Z","id":11}
/// orderDetails : [{"product_name_id":"2","quantity":"1","amount":"228.8"}]

class Message {
  Message({
    Order? order,
    List<OrderDetails>? orderDetails,
  }) {
    _order = order!;
    _orderDetails = orderDetails!;
  }

  Message.fromJson(dynamic json) {
    _order = (json['order'] != null ? Order.fromJson(json['order']) : null)!;
    if (json['orderDetails'] != null) {
      _orderDetails = [];
      json['orderDetails'].forEach((v) {
        _orderDetails?.add(OrderDetails.fromJson(v));
      });
    }
  }

  Order? _order;
  List<OrderDetails>? _orderDetails;

  Order? get order => _order;

  List<OrderDetails>? get orderDetails => _orderDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _order = this._order;
    if (_order != null) {
      map['order'] = _order.toJson();
    }
    final _orderDetails = this._orderDetails;
    if (_orderDetails != null) {
      map['orderDetails'] = _orderDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// product_name_id : "2"
/// quantity : "1"
/// amount : "228.8"

class OrderDetails {
  OrderDetails({
    String? productNameId,
    String? quantity,
    String? amount,
  }) {
    _productNameId = productNameId!;
    _quantity = quantity!;
    _amount = amount!;
  }

  OrderDetails.fromJson(dynamic json) {
    _productNameId = json['product_name_id'];
    _quantity = json['quantity'];
    _amount = json['amount'];
  }

  String? _productNameId;
  String? _quantity;
  String? _amount;

  String? get productNameId => _productNameId;

  String? get quantity => _quantity;

  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_name_id'] = _productNameId;
    map['quantity'] = _quantity;
    map['amount'] = _amount;
    return map;
  }
}

/// service_provider_id : "3"
/// customer_id : 1
/// total_amount : "-9.152000000000015"
/// offer_id : "1"
/// discount : "104"
/// delivery_fee : "0"
/// paid_amount : "228.8"
/// payment_type : null
/// payment_status : "pending"
/// customer_payment_id : ""
/// order_address : "1600 Amphitheatre Pkwy,,Mountain View,United States"
/// order_datetime : "2022-04-18T18:50:02.997689Z"
/// delivery_man_id : null
/// order_code : "OR-11"
/// updated_at : "2022-04-18T18:50:02.000000Z"
/// created_at : "2022-04-18T18:50:02.000000Z"
/// id : 11

class Order {
  Order({
    String? serviceProviderId,
    var customerId,
    String? totalAmount,
    String? offerId,
    String? discount,
    String? deliveryFee,
    String? paidAmount,
    dynamic paymentType,
    String? paymentStatus,
    String? customerPaymentId,
    String? orderAddress,
    String? orderDatetime,
    dynamic deliveryManId,
    String? orderCode,
    String? updatedAt,
    String? createdAt,
    var id,
  }) {
    _serviceProviderId = serviceProviderId;
    _customerId = customerId;
    _totalAmount = totalAmount;
    _offerId = offerId;
    _discount = discount;
    _deliveryFee = deliveryFee;
    _paidAmount = paidAmount;
    _paymentType = paymentType;
    _paymentStatus = paymentStatus;
    _customerPaymentId = customerPaymentId;
    _orderAddress = orderAddress;
    _orderDatetime = orderDatetime;
    _deliveryManId = deliveryManId;
    _orderCode = orderCode;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Order.fromJson(dynamic json) {
    _serviceProviderId = json['service_provider_id'];
    _customerId = json['customer_id'];
    _totalAmount = json['total_amount'];
    _offerId = json['offer_id'];
    _discount = json['discount'];
    _deliveryFee = json['delivery_fee'];
    _paidAmount = json['paid_amount'];
    _paymentType = json['payment_type'];
    _paymentStatus = json['payment_status'];
    _customerPaymentId = json['customer_payment_id'];
    _orderAddress = json['order_address'];
    _orderDatetime = json['order_datetime'];
    _deliveryManId = json['delivery_man_id'];
    _orderCode = json['order_code'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }

  var _serviceProviderId;
  var _customerId;
  var _totalAmount;
  var _offerId;
  var _discount;
  var _deliveryFee;
  var _paidAmount;
  var _paymentType;
  var _paymentStatus;
  var _customerPaymentId;
  var _orderAddress;
  var _orderDatetime;
  var _deliveryManId;
  var _orderCode;
  var _updatedAt;
  var _createdAt;
  var _id;

  String get serviceProviderId => _serviceProviderId;

  int get customerId => _customerId;

  String get totalAmount => _totalAmount;

   get offerId => _offerId;

  String get discount => _discount;

  String get deliveryFee => _deliveryFee;

  String get paidAmount => _paidAmount;

  dynamic get paymentType => _paymentType;

  String get paymentStatus => _paymentStatus;

  String get customerPaymentId => _customerPaymentId;

  String get orderAddress => _orderAddress;

  String get orderDatetime => _orderDatetime;

  dynamic get deliveryManId => _deliveryManId;

  String get orderCode => _orderCode;

  String get updatedAt => _updatedAt;

  String get createdAt => _createdAt;

  int get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_provider_id'] = _serviceProviderId;
    map['customer_id'] = _customerId;
    map['total_amount'] = _totalAmount;
    map['offer_id'] = _offerId;
    map['discount'] = _discount;
    map['delivery_fee'] = _deliveryFee;
    map['paid_amount'] = _paidAmount;
    map['payment_type'] = _paymentType;
    map['payment_status'] = _paymentStatus;
    map['customer_payment_id'] = _customerPaymentId;
    map['order_address'] = _orderAddress;
    map['order_datetime'] = _orderDatetime;
    map['delivery_man_id'] = _deliveryManId;
    map['order_code'] = _orderCode;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
