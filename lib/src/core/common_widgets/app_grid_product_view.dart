import 'package:flutter/material.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_button.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widgets.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';
import 'package:pizza_user_app/src/core/utils/spaces/AppSpaces.dart';
import '../../../generated/assets.dart';

class AppGridProductView extends StatelessWidget {
  String? imageUrl;

  String? productName;

  String? productType;

  String? productDescription;

  String? productPrice;

  VoidCallback? onTab;

  bool? newDesign;

  AppGridProductView(
      {Key? key,
      this.imageUrl,
      this.productPrice,
      this.productName,
      this.productType,
      this.onTab,
      this.productDescription})
      : super(key: key);

  AppGridProductView.newDesign({
    Key? key,
    this.imageUrl,
    this.productPrice,
    this.productName,
    this.productType,
    this.onTab,
    this.productDescription,
  }) : super(key: key) {
    newDesign = true;
  }

  @override
  Widget build(BuildContext context) {
    if (newDesign != null) {
      return _newDesign();
    }

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: ElevatedButton(
        onPressed: onTab,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 0.5, blurRadius: 1)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: AppColors.redColor)),
          width: 160,
          child: Column(
            children: [
              AppSpaces.spaces_height_10,
              Expanded(
                  child: ImageViewWidget(
                width: double.infinity,
                height: double.infinity,
                imageUrl: imageUrl ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi23Ug8hUqAjIQSCpAITPZPmnsubBcKLHlqg&usqp=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",
                fit: BoxFit.cover,
              )),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppSpaces.spaces_height_5,
                    Text(
                      productName ?? "5 pcs chicken fingers",
                      style: Get.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    AppSpaces.spaces_height_5,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        productDescription ??
                            "Chicken, Garlic Sauce, Latus, Olives, Salt, Green Chili Sauce, Pepper, etc",
                        style: Get.textTheme.bodySmall?.copyWith(fontSize: 10),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    AppSpaces.spaces_height_5,
                    Text(
                      "\$. ${double.parse(productPrice.toString()).toStringAsFixed(2) ?? "200"}",
                      style: Get.textTheme.bodyMedium!
                          .copyWith(color: AppColors.redColor),
                      textAlign: TextAlign.center,
                    ),
                    AppSpaces.spaces_height_5,
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(45),
                          ),
                          color: AppColors.redColor),
                      width: 90,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Order Now",
                          style: Get.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      )),
                    ),
                    AppSpaces.spaces_height_10,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _newDesign() {
    Gradient gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.5, 0.9],
        colors: [AppColors.primaryColor, AppColors.secondaryColor]);

    return TextButton(
      onPressed: onTab,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            border: Border.all(color: AppColors.secondaryColor, width: 2),
          ),
          child: ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  AppSpaces.spaces_height_10,
                  Expanded(
                      child: ImageViewWidget(
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: imageUrl ??
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi23Ug8hUqAjIQSCpAITPZPmnsubBcKLHlqg&usqp=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",
                    fit: BoxFit.contain,
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppSpaces.spaces_height_5,
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => gradient.createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                        child: Text(
                          productName ?? "5 pcs chicken fingers",
                          style: Get.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      AppSpaces.spaces_height_5,
                      Text(
                        "\$. ${double.parse(productPrice.toString()).toStringAsFixed(2) ?? "200"}",
                        style: Get.textTheme.titleMedium!.copyWith(
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      AppSpaces.spaces_height_5,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(45),
                            ),
                            color: AppColors.redColor),
                        width: 90,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Order Now",
                            style: Get.textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        )),
                      ),
                      AppSpaces.spaces_height_10,
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    double height = size.height;
    double width = size.width;

    path.lineTo(width - 50, 0);
    path.lineTo(width, 50);
    path.lineTo(width, height);
    path.lineTo(50, height);
    path.lineTo(0, height - 50);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // We don't need to update the clipper
  }
}
