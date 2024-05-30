import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizza_user_app/generated/assets.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';

import '../../../../core/utils/spaces/AppSpaces.dart';

class ShopLocation extends StatelessWidget {
  const ShopLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "OUR",
              style: Get.textTheme.titleLarge?.copyWith(
                  color: AppColors.redColor, fontWeight: FontWeight.w800),
            ),
            AppSpaces.spaces_width_10,
            Text(
              "LOCATION",
              style: Get.textTheme.titleLarge?.copyWith(
                  color: AppColors.blackColor, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        AppSpaces.spaces_height_15,
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              width: Get.width * 0.9,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.redColor, width: 2),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 20,
                    blurRadius: 0.5,
                    offset: Offset(0, 0.5), // changes position of shadow
                  ),
                ],
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(39.2923977,-76.7176315),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId("1"),
                    position: LatLng(39.3123516, -76.7575701),
                  )
                },
              )),
        ),
      ],
    );
  }
}
