import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/core/utils/spaces/AppSpaces.dart';
import 'package:pizza_user_app/src/features/delivery_options/writeAddress/write_address_for_catering.dart';

import '../../../generated/assets.dart';
import '../../core/routing/app_routes.dart';
import '../../core/utils/colors/app_colors.dart';

class DeliveryOptions extends StatelessWidget {
  const DeliveryOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 80,
              onPressed: () {
                //Get.toNamed(AppRoutes.DISPLAY);

                Get.back();

                Get.to(() => WriteAddressScreenCatering());
              },
              icon: AppImageView(
                image: Assets.assetsImagesDelivery,
                size: 100,
                // fit: BoxFit.contain,
                // ,
              ).getImage(),
            ),
            AppSpaces.spaces_width_15,
            IconButton(
                iconSize: 80,
                onPressed: () {
                  Get.back();
                },
                icon: AppImageView(
                  image: Assets.assetsImagesPickUp,
                  //width: 200,
                  //  height: 200,
                  // fit: BoxFit.cover,
                ).getImage()),
          ],
        ),
      ),
    );
  }
}
