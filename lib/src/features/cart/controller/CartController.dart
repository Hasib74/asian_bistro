import 'dart:convert';

import 'package:get/get.dart';
import 'package:pizza_user_app/src/features/product_details/model/extra_items_response_model.dart';
import 'package:pizza_user_app/src/features/product_details/model/product_size_response_model.dart';

import '../../../core/database/local/LocalDataSourceController.dart';
import '../../all_products/data/domain/model/product_model.dart';
import '../domain/model/cart_model.dart';

class CartController extends GetxController {
  RxList<Cart> cartLst = <Cart>[].obs;

  RxDouble amount = 0.0.obs;

  static CartController to = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  RxInt totalQuantity() {
    RxInt totalQuantity = 0.obs;
    for (var element in cartLst) {
      totalQuantity += int.parse(element.count.toString());
    }
    return totalQuantity;
  }

  addToCart({ProductNames? productNames, var count, var price}) {
    print("Adding extra items : ${productNames?.extraItems}");

    print("Size Id : ${productNames?.productSize}");

    bool _isAlreadyAdded = false;
    _isAlreadyAdded = isAlreadyAddedToCart(productNames ?? ProductNames());
    if (_isAlreadyAdded == false) {
      print("Already Ok");
      cartLst.add(Cart(
        productNames: productNames,
        count: count,
        price: price,
      ));
      LocalDataSourceController.to.storeCart(cartLst.value);
    }
    update();
  }

  isAlreadyHaveIntoCartV2(String? productNameId) {
    bool _value = false;
    cartLst.forEach((element) {
      if (element.productNames?.product_name_id.toString() ==
          productNameId.toString()) {
        _value = true;
      }
    });
    return _value;
  }

  isAlreadyAddedToCart(ProductNames productNames) {
    bool _value = false;
    cartLst.forEach((element) {
      //  print("Elements ${element.productNames.id}");

      if (element.productNames?.product_name_id ==
          productNames.product_name_id) {
        print("Already Have");
        _value = true;
      }
    });

    //   print("isAlreadyAddedToCart ${_value}");

    Future.delayed(Duration.zero).then((value) {
      update();
    });

    return _value;
  }

  getCart() {
    try {
      var response = LocalDataSourceController.to.getCartList();

      printInfo(info: "GetCart =>> ${response}");

      List data = jsonDecode(response);

      data.forEach((element) {
        printInfo(info: "GetCart CARTLIST 12 =>> ${element}");

        var body = jsonDecode(element);
        cartLst.add(new Cart(
          count: body["qty"],
          price: body["price"],
          productNames: ProductNames.fromJson(body[
              "productname"]), /*vendorType: Vendor.fromJson(body["vendorType"])*/
        ));
      });

      printInfo(info: "GetCart CARTLIST 11 =>> ${data}");
      printInfo(info: "GetCart CARTLIST 13 =>> ${cartLst.length}");
      printInfo(
          info: "GetCart CARTLIST =>> ${jsonDecode(data[0])["productname"]}");

      refresh();
    } catch (err) {}
  }

  deleteExtraItems({String? productNameId, String? extraItemId}) {
    print("Extra Item Id  == ${extraItemId}");
    var cart = cartLst
        .where((p0) => p0.productNames?.product_name_id == productNameId)
        .first;

    print("Product Names  == ${cart}");

    cart.productNames?.extraItems
        ?.removeWhere((element) => element.extraItemId == extraItemId);

    LocalDataSourceController.to.storeCart(cartLst.value);
    CartController.to.totalAmount();
    update();
  }

  updateCart(Cart cart, int count, var price, {bool isRemoved = false}) {
    print("Is Removed  ??  ${isRemoved}");
    if (isRemoved == false) {
      print("Already Ok Cart Id  == ${cart.productNames?.product_name_id}");
      print("Array Length  == ${cartLst.length}");
      print("Count  == ${count}");

      int index = cartLst.indexWhere((element) =>
          element.productNames?.product_name_id ==
          cart.productNames?.product_name_id);

      print("Index Number  =>> ${index}");

      cartLst[index] = new Cart(
        productNames: cart.productNames,
        count: count,
        price:
            price, /*vendorType: VendorOfferController.to.selectedVendor.value*/
      );
      LocalDataSourceController.to.storeCart(cartLst.value);
      CartController.to.totalAmount();
    } else {
      print("Already Ok Cart Id  == ${cart.productNames?.product_name_id}");
      print("Array Length  == ${cartLst.length}");
      print("Count  == ${count}");

      int index = cartLst.indexWhere((element) =>
          element.productNames?.product_name_id ==
          cart.productNames?.product_name_id);

      print("Index Number  =>> ${index}");

      cartLst.removeAt(index);

      print("Array Length  after remove == ${cartLst.length}");

      LocalDataSourceController.to.storeCart(cartLst.value);
      CartController.to.totalAmount();
    }

    update();
  }

  clearCart() {
    cartLst.clear();
    LocalDataSourceController.to.clearCart();
    update();
  }

  updateCartItemSelectedSizePrice(String? productNameId, String? price) async {
    printInfo(info: "Product Name Id  == ${productNameId}");
    printInfo(info: "Price  == ${price}");

    var cartIndex = cartLst.indexWhere((element) =>
        element.productNames?.product_name_id.toString() == productNameId);

    printInfo(info: "Cart Index  == ${cartIndex}");

    cartLst[cartIndex].productNames?.price = price;
    LocalDataSourceController.to.storeCart(cartLst);
    CartController.to.totalAmount();
    // update();
  }

  totalAmount({bool isPlus = true}) {
    try {
      List<Cart> _temp_cart_list = [];
      var response = LocalDataSourceController.to.getCartList();
      printInfo(info: "GetCart =>> ${response}");

      List data = jsonDecode(response);

      data.forEach((element) {
        printInfo(info: "GetCart CARTLIST 12 =>> ${element}");
        var body = jsonDecode(element);
        _temp_cart_list.add(new Cart(
          count: body["qty"],
          price: body["price"],
          productNames: ProductNames.fromJson(body[
              "productname"]), /*   vendorType: VendorOfferController.to.selectedVendor.value*/
        ));
      });

      printInfo(info: "_temp_cart_list  ${_temp_cart_list.length}");
      amount(0.0);

      _temp_cart_list.forEach((element) {
        amount.value += double.parse((int.parse(element.count.toString()) *
                double.parse(element.productNames?.sizePrice ??
                    element.productNames?.price ??
                    "0.0"))
            .toString());
        /* if (isPlus) {
          print("Amount ==> ${element.price}");

        }*/
      });

      print("The total amount ======> one --> ${amount.value}");

      _temp_cart_list.forEach((element) {
        printInfo(
            info: "Extra Items price == ${element.productNames?.extraItems}");
        amount.value += double.parse(element.productNames?.extraItems
                ?.map((e) => e.extraItemPrice)
                .reduce((value, element) =>
                    "${double.parse(value!) + double.parse(element!)}") ??
            "0");
      });

      print("The total amount ======> ${amount.value}");

/*      _temp_cart_list.forEach((element) {
        print("Cart Size price 666: ${element.productNames?.sizePrice}");
        amount.value += double.parse(element.productNames?.sizePrice ?? "0.0");
      });*/
    } catch (err) {
      return null;
    }
  }

  void removeAllExtraItems(product_name_id) {
    var cart = cartLst
        .where((p0) => p0.productNames?.product_name_id == product_name_id)
        .first;

    cart.productNames?.extraItems?.clear();
    LocalDataSourceController.to.storeCart(cartLst.value);
    CartController.to.totalAmount();
    update();
  }

  void addExtraItems(ProductExtraItem e, Cart cart) {
    var cartIndex = cartLst.indexWhere((element) =>
        element.productNames?.product_name_id ==
        cart.productNames?.product_name_id);

    print("Cart Index  == ${cartIndex}");

    if (cartIndex != -1) {
      cartLst[cartIndex].productNames?.extraItems?.add(ExtraItemsModel(
          extraItemId: e.id.toString(),
          extraItemName: e.name,
          extraItemPrice: e.price,
          extraItemImage: e.image));
      LocalDataSourceController.to.storeCart(cartLst.value);
      CartController.to.totalAmount();
    }
    update();
  }

  void removeExtraItems(ProductExtraItem e, Cart cart) {
    // remove extra items
    var cartIndex = cartLst.indexWhere((element) =>
        element.productNames?.product_name_id ==
        cart.productNames?.product_name_id);

    cartLst[cartIndex]
        .productNames
        ?.extraItems
        ?.removeWhere((element) => element.extraItemId == e.id.toString());
    LocalDataSourceController.to.storeCart(cartLst.value);
    CartController.to.totalAmount();
    update();
  }

  updateSize(ProductSize e, Cart cart) {
    var cartIndex = cartLst.indexWhere((element) =>
        element.productNames?.product_name_id ==
        cart.productNames?.product_name_id);

    // cartLst[cartIndex].productNames?.productSize = e;
    cartLst[cartIndex].productNames?.sizeName = e.name;

    print("Cart size price 1: ${e.sizePrice}");
    cartLst[cartIndex].productNames?.sizePrice = e.sizePrice;

    printInfo(
        info:
            "After saving to storage ${cartLst[cartIndex].productNames?.sizePrice}");

    LocalDataSourceController.to.storeCart(cartLst);
    CartController.to.totalAmount();
    update();
  }

  void clearData() {
    amount.value = 0.0;
    update();
  }
/*  getSelectedSizePrice(ProductSize e, Cart cart){

    return

  }*/
}
