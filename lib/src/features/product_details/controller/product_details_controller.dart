import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/features/cart/controller/CartController.dart';
import 'package:pizza_user_app/src/features/product_details/model/product_size_response_model.dart';
import 'package:pizza_user_app/src/features/product_details/model/product_size_response_model.dart'
    as sizeModel;
import 'package:pizza_user_app/src/features/product_details/service/product_deatils_service.dart';

import '../model/extra_items_response_model.dart';
import '../model/extra_items_response_model.dart' as model;

class ProductDetailsController extends GetxController {
  static ProductDetailsController get to => Get.find();

  ProductDetailsService productDetailsService = ProductDetailsService();

  var extraItemsResponseModel = ExtraItemsResponseModel().obs;

  var selectedExtraItems = <model.ProductExtraItem>[].obs;

  var productSizeResponseModel = ProductSizeResponseModel().obs;

  Rx<sizeModel.ProductSize?> selectedSize = sizeModel.ProductSize().obs;

  setSelectedExtraItems(model.ProductExtraItem item) {
    if (selectedExtraItems.value.contains(item)) {
      selectedExtraItems.value.remove(item);
    } else {
      selectedExtraItems.value.add(item);
    }

    selectedExtraItems.refresh();
  }

  getProductExtraItems(dynamic id) async {
    selectedExtraItems.clear();
    extraItemsResponseModel.value = ExtraItemsResponseModel();

    var data = await productDetailsService.getProductExtraItems(id);

    print("Extra Items Response Model ${data}");

    if (data == null) {
      return;
    }

    extraItemsResponseModel.value =
        ExtraItemsResponseModel.fromJson(jsonDecode(data.body));



  }

  getProductSize(dynamic id) async {
    selectedExtraItems.clear();
    productSizeResponseModel.value = ProductSizeResponseModel();

    var data = await productDetailsService.getProductSize(id);

    print("Extra Items Response Model ${data}");

    if (data == null) {
      return;
    }

    productSizeResponseModel.value =
        ProductSizeResponseModel.fromJson(jsonDecode(data.body));

    if (productSizeResponseModel.value.data != null &&
        productSizeResponseModel.value.data?.isNotEmpty == true) {
      selectedSize.value =
          productSizeResponseModel.value.data![0].productSize![0];
    }
  }

  void setIntialSelectedExtraItemsAndSize(String? productId) {
    CartController.to.cartLst.forEach((element) {
      if (element.productNames?.product_name_id == productId) {
        selectedExtraItems.value = element.productNames?.extraItems
                ?.map((e) => ProductExtraItem(
                    id: num.parse(e.extraItemId.toString()),
                    name: e.extraItemName,
                    price: e.extraItemPrice,
                    image: e.extraItemImage))
                .toList() ??
            [];
        selectedSize.value = element.productNames?.totalProductSizeList
                ?.where(
                    (size) => size.name == element.productNames?.sizeName)
                .first ??
            ProductSize();


        selectedExtraItems.refresh() ;
        selectedSize.refresh() ;


        printInfo(info: "Selected Extra Items ===> ${selectedExtraItems.length}");
      }
    });
  }
}
