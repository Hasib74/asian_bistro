import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/routing/app_routes.dart';

class AppSplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Future.delayed(const Duration(seconds: 5),
        () => Get.offNamed(AppRoutes.SERVICE_TYPE_OPTION));
  }
}
