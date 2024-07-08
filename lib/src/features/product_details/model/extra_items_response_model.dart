/// success : true
/// data : [{"product_name_id":39,"product_name":"Ice Cream 4324","code":"PRO-186973","description":"fdfgh","price":"122.00","quantity":"1000","imagePath":"uploads/products_photos/1712410201.png","product_type_id":"10","offer_amount":null,"is_active":"1","summer_offer_status":"0","winter_offer_status":"0","product_extra_item":[{"id":1,"name":"Extra Chese","price":"100","image":"uploads/products_photos/1711821586.png"},{"id":3,"name":"Test Extra","price":"100","image":"uploads/products_photos/1711905393.png"}]}]
/// status_code : 200

class ExtraItemsResponseModel {
  ExtraItemsResponseModel({
      this.success, 
      this.data, 
      this.statusCode,});

  ExtraItemsResponseModel.fromJson(dynamic json) {
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

/// product_name_id : 39
/// product_name : "Ice Cream 4324"
/// code : "PRO-186973"
/// description : "fdfgh"
/// price : "122.00"
/// quantity : "1000"
/// imagePath : "uploads/products_photos/1712410201.png"
/// product_type_id : "10"
/// offer_amount : null
/// is_active : "1"
/// summer_offer_status : "0"
/// winter_offer_status : "0"
/// product_extra_item : [{"id":1,"name":"Extra Chese","price":"100","image":"uploads/products_photos/1711821586.png"},{"id":3,"name":"Test Extra","price":"100","image":"uploads/products_photos/1711905393.png"}]

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
      this.productExtraItem,});

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
    if (json['product_extra_item'] != null) {
      productExtraItem = [];
      json['product_extra_item'].forEach((v) {
        productExtraItem?.add(ProductExtraItem.fromJson(v));
      });
    }
  }
  num? productNameId;
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
  List<ProductExtraItem>? productExtraItem;

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
    if (productExtraItem != null) {
      map['product_extra_item'] = productExtraItem?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "Extra Chese"
/// price : "100"
/// image : "uploads/products_photos/1711821586.png"

class ProductExtraItem {
  ProductExtraItem({
      this.id, 
      this.name, 
      this.price, 
      this.image,});

  ProductExtraItem.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
  }
  num? id;
  String? name;
  String? price;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['image'] = image;
    return map;
  }

}