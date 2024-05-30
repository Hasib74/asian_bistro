class ProductType {
  String? success;
  List<Message>? message;
  var statusCode;

  ProductType({this.success, this.message, this.statusCode});

  ProductType.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message?.add(new Message.fromJson(v));
      });
    }
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message?.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Message {
  var id;
  String? productTypeName;
  var isActive;
  var providerId;
  var serviceTypeId;
  List<ProductNames>? productNames;

  var image;

  Message({
    this.id,
    this.productTypeName,
    this.isActive,
    this.providerId,
    this.serviceTypeId,
    this.productNames,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productTypeName = json['product_type_name'];
    isActive = json['is_active'];
    providerId = json['provider_id'];
    serviceTypeId = json['service_type_id'];
    image = json['image'];
    if (json['product_names'] != null) {
      productNames = <ProductNames>[];
      json['product_names'].forEach((v) {
        productNames?.add(new ProductNames.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_type_name'] = this.productTypeName;
    data['is_active'] = this.isActive;
    data['provider_id'] = this.providerId;
    data['service_type_id'] = this.serviceTypeId;
    if (this.productNames != null) {
      data['product_names'] = this.productNames?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductNames {
  var product_name_id;
  String? productName;
  String? code;
  String? description;
  var price;
  var imagePath;
  var productTypeId;
  var isActive;
  var offer_amount;

  ProductNames(
      {this.product_name_id,
        this.productName,
        this.code,
        this.description,
        this.price,
        this.imagePath,
        this.productTypeId,
        this.isActive});

  ProductNames.fromJson(Map<String, dynamic> json) {
    product_name_id = json['product_name_id'];
    productName = json['product_name'];
    code = json['code'];
    description = json['description'];
    price = json['price'];
    imagePath = json['imagePath'];
    productTypeId = json['product_type_id'];
    isActive = json['is_active'];
    offer_amount = json["offer_amount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name_id'] = this.product_name_id;
    data['product_name'] = this.productName;
    data['code'] = this.code;
    data['description'] = this.description;
    data['price'] = this.price;
    data['imagePath'] = this.imagePath;
    data['product_type_id'] = this.productTypeId;
    data['is_active'] = this.isActive;
    return data;
  }
}
