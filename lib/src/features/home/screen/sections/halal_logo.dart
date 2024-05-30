import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/generated/assets.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';

import 'licence.dart';

class HalalLogo extends StatelessWidget {
  const HalalLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: new InkWell(
        onTap: () {
          Get.to(() => LicenceView());
        },
        child: AppImageView(image: Assets.imagesHalal, width: 0, height: 100)
            .getImage(),
      ),
    );
  }
}
