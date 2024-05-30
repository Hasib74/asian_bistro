import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/generated/assets.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widgets.dart';
import 'package:pizza_user_app/src/core/remote/urls/app_urls.dart';
import 'package:pizza_user_app/src/core/routing/app_routes.dart';
import 'package:pizza_user_app/src/core/utils/spaces/AppSpaces.dart';
import 'package:pizza_user_app/src/features/all_products/controller/ProductListController.dart';

import '../../../../core/utils/colors/app_colors.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductListController.to.getVendorType(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("  Categories", style: Get.textTheme.titleLarge),
        AppSpaces.spaces_height_15,
        __productType(),
      ],
    ));
  }

  __productType() {
    return Obx(() => ProductListController.to.vendorType.value.message == null
        ? Container()
        : Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.5,
                      0.9
                    ],
                    colors: [
                      AppColors.primaryColor,
                      AppColors.secondaryColor.withOpacity(0.8)
                    ])),
            height: 70,
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.ALL_PRODUCT_LIST);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppImageView(
                                  width: 20,
                                  height: 20,
                                  image: Assets.imagesProducts)
                              .getImage(),
                          AppSpaces.spaces_height_5,
                          Text("All Items",
                              style: Get.textTheme.titleSmall
                                  ?.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: ProductListController.to.vendorType.value.message
                            ?.map((element) => InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                        AppRoutes.SINGLE_PRODUCT_LIST_CATEGORY,
                                        arguments: element.productTypeName);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              20)), /* color: Colors.white*/
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          element.image == null
                                              ? AppImageView(
                                                      width: 20,
                                                      height: 20,
                                                      image: Assets.imagesCart)
                                                  .getImage()
                                              : ImageViewWidget(
                                                  width: 20,
                                                  height: 20,
                                                  imageUrl: element.image !=
                                                          null
                                                      ? ApiUrls
                                                              .download_base_url +
                                                          /*   "uploads/productType/" +*/
                                                          element.image
                                                      : ""),
                                          AppSpaces.spaces_height_5,
                                          Text(
                                            "   ${element.productTypeName}   ",
                                            style: Get.textTheme.titleSmall
                                                ?.copyWith(
                                                    color:
                                                        AppColors.whiteColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                            .toList() ??
                        [],
                  )),
                ],
              ),
            ),
          ));
  }
}
