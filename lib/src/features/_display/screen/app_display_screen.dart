import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';
import 'package:pizza_user_app/src/features/OrderTracking/screen/OrdersScreen.dart';
import 'package:pizza_user_app/src/features/all_products/screen/all_products_screen.dart';
import 'package:pizza_user_app/src/features/cart/controller/CartController.dart';
import 'package:pizza_user_app/src/features/cart/screen/cart_screen.dart';
import 'package:pizza_user_app/src/features/drawer/app_drawer.dart';
import 'package:pizza_user_app/src/features/favourite/screen/favourite_screen.dart';
import 'package:pizza_user_app/src/features/home/screen/home_screen.dart';
import 'package:pizza_user_app/src/features/order/screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';

import '../../../../../generated/assets.dart';
import '../../../../generated/assets.dart';
import '../../../core/common_widgets/any_image_view.dart';

part "../screen/sections/display_bottom_bar.dart";

part "../screen/sections/dislay_app_bar.dart";

class AppDisplayScreen extends StatefulWidget {
  const AppDisplayScreen({Key? key}) : super(key: key);

  @override
  State<AppDisplayScreen> createState() => _AppDisplayScreenState();
}

class _AppDisplayScreenState extends State<AppDisplayScreen> {
  int _currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    FavouriteScreen(),
    ProductList(),
    OrdersScreen(
      hasAppBar: false,
    ),
    CartScreen(),
  ];

  String? redirectionTitle;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Get.arguments != null) {
        redirectionTitle = Get.arguments;
      }

      if (redirectionTitle != null) {
        if (redirectionTitle == "Favourite") {
          setState(() {
            _currentIndex = 1;
          });
        } else if (redirectionTitle == "OrderTrackingScreen") {
          setState(() {
            _currentIndex = 3;
          });
        } else if (redirectionTitle == "Cart") {
          setState(() {
            _currentIndex = 4;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(AppColors.primaryColor);
    // FlutterStatusbarcolor.setNavigationBarColor(AppColors.primaryColor);
    // FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    //FlutterStatusbarcolor.setStatusBarColor(AppColors.primaryColor);
    //FlutterStatusbarcolor.setNavigationBarColor(AppColors.primaryColor);
    return Scaffold(
      //  resizeToAvoidBottomInset: false,

      key: scaffoldKey,
      drawer: Drawer(
        child: AppDrawer(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -16,
              left: 0,
              right: 0,
              child: _DisplayAppBar(
                scaffoldKey: scaffoldKey,
                onLogoClick: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
            ),
            Positioned.fill(
              top: 100 - 16,
              child: SizedBox(
                child: pages[_currentIndex],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: _AppBottomBar(
                onTabChange: (index) {
                  print("Current Index : ${index}");
                  setState(() {
                    _currentIndex = index!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
