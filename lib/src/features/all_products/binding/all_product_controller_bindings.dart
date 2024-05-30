import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';

import '../controller/ProductListController.dart';

class AllProductsControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListController>(() => ProductListController());
  }
}
