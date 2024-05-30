/// response : [{"product_name_id":2,"product_name":"Half Grill","code":"s-2233","description":"test","price":"150.00000","quantity":0,"imagePath":"","product_type_id":2,"offer_amount":null,"is_active":1,"summer_offer_status":1,"winter_offer_status":0}]
/// message : "Successfully retrieved products"

class OfferProductModel {
  OfferProductModel({
    List<Response>? response,
    String? message,}){
    _response = response;
    _message = message;
  }

  OfferProductModel.fromJson(dynamic json) {
    if (json['response'] != null) {
      _response = [];
      json['response'].forEach((v) {
        _response?.add(Response.fromJson(v));
      });
    }
    _message = json['message'];
  }
  List<Response>? _response;
  String? _message;
  OfferProductModel copyWith({  List<Response>? response,
    String? message,
  }) => OfferProductModel(  response: response ?? _response,
    message: message ?? _message,
  );
  List<Response>? get response => _response;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_response != null) {
      map['response'] = _response?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// product_name_id : 2
/// product_name : "Half Grill"
/// code : "s-2233"
/// description : "test"
/// price : "150.00000"
/// quantity : 0
/// imagePath : ""
/// product_type_id : 2
/// offer_amount : null
/// is_active : 1
/// summer_offer_status : 1
/// winter_offer_status : 0

class Response {
  Response({
    var productNameId,
    String? productName,
    String? code,
    String? description,
    String? price,
    var quantity,
    String? imagePath,
    var productTypeId,
    dynamic offerAmount,
    var isActive,
    var summerOfferStatus,
    var winterOfferStatus,}){
    _productNameId = productNameId;
    _productName = productName;
    _code = code;
    _description = description;
    _price = price;
    _quantity = quantity;
    _imagePath = imagePath;
    _productTypeId = productTypeId;
    _offerAmount = offerAmount;
    _isActive = isActive;
    _summerOfferStatus = summerOfferStatus;
    _winterOfferStatus = winterOfferStatus;
  }

  Response.fromJson(dynamic json) {
    _productNameId = json['product_name_id'];
    _productName = json['product_name'];
    _code = json['code'];
    _description = json['description'];
    _price = json['price'];
    _quantity = json['quantity'];
    _imagePath = json['imagePath'];
    _productTypeId = json['product_type_id'];
    _offerAmount = json['offer_amount'];
    _isActive = json['is_active'];
    _summerOfferStatus = json['summer_offer_status'];
    _winterOfferStatus = json['winter_offer_status'];
  }
  var _productNameId;
  String? _productName;
  String? _code;
  String? _description;
  String? _price;
  var _quantity;
  String? _imagePath;
  var _productTypeId;
  dynamic _offerAmount;
  var _isActive;
  var _summerOfferStatus;
  var _winterOfferStatus;
  Response copyWith({  var productNameId,
    String? productName,
    String? code,
    String? description,
    String? price,
    var quantity,
    String? imagePath,
    var productTypeId,
    dynamic offerAmount,
    var isActive,
    var summerOfferStatus,
    var winterOfferStatus,
  }) => Response(  productNameId: productNameId ?? _productNameId,
    productName: productName ?? _productName,
    code: code ?? _code,
    description: description ?? _description,
    price: price ?? _price,
    quantity: quantity ?? _quantity,
    imagePath: imagePath ?? _imagePath,
    productTypeId: productTypeId ?? _productTypeId,
    offerAmount: offerAmount ?? _offerAmount,
    isActive: isActive ?? _isActive,
    summerOfferStatus: summerOfferStatus ?? _summerOfferStatus,
    winterOfferStatus: winterOfferStatus ?? _winterOfferStatus,
  );
  get productNameId => _productNameId;
  String? get productName => _productName;
  String? get code => _code;
  String? get description => _description;
  String? get price => _price;
  get quantity => _quantity;
  String? get imagePath => _imagePath;
  get productTypeId => _productTypeId;
  dynamic get offerAmount => _offerAmount;
  get isActive => _isActive;
  get summerOfferStatus => _summerOfferStatus;
  get winterOfferStatus => _winterOfferStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_name_id'] = _productNameId;
    map['product_name'] = _productName;
    map['code'] = _code;
    map['description'] = _description;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['imagePath'] = _imagePath;
    map['product_type_id'] = _productTypeId;
    map['offer_amount'] = _offerAmount;
    map['is_active'] = _isActive;
    map['summer_offer_status'] = _summerOfferStatus;
    map['winter_offer_status'] = _winterOfferStatus;
    return map;
  }

}