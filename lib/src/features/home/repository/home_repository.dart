import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pizza_user_app/src/features/home/model/offer_product_model.dart';

import '../../../core/remote/urls/app_urls.dart';
import '../model/banner_model.dart';

class HomeRepository {
  Future<BannerModel?> getBanner() async {
    BannerModel? bannerModel;

    var _response = await http.get(Uri.parse(ApiUrls.banner));

    if (_response.statusCode == 200) {

      print("Banner resonse : ${_response.body}");
      bannerModel = BannerModel.fromJson(jsonDecode(_response.body));
      return bannerModel;
    } else {
      return null;
    }
  }

  Future<OfferProductModel?> getWinterOfferProduct() async {
    OfferProductModel? offerProductModel;

    var _response = await http.get(Uri.parse(ApiUrls.all_winter_offer));



    if (_response.statusCode == 200) {
      offerProductModel =
          OfferProductModel.fromJson(jsonDecode(_response.body));
      return offerProductModel;
    } else {
      return null;
    }
  }

  Future<OfferProductModel?> getSummerOfferProduct() async {
    OfferProductModel? offerProductModel;

    var _response = await http.get(Uri.parse(ApiUrls.all_summer_offer));
    print("Summer Offer Url : ${ApiUrls.all_summer_offer}");
    print("Summer Offer : ${_response.body}");
    if (_response.statusCode == 200) {


      offerProductModel =
          OfferProductModel.fromJson(jsonDecode(_response.body));
      return offerProductModel;
    } else {
      return null;
    }
  }
}
