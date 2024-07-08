import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';

import '../../../core/common_widgets/app_button.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../core/utils/spaces/AppSpaces.dart';
import '../Controller/OrderTrackingController.dart';
import '../model/OrderDetails.dart';

class OrderTackingScreen extends StatefulWidget {
  final herokey;
  final orderAddress;
  final selectServiceName;
  final offerId;
  final deliveryFee;
  final distance;
  final orderId;
  final discountPrice;
  final totatlPrice;
  final orderStatus;
  final orderRecivedTime;

  final onTheWayTime;

  final deliverTime;

  OrderTackingScreen(
      {this.selectServiceName,
      this.distance,
      this.orderId,
      this.deliveryFee,
      this.offerId,
      this.orderAddress,
      this.herokey,
      this.orderStatus,
      this.totatlPrice,
      this.discountPrice,
      this.deliverTime,
      this.onTheWayTime,
      this.orderRecivedTime});

  @override
  _OrderTackingScreenState createState() => _OrderTackingScreenState();
}

class _OrderTackingScreenState extends State<OrderTackingScreen> {
  @override
  Widget build(BuildContext context) {
    OrderTrackingController.to.orderDetails.value =
        new OrderedProductListDetailsModel();
    Future.delayed(Duration.zero).then((value) {
      OrderTrackingController.to.getOrderDetails(orderId: widget.orderId);
    });

    printInfo(info: "selectServiceName ${widget.selectServiceName}");
    printInfo(info: "distance ${widget.distance}");
    printInfo(info: "orderId ${widget.orderId}");
    printInfo(info: "deliveryFee ${widget.deliveryFee}");
    printInfo(info: "offerId ${widget.offerId}");
    printInfo(info: "orderAddress ${widget.orderAddress}");
    printInfo(info: "herokey ${widget.herokey}");
    printInfo(info: "orderStatus ${widget.orderStatus}");
    printInfo(info: "totatlPrice ${widget.totatlPrice}");
    printInfo(info: "discountPrice ${widget.discountPrice}");
    printInfo(info: "deliverTime ${widget.deliverTime}");
    printInfo(info: "onTheWayTime ${widget.onTheWayTime}");
    printInfo(info: "orderRecivedTime ${widget.orderRecivedTime}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            //  color: AppColors.blackColor,
          ),
        ),
        title: Text(
          "Order Tracking",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                _orderInfo(),
                SizedBox(
                  height: 30,
                ),
                sliderimage(),
                _orderStatus(),
                if (widget.orderStatus == 30) _complete_order(),
                SizedBox(
                  height: 30,
                ),
                _ordered_products(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _orderInfo() {
    return InkWell(
      // onTap: () =>
      //     Get.toNamed(AppRoutes.ORDER_TRACKING_STATUS, arguments: []),
      child: Container(
        height: 120,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Order ID",
                  style: Get.textTheme.headlineMedium,
                ),
                AppSpaces.spaces_height_10,
                Text(
                  "#${widget.orderId}",
                  style: Get.textTheme.bodyLarge,
                ),
                if (widget.orderAddress != null)
                  Row(
                    children: [
                      Text(
                        "Order From : ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        "#${widget.orderAddress}",
                        style: Get.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                /* Row(
                  children: [
                    Text(
                      "Far from here : ",
                      style: Get.textTheme.bodyText1,
                    ),
                    Text(
                      "12 km",
                      style: Get.textTheme.bodyMedium,
                    ),
                  ],
                ),*/
                /*  Row(
                  children: [
                    Text(
                      "Estimated time  : ",
                      style: Get.textTheme.bodyText1,
                    ),
                    Text(
                      "30 minute",
                      style: Get.textTheme.bodyMedium,
                    ),
                  ],
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  sliderimage() {
    Widget _widget;

    if (widget.orderStatus == 10) {
      _widget = Center(
        child: Container(
          height: 200,
          child: Image.network('https://i.imgur.com/oCWAXGs.gif'),
        ),
      );
    } else if (widget.orderStatus == 20) {
      _widget = Center(
        child: Container(
          height: 200,
          child: Image.network(
              'https://giphy.com/gifs/hUL5R6B4HYoXADpnvJ/fullscreen'),
        ),
      );
    } else {
      return Container();
    }

    return _widget;
  }

  _orderStatus() {
    print("Order Status => ${widget.orderStatus.toString()}");
    var activeStep = 0;
/*    if (activeStep == 1) {
      activeStep = 0;
    } else if (activeStep == 10) {
      activeStep = 1;
    }*/

    activeStep = _orderStatusCheck(widget.orderStatus);

    print("Order status :: ${activeStep}");

    // return Container() ;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        width: Get.width,
        // color: Colors.orange,
        child: Column(
          children: [
            IconStepper(
              steppingEnabled: true,
              stepRadius: 20.0,
              stepColor: Colors.white,
              activeStepBorderColor: AppColors.primaryColor,
              activeStepColor: Colors.amber,
              lineColor: AppColors.primaryColor,
              direction: Axis.horizontal,
              enableNextPreviousButtons: false,
              icons: [
                Icon(Icons.local_offer),
                Icon(Icons.person),
                Icon(Icons.supervised_user_circle),
                Icon(Icons.set_meal),
                Icon(Icons.done),
              ],

              // activeStep property set to activeStep variable defined above.
              activeStep: activeStep ?? 20,

              // This ensures step-tapping updates the activeStep.
              onStepReached: (index) {
                setState(() {
                  activeStep = _orderStatusCheck(widget.orderStatus);
                  ;
                });
              },
            ),
            header(),
          ],
        ),
      ),
    );
  }

  header() {
    return Center(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                headerText() ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? headerText() {
    int activeStep = int.parse(widget.orderStatus);

    switch (activeStep) {
      case 0:
        return 'Order placed successfully';
      case 1:
        return 'Order placed successfully';
      case 10:
        return 'Restaurant accepted your order';

      case 15:
        return 'Restaurant Preparing your food';

      case 20:
        return "You can pick the product";

      case 30:
        return 'Vendor deliver the product';
    }
  }

  _ordered_products() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 10),
          child: Text(
            "Ordered Products",
            style: Get.textTheme.titleMedium
                ?.copyWith(color: AppColors.blackColor),
          ),
        ),
        Divider(),
        AppSpaces.spaces_height_15,
        Table(
          border: TableBorder.all(color: Colors.transparent),
          children: [
            TableRow(children: [
              Center(child: Text('Product Name')),
              Center(child: Text('Quantity')),
              Center(child: Text('Price')),
            ]),
          ],
        ),
        Obx(() {
          if (!OrderTrackingController.to.loading.value) {
            if (OrderTrackingController.to.orderDetails.value.productDetails !=
                    null &&
                OrderTrackingController
                        .to.orderDetails.value.productDetails?.length !=
                    0) {
              return Table(
                border: TableBorder.all(color: Colors.transparent),
                children: OrderTrackingController
                        .to.orderDetails.value.message?.orderDetails
                        ?.map((e) {
                      print("Product amount: ${e.amount}");

                      return TableRow(children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${OrderTrackingController.to.orderDetails.value.productDetails?.where((element) {
                                printInfo(info: "Product Name Id One: ${element.productNameId}");
                                printInfo(info: "Product Name Id Two: ${e.productNameId}");
                                return element.productNameId.toString() == e.productNameId.toString();
                              }).first.productName}'),
                        )),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${e.quantity}'),
                        )),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '\$ ${(double.parse(e.quantity!) * double.parse(e.amount.toString())).toStringAsFixed(2)}'),
                        )),
                      ]);
                    }).toList() ??
                    [],
              );
            } else {
              return Container();
            }
          } else {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Loading...",
                style: Get.textTheme.bodyMedium,
              ),
            ));
          }
        }),
        Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Total : ",
              style: Get.textTheme.bodyMedium,
            ),
            Obx(() {
              if (OrderTrackingController.to.loading == false) {
                printInfo(info: "Price..............");

                return Text(
                    "\$ ${double.parse(OrderTrackingController.to.totalPrice().toString()).toStringAsFixed(2) ?? ""} ",
                    style: Get.textTheme.bodyMedium);
              } else {
                return Text("", style: Get.textTheme.bodyMedium);
              }
            }),
            AppSpaces.spaces_width_25,
          ],
        ),
        AppSpaces.spaces_height_30,
      ],
    );
  }

  _complete_order() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppSpaces.spaces_height_15,
        AppSpaces.spaces_height_15,
        Text(
          "Order Completed Successfully.",
          style: Get.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        AppSpaces.spaces_height_15,
        RatingBar(
            ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: AppColors.primaryColor,
                ),
                empty: Icon(
                  Icons.star_border,
                  color: AppColors.primaryColor,
                ),
                half: Container()),
            onRatingUpdate: (value) {}),
        AppSpaces.spaces_height_15,
        Container(
          height: 120,
          width: Get.width,
          padding: EdgeInsets.only(left: 8, right: 8),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: Border.all(color: AppColors.grayColor)),
          child: TextField(
            controller: OrderTrackingController.to.reviewController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: "Write comment ",
              border: InputBorder.none,
            ),
          ),
        ),
        AppSpaces.spaces_height_15,
        AppButtonWidget(title: "Sent", leadingCenter: true)
      ],
    );
  }

   _orderStatusCheck(orderStatus) {
    var _value;


    print("orderStatus : ${orderStatus}");

    if (orderStatus == "1") {
      _value = 0;
    } else if (orderStatus == "10") {
      _value = 1;
    } else if (orderStatus == 15) {
      _value = 2;
    } else if (orderStatus == 20) {
      _value = 3;
    } else if (orderStatus == 30) {
      _value = 4;
    }

    return _value;
  }
}
