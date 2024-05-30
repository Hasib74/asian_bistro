import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:pizza_user_app/src/core/Network/network_info.dart';
import 'package:pizza_user_app/src/features/Authentication/SignIn/Controller/SignInController.dart';
import 'package:pizza_user_app/src/features/Authentication/SignUp/Controller/SignUpController.dart';
import 'package:pizza_user_app/src/features/ServiceType/Controller/ServiceTypeController.dart';
import 'package:pizza_user_app/src/features/all_products/controller/ProductListController.dart';
import 'package:pizza_user_app/src/features/auth/controller/auth_controller.dart';
import 'package:pizza_user_app/src/features/checkout_screen/controller/online_payment_controller.dart';
import 'package:pizza_user_app/src/features/home/controller/app_home_controller.dart';

import '../../../core/data/local_data/db/app_sqlite_database.dart';
import '../../../core/database/local/LocalDataSourceController.dart';
import '../../PickCurrentLocation/Controller/PickCurrentLocationController.dart';
import '../../cart/controller/CartController.dart';
import '../../checkout_screen/checkout_binding/check_out_binding.dart';
import '../../checkout_screen/controller/check_out_controller.dart';
import '../../profile/screen/EditProfileController/ProfileController.dart';
import '../controller/app_splash_controller.dart';

class AppSplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppSplashController());
    Get.put(NetworkInfoController());
    Get.put(AuthController());
    Get.put(LocalDataSourceController());
    Get.put(AppHomeController());

    Get.lazyPut(() => ServiceTypeController());

    Get.lazyPut<CheckOutController>(() => CheckOutController());
    Get.lazyPut<OnlinePaymentController>(() => OnlinePaymentController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<CheckOutController>(() => CheckOutController());
    Get.lazyPut<PickCurrentLocationController>(() => PickCurrentLocationController());

    Get.lazyPut<ProductListController>(() => ProductListController());
    Get.lazyPut<CartController>(() => CartController());

    ProductListController.to.getVendorType(1);

    DatabaseHelper().initDatabase();
  }
}
