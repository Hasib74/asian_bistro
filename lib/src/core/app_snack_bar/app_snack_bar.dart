import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppSnackBar {
  static void errorSnackbar({ String? msg}) {
    Get.snackbar('$msg', "Error !",
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
        colorText: Colors.white);
  }

  static void successSnackbar({required String? msg, int sec = 1}) {
    Get.snackbar('$msg', "Success !",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[200],
        duration: new Duration(seconds: sec),
        icon: Icon(
          Icons.check_circle_outline_outlined,
          color: Colors.white,
        ),
        colorText: Colors.white);
  }
}
