import 'package:flutter/material.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';

import '../../../../../generated/assets.dart';

class LicenceView extends StatelessWidget {
  const LicenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Halah Cerificate"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: AppImageView(
          image: Assets.imagesHalahCerificate,
          width: double.infinity,
          height: double.infinity,
        ).getImage(),
      ),
    );
  }
}
