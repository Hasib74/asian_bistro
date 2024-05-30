import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/routing/app_routes.dart';

import '../../core/common_widgets/app_button.dart';
import '../../core/utils/colors/app_colors.dart';
import '../../core/utils/spaces/AppSpaces.dart';
import '../profile/screen/EditProfileController/ProfileController.dart';
import 'domain/model/OrderSuccessModel.dart';

class OrderSuccess extends StatelessWidget {
  OrderSuccess({
    Key? key,
  }) : super(key: key);

  OrderSuccessModel? orderSuccessModel;

  @override
  Widget build(BuildContext context) {
    orderSuccessModel = Get.arguments;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.99),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Confirmation"),
        centerTitle: true,
      ),
      body: Center(
        child: PhysicalModel(
          elevation: 10,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppColors.primaryColor,
          child: Container(
            width: Get.width * 0.9,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSpaces.spaces_height_15,
                Text(
                  "Order placed successfully.",
                  style:
                      Get.textTheme.bodyMedium?.copyWith(color: Colors.green),
                ),
                AppSpaces.spaces_height_15,
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Order Id:",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(" ${orderSuccessModel?.message?.order?.id}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Order amount:"),
                      Text(
                          "\$${double.parse(orderSuccessModel?.message?.order?.totalAmount ?? "0.0").toStringAsFixed(2)}"),
                    ],
                  ),
                ),
                AppSpaces.spaces_height_15,
                Row(
                  children: [
                    Expanded(
                        child: new DottedLine(
                      dashColor: Colors.grey,
                    )),
                  ],
                ),
                AppSpaces.spaces_height_15,
                Text("A confirmation email send to ."),
                Text("${ProfileController.to.user.value.email ?? ""}"),
                AppSpaces.spaces_height_15,
                AppButtonWidget(
                    title: "View Order Details",
                    leadingCenter: true,
                    onTab: () {
                      Navigator.pushNamed(context, AppRoutes.DISPLAY,
                          arguments: "OrderTrackingScreen");
                      // Get.back();
                      // OrderTrackingController.to.getAllOrdersTrakingInfo();

                      // Get.to(OrderTackingScreen(
                      //   orderAddress:
                      //       orderSuccessModel.message.order.orderAddress,
                      //   offerId: orderSuccessModel.message.order.offerId.toString(),
                      //   orderId: orderSuccessModel.message.order.id,
                      //   orderRecivedTime:
                      //       orderSuccessModel.message.order.orderDatetime,
                      //   orderStatus: 1,
                      //   //discount: orderSuccessModel.message.order.discount,
                      //   totatlPrice:
                      //       orderSuccessModel.message.order.totalAmount,
                      // ));

                      // Get.offAndToNamed(AppRoutes.ORDER_TRACKING);
                    }),
                AppSpaces.spaces_height_15,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
