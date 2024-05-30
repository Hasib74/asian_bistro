import 'package:flutter/material.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';


class CustomCardView extends StatelessWidget {
  Widget? child;
  Color? bgColor;

  bool? hasShadow;

  double? borderRadius;

  CustomCardView(
      {super.key,
      this.child,
      this.bgColor,
      this.hasShadow = true,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          boxShadow: hasShadow == false
              ? []
              : [
                  BoxShadow(
                    color: AppColors.grayColor,
                    spreadRadius: 0.5,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
