import 'package:get/get.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
class OnlinePaymentController extends GetxController {
  RxBool loading = false.obs;

  static OnlinePaymentController to = Get.find();

  SolidController solidController = new SolidController();
}
