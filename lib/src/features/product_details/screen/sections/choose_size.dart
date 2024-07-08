import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';

import '../../controller/product_details_controller.dart';
import '../../model/product_size_response_model.dart';

class ChooseSize extends StatefulWidget {
  var id;

  Function(int, dynamic)? onSelectedSize;

  ChooseSize({super.key, this.onSelectedSize, this.id});

  @override
  State<ChooseSize> createState() => _ChooseSizeState();
}

class _ChooseSizeState extends State<ChooseSize> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (!Get.isRegistered<ProductDetailsController>()) {
      Get.put(ProductDetailsController());
    }
  }

  var controller = ProductDetailsController.to;

  bool? alreadyAddedSize = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (ProductDetailsController.to.productSizeResponseModel.value.data !=
                null ||
            ProductDetailsController
                    .to.productSizeResponseModel.value.data?.isEmpty ==
                false) {
          if (alreadyAddedSize == false) {
            alreadyAddedSize = true;

            controller.selectedSize.value = ProductDetailsController
                        .to.productSizeResponseModel.value.data?.isEmpty ==
                    true
                ? ProductSize()
                : ProductDetailsController
                    .to.productSizeResponseModel.value.data?[0].productSize?[0];

            widget.onSelectedSize!(
                controller.selectedSize.value?.id?.toInt() ?? 1,
                controller.selectedSize.value?.sizePrice);
          }
        }

        return ProductDetailsController
                        .to.productSizeResponseModel.value.data ==
                    null ||
                ProductDetailsController
                    .to.productSizeResponseModel.value.data!.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Choose Size",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (var data in ProductDetailsController
                              .to
                              .productSizeResponseModel
                              .value
                              .data![0]
                              .productSize!)
                            InkWell(
                              onTap: () {
                                // controller.setSelectedExtraItems(data!);
                                controller.selectedSize.value = data;

                                widget.onSelectedSize!(
                                    data.id?.toInt() ?? 1, data.sizePrice);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: controller.selectedSize.value == data
                                      ? AppColors.primaryColor
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      data.name ?? "",
                                      style: TextStyle(
                                          color:
                                              controller.selectedSize.value ==
                                                      data
                                                  ? AppColors.whiteColor
                                                  : AppColors.blackColor),
                                    ),
                                    Text(
                                      data.sizePrice != null
                                          ? ("  +\$${data.sizePrice}")
                                          : "",
                                      style: TextStyle(
                                          color:
                                              controller.selectedSize.value ==
                                                      data
                                                  ? AppColors.whiteColor
                                                  : AppColors.blackColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
