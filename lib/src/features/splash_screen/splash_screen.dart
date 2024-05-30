import 'package:flutter/material.dart';
import 'package:pizza_user_app/generated/assets.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';

import '../../core/common_widgets/any_image_view.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double? padding = 30;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        padding = 0;
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        padding = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
          child: AnimatedPadding(
        padding: EdgeInsets.all(padding ?? 0),
        duration: Duration(seconds: 3),
        child: AnyImageView(
          borderRadius: BorderRadius.circular(100),
          shape: BoxShape.circle,
          imagePath: Assets.imagesLogo,
          width: 200,
          height: 200,
        ),
      )),
    );
  }
}
