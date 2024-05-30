import 'package:get/get.dart';

class AppDrawerController extends GetxController {
  static AppDrawerController to = Get.find();
  Rx<DrawerItems> drawerItems = DrawerItems.Home.obs;

  setDrawerItem(DrawerItems item) {
    drawerItems.value = item;
  }
}

enum DrawerItems {
  Home,
  TodayDeals,
  Profile,
  Settings,
  Logout,
  MyCoupons,
  MyOrders,
  Feedback,
  ContactUs,
  HoursOfOperation,
  Rewards,
}
