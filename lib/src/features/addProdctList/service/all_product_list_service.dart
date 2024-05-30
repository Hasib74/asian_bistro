import 'dart:convert';

import 'package:pizza_user_app/src/core/remote/urls/app_urls.dart';

import '../model/all_product_list_model.dart';
import 'package:http/http.dart' as http;

class AllProductListService {
  Future<AllProductListModel?> getAllProductList() async {
    AllProductListModel? allProductListModel;
    try {
      await http
          .get(Uri.parse(
              '${ApiUrls.base_url}product/list'))
          .then((value) {


        if (value.statusCode == 200) {

          print(value.body);
          allProductListModel =
              AllProductListModel.fromJson(jsonDecode(value.body));

          print("All Product List ${allProductListModel?.response?.length}");
        } else {
          allProductListModel = null;
        }
      });

    } on Exception catch (e) {
      // TODO
      print("Exception in sign in controller ${e.toString()}");
    }

    return allProductListModel;
  }
}
