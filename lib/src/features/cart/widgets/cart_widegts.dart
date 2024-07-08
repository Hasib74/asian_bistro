import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';

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

  String? selectedSizePrice;

  int itemCount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 1)).then((value) {
      // selectedSizePrice  =  widget.cart.productNames?.totalProductSizeList?.firstWhere((element) => element.name == widget.cart.productNames?.sizeName).sizePrice.toString();

      print("Selected Size Price :====> ${selectedSizePrice}");
      setState(() {
        /*  selectedSizePrice =
            widget.cart.productNames?.totalProductSizeList == null
                ? widget.cart.price
                : widget.cart.productNames?.totalProductSizeList
                    ?.firstWhere((element) =>
                        element.name == widget.cart.productNames?.sizeName)
                    .sizePrice
                    .toString();*/

        selectedSizePrice = initialSizePrice();

        print("Selected Size Price :====> ${selectedSizePrice}");

        amount = (itemCount *
            double.parse(selectedSizePrice == null
                ? widget.cart.price
                : selectedSizePrice.toString()));
      });

      CartController.to.updateCartItemSelectedSizePrice(
          widget.cart.productNames?.product_name_id.toString(), selectedSizePrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    printInfo(
        info:
            "Extra items in cart screen : ${widget.cart.productNames?.extraItems}");
    printInfo(
        info: "Product Size Name : ${widget.cart.productNames?.sizeName}");
    printInfo(
        info:
            "Image Url............................................ ${widget.cart.productNames?.imagePath}");

    printInfo(
        info:
            "Total extra items : ${widget.cart.productNames?.totalExtraItems}");
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
      child: Container(
        //  height: 80,
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                          style: Get.textTheme.titleSmall,
                        ),
                      ),
                      // AppSpaces.spaces_height_5,

                      Expanded(flex: 2,
                        child: AppCounterWidget(
                          initial: int.parse(widget.cart.count.toString()) == 0
                              ? 1
                              : int.parse(widget.cart.count.toString()),
                          countNumber: (value, isRemoveAble) {
                            printInfo(info: "Count Value  === >> ${value}");

                            setState(() {
                              itemCount = value;
                            });
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
                                    double.parse(selectedSizePrice == null
                                        ? widget.cart.price
                                        : selectedSizePrice.toString()));
                              });

                              widget.totalAmount!(amount);

                              CartController.to.updateCart(
                                  widget.cart, value, widget.cart.price);
                            }
                          },
                        ),
                      ),

                      AppSpaces.spaces_width_5,

                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              " ",
                              style: Get.textTheme.bodyMedium,
                            ),
                            Text(
                              "\$${itemCount * double.parse(selectedSizePrice ?? "0.0")}",
                              style: Get.textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),

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
                            color: AppColors.primaryColor,
                          )),

                      AppSpaces.spaces_width_10,

                      //  AppSpaces.spaces_height_5,
                    ],
                  ),
                ),

                //AppSpaces.spaces_width_10,
              ],
            ),
            widget.cart.productNames?.productSize != null
                ? _selectedSize(context)
                : Container(),
            AppSpaces.spaces_height_5,
            _extraItems(context)
          ],
        ),
      ),
    );
  }

  Padding _extraItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Extra Items", style: Get.textTheme.bodyMedium),
                Spacer(),
                widget.cart.productNames?.extraItems?.isEmpty == true
                    ? Container()
                    : Text(
                        "Price: \$${widget.cart.productNames?.extraItems?.map((e) => e.extraItemPrice).reduce((value, element) => "${double.parse(value.toString()) + double.parse(element.toString())}") ?? 0.0}",
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.primaryColor),
                      )
              ],
            ),
          ),
          Container(
            width: Get.width,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.cart.productNames?.totalExtraItems?.map((e) {
                    bool? hasData = widget.cart.productNames?.extraItems
                        ?.where(
                            (element) => element.extraItemId == e.id.toString())
                        .isNotEmpty;

                    printInfo(info: "Has Data : ${hasData}");

                    return InkWell(
                      onTap: () {
                        if (hasData == true) {
                          CartController.to.removeExtraItems(e, widget.cart);
                        } else {
                          CartController.to.addExtraItems(e, widget.cart);
                        }

                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: hasData == true
                                  ? AppColors.primaryColor
                                  : Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: hasData == true
                              ? AppColors.primaryColor
                              : AppColors.whiteColor,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ImageViewWidget(
                                imageUrl: e.image == null
                                    ? ""
                                    : ApiUrls.download_base_url + e.image!,
                                width: 20,
                                height: 20),
                            AppSpaces.spaces_width_5,
                            Text(
                              e.name ?? "",
                              style: Get.textTheme.bodyMedium?.copyWith(
                                  color: hasData == true
                                      ? AppColors.whiteColor
                                      : AppColors.primaryColor),
                            ),
                            AppSpaces.spaces_width_5,
                            Text("\$${e.price}",
                                style: Get.textTheme.bodyMedium?.copyWith(
                                    color: hasData == true
                                        ? AppColors.whiteColor
                                        : AppColors.primaryColor)),
                            AppSpaces.spaces_width_5,
                          ],
                        ),
                      ),
                    );
                  }).toList() ??
                  [],
            ),
          ),
        ],
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
/*
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
                }*/

                return InkWell(
                  onTap: () async {
                    //    await Future.delayed(Duration(seconds: 0.5));
                    setState(() {
                      selectedSizePrice = e.sizePrice;
                    });
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

  String? initialSizePrice() {
    if (widget.cart.productNames?.totalProductSizeList == null) {
      return widget.cart.price;
    } else {
      var price = widget.cart.productNames?.totalProductSizeList
          ?.firstWhere(
              (element) => element.name == widget.cart.productNames?.sizeName)
          .sizePrice
          .toString();

      if (price == null) {
        return widget.cart.productNames?.totalProductSizeList?[0].sizePrice;
      } else
        return price;
    }
  }
}
