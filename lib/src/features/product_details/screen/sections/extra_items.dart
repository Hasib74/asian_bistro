import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widgets.dart';
import 'package:pizza_user_app/src/core/remote/urls/app_urls.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';
import 'package:pizza_user_app/src/core/utils/spaces/AppSpaces.dart';

import '../../controller/product_details_controller.dart';

import '../../model/extra_items_response_model.dart' as model;
import '../../model/extra_items_response_model.dart';

class ExtraItems extends GetView<ProductDetailsController> {
  Function(List<model.ProductExtraItem>)? onSelectedProductExtraItems;

  ExtraItems({super.key, this.onSelectedProductExtraItems});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ProductDetailsController>()) {
      Get.put(ProductDetailsController());
    }

    return Obx(() => controller.extraItemsResponseModel.value.data?.isEmpty ==
            true
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose Extra Items",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpaces.spaces_height_15,
                  SizedBox(
                    //width: MediaQuery.sizeOf(context).width,
                    child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (var data in controller.extraItemsResponseModel
                                  .value.data?[0].productExtraItem ??
                              [])
                            Obx(() {
                              ProductExtraItem? _getSelectedExtraItems =
                                  controller.selectedExtraItems.where((p0) => p0.id.toString() == data?.id.toString()).firstOrNull;

                              print("Selected Extra Items: $_getSelectedExtraItems");

                              bool isSelected = _getSelectedExtraItems != null;

                              return InkWell(
                                onTap: () {
                                  controller.setSelectedExtraItems(data!);

                                  onSelectedProductExtraItems?.call(
                                      controller.selectedExtraItems.value);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                    color: isSelected
                                        ? AppColors.primaryColor
                                        : AppColors.whiteColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ImageViewWidget(
                                                imageUrl: data?.image == null
                                                    ? null
                                                    : ApiUrls
                                                            .download_base_url +
                                                        data!.image.toString(),
                                                height: 36,
                                                width: 36),
                                            Text(data?.name ?? "",
                                                style: TextStyle(
                                                    color: isSelected
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                        Text("+\$${data?.price}")
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                        ]),

                    /*child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.extraItemsResponseModel.value.data?[0]
                              .productExtraItem?.length ??
                          0,
                      itemBuilder: (context, index) {
                        var data = controller.extraItemsResponseModel.value.data?[0]
                            .productExtraItem?[index];

                        return Obx(() {
                          bool isSelected =
                              controller.selectedExtraItems.value.contains(data);
                          return InkWell(
                            onTap: () {
                              controller.setSelectedExtraItems(data!);

                              onSelectedProductExtraItems
                                  ?.call(controller.selectedExtraItems.value);
                            },
                            child: Container(

                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.whiteColor,
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ImageViewWidget(
                                            imageUrl: data?.image == null
                                                ? null
                                                : ApiUrls.download_base_url +
                                                    data!.image.toString(),
                                            height: 36,
                                            width: 36),
                                        Text(data?.name ?? "",
                                            style: TextStyle(
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  Text("+\$${data?.price}")
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),*/
                  ),
                ],
              ),
            ),
          ));
  }
}
