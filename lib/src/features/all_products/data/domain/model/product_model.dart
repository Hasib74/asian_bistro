import 'package:pizza_user_app/src/features/product_details/model/extra_items_response_model.dart';

import '../../../../product_details/model/product_size_response_model.dart';

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
      data['product_names'] =
          this.productNames?.map((v) => v.toJson()).toList();
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
  var productSize;
  var sizeName;
  var sizePrice;

  List<ExtraItemsModel>? extraItems = [];
  List<ProductExtraItem>? totalExtraItems = [];

  List<ProductSize>? totalProductSizeList = [];

  ProductNames({
    this.product_name_id,
    this.productName,
    this.code,
    this.description,
    this.price,
    this.imagePath,
    this.productTypeId,
    this.isActive,
    this.extraItems,
    this.productSize,
    this.sizeName,
    this.totalExtraItems,
    this.totalProductSizeList,
    this.sizePrice
  });

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

    productSize = json["size_id"];

    sizeName = json["size_name"];

    sizePrice = json["size_price"] ;

    if (json['extraItems'] != null) {
      extraItems = <ExtraItemsModel>[];
      json['extraItems'].forEach((v) {
        extraItems?.add(new ExtraItemsModel.fromJson(v));
      });
    }

    if (json['totalExtraItems'] != null) {
      totalExtraItems = json['totalExtraItems'];
    }

    if (json['totalProductSizeList'] != null) {
      totalProductSizeList = <ProductSize>[];
      json['totalProductSizeList'].forEach((v) {
        totalProductSizeList?.add(new ProductSize.fromJson(v));
      });
    }
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
    data['size_id'] = this.productSize;
    data['size_price'] = this.sizePrice;
    data['size_name'] = this.sizeName;
    if (this.extraItems != null) {
      data['extraItems'] = this.extraItems?.map((v) => v.toJson()).toList();
    }

    if (this.totalExtraItems != null) {
      data['totalExtraItems'] =
          this.totalExtraItems?.map((v) => v.toJson()).toList();
    }

    if (this.totalProductSizeList != null) {
      data['totalProductSizeList'] =
          this.totalProductSizeList?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ExtraItemsModel {
  String? extraItemId;
  String? extraItemPrice;
  String? extraItemName;

  String? extraItemImage;

  ExtraItemsModel(
      {this.extraItemId,
        this.extraItemPrice,
        required this.extraItemName,
        required this.extraItemImage});

  ExtraItemsModel.fromJson(Map<String, dynamic> json) {
    extraItemId = json['extra_item_id'];
    extraItemPrice = json['extra_item_price'];
    extraItemName = json['extra_item_name'];
    extraItemImage = json['extra_item_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['extra_item_id'] = this.extraItemId;
    data['extra_item_price'] = this.extraItemPrice;
    data['extra_item_name'] = this.extraItemName;
    data['extra_item_image'] = this.extraItemImage;
    return data;
  }
}
