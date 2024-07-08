import 'package:flutter/material.dart';

import '../../../core/Network/network_info.dart';
import '../../../core/app_snack_bar/app_snack_bar.dart';
import '../../../core/common_widgets/app_button.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../core/utils/spaces/AppSpaces.dart';
import '../../checkout_screen/controller/check_out_controller.dart';
import '../binding/app_cart_binding.dart';
import '../controller/CartController.dart';
import 'package:get/get.dart';

import '../widgets/cart_widegts.dart';

class CartScreen extends StatefulWidget {
  final bool? enableAppBar;

  CartScreen({Key? key, this.enableAppBar}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CartControllerBinding().dependencies();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      CartController.to.clearData();
      CartController.to.totalAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.enableAppBar != null && widget.enableAppBar == true
          ? AppBar(
              backgroundColor: AppColors.primaryColor,
              title: Text("Cart"),
            )
          : null,
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CartController.to.cartLst.isEmpty
              ? Center(
                  child: Text(
                    "Cart Empty",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Obx(() {
                        return ListView.separated(
                            itemBuilder: (context, int index) {
                              printInfo(
                                  info:
                                      "Vendor name ::: ${CartController.to.cartLst[index].productNames?.productName}");
                              // return Container();
                              return CartCard(
                                cart: CartController.to.cartLst[index],
                                totalAmount: (amount) {
                                  print("Cart ===>>  ${amount}");
                                },
                              );
                            },
                            separatorBuilder: (context, int index) {
                              return Container(
                                height: 10,
                              );
                            },
                            itemCount: CartController.to.cartLst.length);
                      }),
                    ),
                    Container(
                        width: Get.width * 0.9,
                        height: 70,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Row(
                          children: [
                            Obx((){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Total Amount : \$ ${CartController.to.amount.value.toStringAsFixed(2)}",
                                  style: Get.theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              );
                            }),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                Get.put(NetworkInfoController());

                                if (CartController.to.cartLst.value.length >
                                    0) {
                                  CheckOutController.to.loading.value = false;

                                  Get.toNamed(AppRoutes.CHECK_OUT);
                                } else {
                                  AppSnackBar.errorSnackbar(
                                      msg: "Please add product to cart.");
                                }
                              },
                              child: AppButtonWidget(
                                  borderRadius: 10,
                                  width: 120,
                                  titleColor: AppColors.whiteColor,
                                  title: "Check Out",
                                  leadingCenter: true),
                            ),
                            AppSpaces.spaces_width_25,
                          ],
                        )),
                    AppSpaces.spaces_height_30,
                    AppSpaces.spaces_height_30,
                    AppSpaces.spaces_height_30,
                  ],
                ),
        );
      }),
    );
  }
}
