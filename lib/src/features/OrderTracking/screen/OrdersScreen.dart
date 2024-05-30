import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';

import '../../../core/Network/network_info.dart';
import '../../../core/common_widgets/app_loading.dart';
import '../Controller/OrderTrackingController.dart';
import '../widgets/order_card.dart';
import 'OrderStatusScreen.dart';
import '../model/OrderStatus.dart';

class OrdersScreen extends StatelessWidget {
  bool? hasAppBar;

  OrdersScreen({this.hasAppBar = true});

  @override
  Widget build(BuildContext context) {
    Get.put(NetworkInfoController());
    Get.put(OrderTrackingController());

    WidgetsFlutterBinding.ensureInitialized()
        .addPostFrameCallback((timeStamp) async {
      var value =
          await OrderTrackingController.to.getAllOrdersTrakingInfo(context);

    /*  if (value == true) {
        await OrderTrackingController.to.getAllOrdersTrakingInfo(context);
      }*/
    });

    /*
    * Monday te ki hobe ?  ;
    * hole tour e jaitam .Ar hocce na dada .Jibon bedona !!;
    *
    * */

    return Scaffold(
      appBar: hasAppBar == true
          ? AppBar(
              title: Text("Orders"),
              backgroundColor: AppColors.primaryColor,
            )
          : null,
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Obx(
          () => OrderTrackingController.to.loading.value
              ? Center(
                  child: AppLoading(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    WidgetsFlutterBinding.ensureInitialized()
                        .addPostFrameCallback((timeStamp) {
                      OrderTrackingController.to
                          .getAllOrdersTrakingInfo(context);
                    });
                  },
                  child: ListView.separated(
                    reverse: false,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (_, int index) {
                      Order? _orderStatus = OrderTrackingController
                          .to.orderTracking?.value.orders?.reversed
                          .elementAt(index);

                      printInfo(
                          info:
                              "Order created date and time : ${_orderStatus?.createdAt}");

                      var _dateTime =
                          DateTime.parse(_orderStatus?.createdAt ?? "");

                      printInfo(
                          info:
                              "Order created date and time 2: ${DateFormat('hh:mm a').format(_dateTime)}");

                      return Hero(
                        tag: index.toString(),
                        child: InkWell(
                          onTap: () => Get.to(new OrderTackingScreen(
                            orderId: _orderStatus?.id,
                            offerId: _orderStatus?.offerId,
                            orderAddress: _orderStatus?.orderAddress,
                            orderStatus: _orderStatus?.orderStatusId,
                            discountPrice: _orderStatus?.discount,
                            totatlPrice: _orderStatus?.totalAmount,
                            herokey: index.toString(),
                          )),
                          child: OrdersCard(
                            createdTime:
                                DateFormat('hh:mm a').format(_dateTime),
                            date: _orderStatus?.createdAt,
                            holderAddress: _orderStatus?.orderAddress,
                            holderName: "Unknown",
                            offer: _orderStatus?.offerId,
                            deliveryCharge:
                                _orderStatus?.deliveryFee.toString(),
                            distance: _orderStatus?.distance,
                            discountPrice: _orderStatus?.discount,
                            orderId: _orderStatus?.id,
                            totalPrice: _orderStatus?.totalAmount,
                          ),
                        ),
                      );
                    },
                    itemCount:
                        OrderTrackingController.to.orderTracking?.value == null
                            ? 0
                            : OrderTrackingController
                                    .to.orderTracking?.value.orders?.length ??
                                0,
                    separatorBuilder: (_, int index) {
                      return Container(
                        height: 10,
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
