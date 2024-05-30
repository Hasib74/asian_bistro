import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/features/checkout_screen/checkout_binding/check_out_binding.dart';
import 'package:pizza_user_app/src/features/checkout_screen/payment_option.dart';

import '../../core/Map/MapData.dart';
import '../../core/common_widgets/app_loading.dart';
import '../../core/routing/app_routes.dart';
import '../../core/utils/colors/app_colors.dart';
import '../../core/utils/spaces/AppSpaces.dart';
import '../OrderSuccess/domain/model/OrderSuccessModel.dart';
import '../PickCurrentLocation/Controller/PickCurrentLocationController.dart';
import '../auth/controller/auth_controller.dart';
import '../cart/controller/CartController.dart';
import '../delivery_options/delivery_options.dart';
import '../profile/screen/EditProfileController/ProfileController.dart';
import 'controller/check_out_controller.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  void initState() {
    // TODO: implement initState

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      CheckoutBinding().dependencies();

      CheckOutController.to.loading(false);
    });

    //PickCurrentLocationController.to.getCurrentLocation();

    super.initState();
  }

  GlobalKey<FormFieldState> addressKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    //Get.put(NetworkInfoController());
    // printInfo(info: "CheckOut  ===> ${Get.context.}");

    return Scaffold(
      bottomNavigationBar: PaymentOption(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              _body(context),
              _loading(),
            ],
          ),
        ),
      ),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppSpaces.spaces_height_20,
          _close_button(),
          _checkOut_text(),
          AppSpaces.spaces_height_25,
          AppSpaces.spaces_height_25,
          _totalItems_and_price(context),
          AppSpaces.spaces_height_25,
          AppSpaces.spaces_height_25,
          _address(context),
          _cashOnDelivery_Or_OnlinePay_buttton(context),
          Spacer(),
          _checkOut_button(context),
          Spacer(),
        ],
      ),
    );
  }

  Align _close_button() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.close,
            size: 30,
          ),
        ),
      ),
    );
  }

  Text _checkOut_text() {
    return Text(
      "Checkout",
      style: Get.textTheme.titleMedium?.copyWith(
        fontSize: 32,
        wordSpacing: 1,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
      ),
    );
  }

  Container _totalItems_and_price(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      height: 80,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey.withOpacity(0.6))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Items",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${CartController.to.cartLst.length}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${double.parse(CartController.to.amount.toString()).toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w800),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _address(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      height: 140,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey.withOpacity(0.6))),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Expanded(child: Container()),
                Expanded(
                    child: Text(
                  "Address",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                )),
                Visibility(
                  visible: false,
                  child: Expanded(
                      child: InkWell(
                    onTap: () async {
                      var picked_location =
                          await Get.toNamed(AppRoutes.PICK_USER_LOCATION);

                      print("Picked Location : ${picked_location}");

                      MapData.mapFunction
                          .latLagToString(picked_location)
                          .then((value) {
                        PickCurrentLocationController.to
                            .latlng(picked_location);
                        ProfileController.to.user.value.lat_value =
                            picked_location.latitude;
                        ProfileController.to.user.value.long_value =
                            picked_location.longitude;
                        ProfileController.to.user.value.address = value;

                        PickCurrentLocationController.to.addressName?.value =
                            value;

                        ProfileController.to.update();

                        ProfileController.to.update();
                        PickCurrentLocationController.to.update();
                      });
                    },
                    child: Text(
                      "Edit",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.primaryColor),
                      textAlign: TextAlign.right,
                    ),
                  )),
                ),
              ],
            ),
          ),
          Spacer(),
          /*  Obx(
            () => Text(
              PickCurrentLocationController.to.addressName?.value ?? "",
              textAlign: TextAlign.center,
            ),
          ),*/

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              key: addressKey,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Enter your address",

                hintStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.primaryColor)),
              ),
              onChanged: (value) {
                ProfileController.to.user.value.address = value;
                ProfileController.to.update();
              },
              controller: TextEditingController()
                ..text = ProfileController.to.user.value.address ?? "",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your address";
                }
              },
            ),
          ),
          Spacer(),
          Spacer(),
        ],
      ),
    );
  }

  Obx _cashOnDelivery_Or_OnlinePay_buttton(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          AppSpaces.spaces_height_25,
          AppSpaces.spaces_height_25,
          InkWell(
            onTap: () => CheckOutController.to.isCashOnDelivery.call(true),
            child: Container(
              width: Get.width * 0.9,
              height: 40,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(45))),
              child: Center(
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Cash On Delivery",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: CheckOutController.to.isCashOnDelivery.value
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, bottom: 10),
                              child: Icon(
                                Icons.check_circle_outline_outlined,
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ))
                  ],
                ),
              ),
            ),
          ),
          AppSpaces.spaces_height_15,
          AbsorbPointer(
            absorbing: true,
            child: Opacity(
              opacity: 0.6,
              child: InkWell(
                onTap: () => CheckOutController.to.isCashOnDelivery.call(false),
                child: Container(
                  width: Get.width * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(45))),
                  child: Center(
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Online Pay",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child:
                                CheckOutController.to.isCashOnDelivery.value ==
                                        false
                                    ? Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Colors.white,
                                      )
                                    : Container(),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _checkOut_button(BuildContext context) {
    return InkWell(
      onTap: () async {
        addressKey.currentState?.save();

        print(
            "addressKey.currentState?.validate() : ${addressKey.currentState?.validate()}");

        if (addressKey.currentState?.validate() == false) {
          print("Address is valid");

          return;
        }

        await Get.to(DeliveryOptions());

        print(
            "Seleted Payment Type ${CheckOutController.to.isCashOnDelivery.value}");
        if (ProfileController.to.user.value.fullName == null) {
          var data = await Get.toNamed(AppRoutes.LOG_IN,
              arguments: AppRoutes.CHECK_OUT);

          await Future.delayed(Duration(seconds: 1));

          if (data) {
            ProfileController.to.getUserInfo();

            if (CheckOutController.to.isCashOnDelivery.value) {
              var _data = await CheckOutController.to.order();

              print("Cash on delivery data 1: ${_data}");

              if (!_data["message"]
                  .toString()
                  .contains("stocks are not avaialable")) {
                List<Route> _route_list = [];

                Get.offNamedUntil(
                  AppRoutes.ORDER_SUCCESS,
                  (route) {
                    _route_list.add(route);

                    printInfo(
                        info: "Success page routes list :: ${_route_list}");

                    if (_route_list.length == 4) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  arguments: OrderSuccessModel.fromJson(_data),
                );
              }
            } else {
              var _data = await CheckOutController.to.order();

              /*     print('One the tab _order ===> ${_order["message"]}');*/

              if (!_data["message"]
                  .toString()
                  .contains(" stocks are not avaialable")) {
                List<Route> _route_list = [];

                Get.offNamedUntil(
                  AppRoutes.ORDER_SUCCESS,
                  (route) {
                    _route_list.add(route);

                    printInfo(
                        info: "Success page routes list :: ${_route_list}");

                    if (_route_list.length == 4) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  arguments: OrderSuccessModel.fromJson(_data),
                );
              }
              // OnlinePaymentController.to.solidController.show();
            }
          }
        } else {
          if (CheckOutController.to.isCashOnDelivery.value) {
            var _data = await CheckOutController.to.order();

            print("Cash on delivery data : ${_data}");

            if (!_data["message"]
                .toString()
                .contains("stocks are not avaialable")) {
              List<Route> _route_list = [];

              Get.offNamedUntil(
                AppRoutes.ORDER_SUCCESS,
                (route) {
                  _route_list.add(route);

                  printInfo(info: "Success page routes list :: ${_route_list}");

                  if (_route_list.length == 4) {
                    return true;
                  } else {
                    return false;
                  }
                },
                arguments: OrderSuccessModel.fromJson(_data),
              );
            }
          } else {
            var _order = await CheckOutController.to.order();

            if (_order == null ||
                _order["message"]
                    .toString()
                    .contains(" stocks are not avaialable")) {
              return;
            }
            var _service_provider_id =
                _order["message"]["order"]["service_provider_id"];
            var _customer_id = _order["message"]["order"]["customer_id"];
            var _order_id = _order["message"]["order"]["id"];

            print(
                'One the tab _order ===> service provider id ${_order["message"]["order"]["service_provider_id"]}');
            print(
                'One the tab _order ===> service provider id ${_order["message"]["order"]["customer_id"]}');

            print(
                'One the tab _order ===> service provider id ${_order["message"]["order"]["id"]}');

            // Get.toNamed(page)

            var _response = await Get.toNamed(AppRoutes.ONLINE_PAY_WEB_VIEW,
                arguments: {
                  "order_id": _order_id,
                  "customer_id": _customer_id
                });

            if (_response) {
              // AppDialog.successDialog(
              //     context: context,
              //     title: "Successfully Ordered",
              //     des:
              //         "Thanks, Your order has been done. Please wait for complete the order .",
              //     dialogType: DialogType.SUCCES);

              //DrawerMenuController.to.drawerMenu(DrawerMenu.TRACK_ORDER);
              List<Route> _route_list = [];

              Get.offNamedUntil(
                AppRoutes.ORDER_SUCCESS,
                (route) {
                  _route_list.add(route);

                  printInfo(info: "Success page routes list :: ${_route_list}");

                  if (_route_list.length == 4) {
                    return true;
                  } else {
                    return false;
                  }
                },
                arguments: OrderSuccessModel.fromJson(_response),
              );
            } else {
              // AppDialog.successDialog(
              //     context: context,
              //     title: "Ops",
              //     des: "Sorry, Failed to order. Please re-order.",
              //     dialogType: DialogType.ERROR);

              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.bottomSlide,
                title: 'Ops',
                desc: 'Sorry, Failed to order. Please re-order.',
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              )..show();
            }

            // OnlinePaymentController.to.solidController.show();
          }
        }
      },
      child: Container(
        width: Get.width * 0.9,
        height: 40,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(45))),
        child: Center(
          child: Text(
            "Checkout Now",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.whiteColor, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  _loading() {
    return Obx(() {
      return CheckOutController.to.loading.value
          ? Positioned.fill(
              child: Align(
              alignment: Alignment.center,
              child: AppLoading(),
            ))
          : Container();
    });
  }

  String _country() {
    try {
      return ProfileController.to.user.value.address.toString().split(",")[2];
    } catch (err) {
      return "";
    }
  }
}
