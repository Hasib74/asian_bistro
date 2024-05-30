import '../../../all_products/data/domain/model/product_model.dart';

class Cart {
  var count;
  var price;


  ProductNames? productNames;

  Cart({this.productNames, this.count, this.price, });

  Cart.fromJson(Map<String, dynamic> json) {
    productNames = ProductNames.fromJson(json['productname']);
    count = json['qty'];
    price = json["price"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> productNameToJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['product_name_id'] = productNames?.product_name_id;
      data['product_name'] = productNames?.productName;
      data['code'] = productNames?.code;
      data['description'] = productNames?.description;
      data['price'] = productNames?.price;
      data['imagePath'] = productNames?.imagePath;
      data['product_type_id'] = productNames?.productTypeId;
      data['is_active'] = productNames?.isActive;
      return data;
    }

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productname'] = productNameToJson();
    data['qty'] = this.count;
    data["price"] = this.price;
    return data;
  }
}
