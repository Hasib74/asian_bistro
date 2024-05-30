import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';

import '../controller/CartController.dart';

class CartControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());


  }
}
