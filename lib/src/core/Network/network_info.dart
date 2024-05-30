import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoController extends GetxController implements NetworkInfo {
  static NetworkInfoController to = Get.find();
  InternetConnectionChecker dataConnectionChecker = InternetConnectionChecker();

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
