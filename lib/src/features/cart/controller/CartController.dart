import 'dart:convert';

import 'package:get/get.dart';

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

  addToCart({ProductNames? productNames, var count, var price}) {
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
                double.parse(element.price.toString()))
            .toString());
        /* if (isPlus) {
          print("Amount ==> ${element.price}");

        }*/
      });
    } catch (err) {
      return null;
    }
  }
}
