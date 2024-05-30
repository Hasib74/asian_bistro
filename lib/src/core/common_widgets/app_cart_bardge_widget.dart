import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/assets.dart';
import '../../features/cart/controller/CartController.dart';
import '../../features/cart/screen/cart_screen.dart';
import '../utils/colors/app_colors.dart';
import 'app_icon_button.dart';

class AppCartBardeWidget extends StatelessWidget {
  Color? iconColor;

  AppCartBardeWidget({Key? key, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Obx(() {
        return /*CartController.to.cartLst.isEmpty
                    ? Container(
                        color: Colors.transparent,
                      )
                    : */
            Text(
          "${CartController.to.cartLst.length > 10 ? "9+" : CartController.to.cartLst.length}",
          style: TextStyle(
            color:  AppColors.whiteColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        );
      }),
      offset: Offset(-4, -4),
      child: AppIconButton(
        image: Assets.imagesCart,
        iconColor: iconColor,
        index: 4,
        onPressed: () {
          Get.to(() => CartScreen(
                enableAppBar: true,
              ));
        },
      ),
    );
  }
}
