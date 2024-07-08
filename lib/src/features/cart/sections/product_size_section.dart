/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/colors/app_colors.dart';
import '../controller/CartController.dart';
class ProductSizeSection extends StatelessWidget {
  const ProductSizeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _selectedSize(context);
  }


  _selectedSize(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Selected Size", style: Get.textTheme.bodyMedium),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedSizePrice == null
                    ? ""
                    : "Price: ${selectedSizePrice ?? 0.0}",
                style: TextStyle(color: AppColors.primaryColor),
              ),
            )
          ],
        ),
        Wrap(
          children: widget.cart.productNames?.totalProductSizeList?.map((e) {
            var isSelected = widget.cart.productNames?.sizeName == e.name;

            if (widget.cart.productNames?.sizeName == e.name) {
              print("Pre Selected price : ${e.sizePrice}");
              //setState(() {
              selectedSizePrice = e.sizePrice;
              //});

              CartController.to.updateCartItemSelectedSizePrice(
                  widget.cart.productNames?.product_name_id.toString(),
                  e.sizePrice);

              setState(() {
                amount = (itemCount *
                    double.parse(selectedSizePrice.toString()));
              });
            }

            return InkWell(
              onTap: () async {
                //    await Future.delayed(Duration(seconds: 0.5));
                //setState(() {
                selectedSizePrice = e.sizePrice;
                // });
                CartController.to.updateSize(e, widget.cart);

                await Future.delayed(Duration.zero);
                CartController.to.updateCartItemSelectedSizePrice(
                    e.id.toString(), e.sizePrice);

                await Future.delayed(Duration.zero);

                ///  CartController.to.totalAmount();

                Future.delayed(Duration(microseconds: 1000)).then((value) {
                  CartController.to.totalAmount();

                  //      setState(() {});
                });
                //
                // setState(() {
                //   amount = (itemCount *
                //       double.parse(selectedSizePrice.toString()));
                // });
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      e.name != null ? "${e.name} (+\$${e.sizePrice})" : "",
                      style: Get.textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? AppColors.whiteColor
                              : AppColors.primaryColor)),
                ),
              ),
            );
          }).toList() ??
              [],
        ),
      ],
    );
  }
}*/
