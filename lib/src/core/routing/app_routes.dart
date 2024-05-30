import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pizza_user_app/src/features/Authentication/SignUp/SignupScreen.dart';
import 'package:pizza_user_app/src/features/checkout_screen/check_out_screen.dart';
import 'package:pizza_user_app/src/features/delivery_options/delivery_options.dart';
import 'package:pizza_user_app/src/features/single_product_list_category/single_product_list_by_category.dart';
import 'package:pizza_user_app/src/features/splash_screen/splash_screen.dart';

import '../../features/Authentication/SignIn/SignIn.dart';
import '../../features/OrderSuccess/OrderSuccess.dart';
import '../../features/PickCurrentLocation/PickCurrentLocation.dart';
import '../../features/ServiceType/ServiceTypeScreen.dart';
import '../../features/_display/screen/app_display_screen.dart';
import '../../features/addProdctList/all_product_list_screen.dart';

class AppRoutes {
  static String INITIAL = "/";
  static String SERVICE_TYPE_OPTION = "/service_type_option";
  static String LOG_IN = '/SignIn';
  static String ACCOUNT_RECOVER = '/account_recover';
  static String PICK_USER_LOCATION = "/pick_user_location";
  static String DISPLAY = "/display";
  static String CHECK_OUT = "/checkout_screen";
  static String ORDER_SUCCESS = "/order_success";

  static String ONLINE_PAY_WEB_VIEW = "/online_pay_web_view";

  static String OTP_SCREEN = "/otp_screen";

  static String SIGNUP_SCREEN = "/signup_screen";

  static String SINGLE_PRODUCT_LIST_CATEGORY = "/single_product_list_category";

  static String DELIVERY_OPRIONS = "/delivery_options";

  static String ALL_PRODUCT_LIST = "/all_product_list";

  static List<GetPage> appRouets() {
    return [
      GetPage(name: INITIAL, page: () => SplashScreen()),
      GetPage(name: DISPLAY, page: () => AppDisplayScreen()),
      GetPage(name: CHECK_OUT, page: () => CheckOutScreen()),
      GetPage(name: ORDER_SUCCESS, page: () => OrderSuccess()),
      GetPage(name: LOG_IN, page: () => SignIn()),
      GetPage(name: SIGNUP_SCREEN, page: () => SignUpScreen()),
      GetPage(name: SERVICE_TYPE_OPTION, page: () => ServiceTypeScreen()),
      GetPage(
          name: SINGLE_PRODUCT_LIST_CATEGORY,
          page: () => SingleProductListByCategory()),
      GetPage(name: DELIVERY_OPRIONS, page: () => DeliveryOptions()),
      GetPage(name: ALL_PRODUCT_LIST, page: () => AllProductListScreen()),

      GetPage(name: PICK_USER_LOCATION, page: ()=> PickCurrentLocationScreen()),

    ];
  }
}
