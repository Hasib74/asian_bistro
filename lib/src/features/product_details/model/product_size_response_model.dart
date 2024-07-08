/// success : true
/// data : [{"product_name_id":"1","product_name":"Extra Large","code":"PRO-745080","description":"Cheese pizza","price":"11.99","quantity":"171","imagePath":"uploads/products_photos/1707153035.jpeg","product_type_id":"1","offer_amount":null,"is_active":"1","summer_offer_status":"1","winter_offer_status":"0","product_size":[{"id":2,"name":"Small","size_price":null},{"id":3,"name":"Medium","size_price":null},{"id":4,"name":"Large","size_price":null}]}]
/// status_code : 200

class ProductSizeResponseModel {
  ProductSizeResponseModel({
      this.success, 
      this.data, 
      this.statusCode,});

  ProductSizeResponseModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    statusCode = json['status_code'];
  }
  bool? success;
  List<Data>? data;
  num? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['status_code'] = statusCode;
    return map;
  }

}

/// product_name_id : "1"
/// product_name : "Extra Large"
/// code : "PRO-745080"
/// description : "Cheese pizza"
/// price : "11.99"
/// quantity : "171"
/// imagePath : "uploads/products_photos/1707153035.jpeg"
/// product_type_id : "1"
/// offer_amount : null
/// is_active : "1"
/// summer_offer_status : "1"
/// winter_offer_status : "0"
/// product_size : [{"id":2,"name":"Small","size_price":null},{"id":3,"name":"Medium","size_price":null},{"id":4,"name":"Large","size_price":null}]

class Data {
  Data({
      this.productNameId, 
      this.productName, 
      this.code, 
      this.description, 
      this.price, 
      this.quantity, 
      this.imagePath, 
      this.productTypeId, 
      this.offerAmount, 
      this.isActive, 
      this.summerOfferStatus, 
      this.winterOfferStatus, 
      this.productSize,});

  Data.fromJson(dynamic json) {
    productNameId = json['product_name_id'];
    productName = json['product_name'];
    code = json['code'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    imagePath = json['imagePath'];
    productTypeId = json['product_type_id'];
    offerAmount = json['offer_amount'];
    isActive = json['is_active'];
    summerOfferStatus = json['summer_offer_status'];
    winterOfferStatus = json['winter_offer_status'];
    if (json['product_size'] != null) {
      productSize = [];
      json['product_size'].forEach((v) {
        productSize?.add(ProductSize.fromJson(v));
      });
    }
  }
  String? productNameId;
  String? productName;
  String? code;
  String? description;
  String? price;
  String? quantity;
  String? imagePath;
  String? productTypeId;
  dynamic offerAmount;
  String? isActive;
  String? summerOfferStatus;
  String? winterOfferStatus;
  List<ProductSize>? productSize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_name_id'] = productNameId;
    map['product_name'] = productName;
    map['code'] = code;
    map['description'] = description;
    map['price'] = price;
    map['quantity'] = quantity;
    map['imagePath'] = imagePath;
    map['product_type_id'] = productTypeId;
    map['offer_amount'] = offerAmount;
    map['is_active'] = isActive;
    map['summer_offer_status'] = summerOfferStatus;
    map['winter_offer_status'] = winterOfferStatus;
    if (productSize != null) {
      map['product_size'] = productSize?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// name : "Small"
/// size_price : null

class ProductSize {
  ProductSize({
      this.id, 
      this.name, 
      this.sizePrice,});

  ProductSize.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    sizePrice = json['size_price'];
  }
  num? id;
  String? name;
  dynamic sizePrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['size_price'] = sizePrice;
    return map;
  }

}