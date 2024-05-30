import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/domain/model/token.dart';
import '../../../features/cart/domain/model/cart_model.dart';

class LocalDataSourceController extends GetxController {
  SharedPreferences? sp;

  static LocalDataSourceController to = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit

    spInit();
    super.onInit();
  }

  void spInit() async {
    sp = await SharedPreferences.getInstance();

    printInfo(info: "SP ${sp}");
  }

  void setSelectedServiceName(String serviceName) async {
    sp?.setString('service_name', serviceName);
  }

  Future<String?> getSelectedServiceName() async {
    print("your service name ${sp?.get('service_name')}");
    return sp?.getString('service_name');
  }

  void clearCart() {
    sp?.remove(LocalKey.cart_list);
  }

  void storeCart(List<Cart> cartLst) {
    print("LocalDataSourceController :: = > Encoded ");
    try {
      print("LocalDataSourceController :: = > Encoded ${jsonEncode(cartLst)}");

      List<String> cartList = [];

      cartLst.forEach((element) {
        cartList.add(jsonEncode(element.toJson()));
      });

      sp?.setString(LocalKey.cart_list, jsonEncode(cartList));
    } catch (err) {
      print("LocalDataSourceController :: = > Encoded Error ${err}");
    }
  }

  getCartList() {
    try {
      return sp?.getString(LocalKey.cart_list);
    } catch (err) {
      return null;
    }
  }

  setToken(Token token) async {
    sp = await SharedPreferences.getInstance();

    sp?.setString(LocalKey.token, jsonEncode(token));
  }

  Future<Token?> getToken() async {
    try {
      printInfo(info: "SPPP ${sp}");
      sp = await SharedPreferences.getInstance();

      var data = sp?.getString(LocalKey.token);
      print("Token data ===> ${data}");
      if (data == null) {
        return null;
      } else {
        return Token.fromJson(jsonDecode(data));
      }
    } catch (err) {
      return null;
    }
  }
}


class LocalKey {
  static String vendor_offer = "vendor_offer";
  static String vendor_type = "vendor_offer";
  static String cart_list = "Cart List";
  static String sign_up = "Sign Up";
  static String token = "token";
}
