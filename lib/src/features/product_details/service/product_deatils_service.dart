import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pizza_user_app/src/core/remote/app_helper/app_remote_helper.dart';
import 'package:pizza_user_app/src/features/auth/controller/auth_controller.dart';

import '../../../core/remote/urls/app_urls.dart';

class ProductDetailsService {
  Future<http.Response?> getProductExtraItems(dynamic id) async {
    printInfo(info: "ProductDetailsService.getProductExtraItems");
    /* await http.post(Uri.parse(ApiUrls.extraItems),
        body: jsonEncode({"product_name_id": id}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthController.to.token}"
        });*/

    return await ApiClient.Request(
        url: ApiUrls.extraItems,
        method: Method.POST,
        body: {"product_name_id": id},
        enableHeader: true,
        isContentTypeJson: false);
  }

  Future<http.Response?> getProductSize(dynamic id) async {
    printInfo(info: "ProductDetailsService.getProductSize");
    /* await http.post(Uri.parse(ApiUrls.extraItems),
        body: jsonEncode({"product_name_id": id}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthController.to.token}"
        });*/

    return await ApiClient.Request(
        url: ApiUrls.getSize,
        method: Method.POST,
        body: {"product_name_id": id},
        enableHeader: true,
        isContentTypeJson: false);
  }
}
