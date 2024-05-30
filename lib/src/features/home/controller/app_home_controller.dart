import 'package:get/get.dart';
import 'package:pizza_user_app/src/features/home/model/banner_model.dart';
import 'package:pizza_user_app/src/features/home/repository/home_repository.dart';

import '../model/offer_product_model.dart';

class AppHomeController extends GetxController {
  HomeRepository homeRepository = HomeRepository();

  static AppHomeController to = Get.find();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<BannerModel?> getAllBanner() async {
    try {
      isLoading.value = true;

      var _bannerModel = await homeRepository.getBanner();

      isLoading.value = false;

      return _bannerModel;
    } on Exception catch (e) {
      // TODO

      isLoading.value = false;

      return null;
    }
  }

  Future<OfferProductModel?> getWinterOfferProduct() async {
    try {
      isLoading.value = true;

      var _offerProductModel = await homeRepository.getWinterOfferProduct();

      print("Winter Offer : ${_offerProductModel?.response?.length}");



      isLoading.value = false;

      return _offerProductModel;
    } on Exception catch (e) {
      // TODO
    }

    isLoading.value = false;
    return null;
  }

  Future<OfferProductModel?> getSummerOfferProduct() async {
    try {
      isLoading.value = true;

      var _offerProductModel = await homeRepository.getSummerOfferProduct();

      isLoading.value = false;

      return _offerProductModel;
    } on Exception catch (e) {
      // TODO

      isLoading.value = false;
      return null;
    }
  }
}
