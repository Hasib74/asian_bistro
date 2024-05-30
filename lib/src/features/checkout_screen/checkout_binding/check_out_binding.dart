import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/features/checkout_screen/controller/check_out_controller.dart';

import '../../all_products/controller/ProductListController.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckOutController>(() => CheckOutController());

    ProductListController.to.getVendorType(1);
    //Get.put(CheckOutController());
  }
}
