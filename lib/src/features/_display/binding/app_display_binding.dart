import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/app_display_controller.dart';

class AppDisplayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppDisplayController>(() => AppDisplayController());
  }
}
