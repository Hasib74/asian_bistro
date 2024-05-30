import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common_widgets/app_counter_widgets.dart';
import '../../../core/common_widgets/app_image_view_widgets.dart';
import '../../../core/remote/urls/app_urls.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../core/utils/spaces/AppSpaces.dart';
import '../controller/CartController.dart';
import '../../../features/cart/domain/model/cart_model.dart';

typedef TotalAmount = Function(dynamic);

class CartCard extends StatefulWidget {
  Cart cart;

  TotalAmount? totalAmount;

  CartCard({required this.cart, this.totalAmount});

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  var amount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount = (int.parse(widget.cart.count.toString().endsWith("0")
            ? "1"
            : widget.cart.count.toString()) *
        double.parse(widget.cart.price.toString()));
  }

  @override
  Widget build(BuildContext context) {
    printInfo(
        info:
            "Image Url............................................ ${widget.cart.productNames?.imagePath}");
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
      child: Container(
        height: 80,
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _image(),
                  ),
                  //AppSpaces.spaces_width_10,
                  Expanded(
                    child: Text(
                      widget.cart.productNames?.productName ?? "",
                      style: Get.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // AppSpaces.spaces_height_5,

                  AppCounterWidget(

                    initial: int.parse(widget.cart.count.toString()) == 0
                        ? 1
                        : int.parse(widget.cart.count.toString()),
                    countNumber: (value, isRemoveAble) {
                      printInfo(info: "Count Value  === >> ${value}");

                      if (isRemoveAble == true) {
                        AwesomeDialog(
                            dismissOnTouchOutside: false,
                            context: context,
                            animType: AnimType.leftSlide,
                            headerAnimationLoop: true,
                            dialogType: DialogType.question,
                            title: 'Alert',
                            desc: 'Do you want to remove this item ?',
                            btnOkText: "Yes",
                            btnCancelText: "No",
                            btnOkOnPress: () {
                              CartController.to.updateCart(
                                widget.cart,
                                value,
                                widget.cart.price,
                                isRemoved: true,
                              );
                            },
                            btnCancelOnPress: () {
                              CartController.to.updateCart(
                                  widget.cart, 1, widget.cart.price);
                            })
                          ..show();
                      } else {
                        /* print(
                            "Priceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  ${widget.cart.price}");*/
                        setState(() {
                          amount = (value *
                              double.parse(widget.cart.price.toString()));
                        });

                        widget.totalAmount!(amount);

                        CartController.to.updateCart(
                            widget.cart, value, widget.cart.price);
                      }
                    },
                  ),

                  AppSpaces.spaces_width_5,

                  Row(
                    children: [
                      Text(
                        " ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        "\$${amount.toStringAsFixed(2) ?? 100}",
                        style: Get.textTheme.bodyMedium?.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  AppSpaces.spaces_width_5,

                  InkWell(
                      onTap: () {
                        AwesomeDialog(
                            dismissOnTouchOutside: false,
                            context: context,
                            animType: AnimType.leftSlide,
                            headerAnimationLoop: true,
                            dialogType: DialogType.question,
                            title: 'Alert',
                            desc: 'Do you want to remove this item ?',
                            btnOkText: "Yes",
                            btnCancelText: "No",
                            btnOkOnPress: () {
                              CartController.to.updateCart(
                                widget.cart,
                                0,
                                widget.cart.price,
                                isRemoved: true,
                              );
                            },
                            btnCancelOnPress: () {
                              CartController.to.updateCart(
                                  widget.cart, 1, widget.cart.price);
                            })
                          ..show();
                      },
                      child: Icon(
                        Icons.delete,
                        color: AppColors.redColor,
                      )),

                  AppSpaces.spaces_width_10,

                  //  AppSpaces.spaces_height_5,
                ],
              ),
            ),
            //AppSpaces.spaces_width_10,
          ],
        ),
      ),
    );
  }

  Widget _image() {
    return ImageViewWidget(
      imageUrl:
          widget.cart.productNames?.imagePath.toString().endsWith("null") ??
                  true
              ? ""
              : ApiUrls.download_base_url + widget.cart.productNames?.imagePath,
      width: 50,
      height: 50,
    );
  }

  _basic_info() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Spacer(),
          Spacer(),*/
        ],
      ),
    );
  }
}
