import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_loading.dart';
import 'package:pizza_user_app/src/core/remote/urls/app_urls.dart';
import 'package:pizza_user_app/src/core/utils/spaces/AppSpaces.dart';
import 'package:pizza_user_app/src/features/home/controller/app_home_controller.dart';
import 'package:pizza_user_app/src/features/home/model/banner_model.dart';
import 'package:pizza_user_app/src/features/home/screen/sections/categories_list.dart';
import 'package:pizza_user_app/src/features/home/screen/sections/location.dart';
import 'package:pizza_user_app/src/features/home/screen/sections/special_products.dart';
import 'package:pizza_user_app/src/features/home/screen/sections/today_special.dart';

import '../../../../generated/assets.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../all_products/controller/ProductListController.dart';
import 'sections/halal_logo.dart';

part './sections/banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with KeepAliveParentDataMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
          child:
              _body() /*Obx(() {


          print("isloading ${AppHomeController.to.isLoading.value}");
          return AppHomeController.to.isLoading.value ? AppLoading() : _body();
        }),*/
          ),
    );
  }

  ListView _body() {
    return ListView(
      padding: EdgeInsets.only(bottom: 120),
      children: [
        Banner(),
        CategoriesList(),
        AppSpaces.spaces_height_15,
        TodaySpecialProducts(),
        AppSpaces.spaces_height_15,
        AppSpecialProducts(),
        AppSpaces.spaces_height_15,
        ShopLocation(),
        AppSpaces.spaces_height_15,
      ],
    );
  }

  @override
  void detach() {
    // TODO: implement detach
  }

  @override
  // TODO: implement keptAlive
  bool get keptAlive => true;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
