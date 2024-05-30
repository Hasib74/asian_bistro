import 'package:flutter/material.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';

class AppCardView extends StatelessWidget {
  Widget? child;

  double? height;
  double? width;

  BoxShape? shape;

  AppCardView({super.key, this.child, this.height, this.width, this.shape});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.all(Radius.circular(10)),
          color: AppColors.primaryColor),
      child: child,
    );
  }
}
