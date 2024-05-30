import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/features/Authentication/SignIn/Controller/SignInController.dart';

import '../../../core/Error/failures.dart';
import '../../../core/app_exceptions/app_exceptions.dart';
import '../../../core/app_snack_bar/app_snack_bar.dart';
import '../../PickCurrentLocation/Controller/PickCurrentLocationController.dart';
import '../../auth/controller/auth_controller.dart';
import '../../cart/controller/CartController.dart';
import '../../order/data/repository/OrderRepository.dart';
import '../../profile/screen/EditProfileController/ProfileController.dart';
import '../domain/model/OrderModel.dart';

class CheckOutController extends GetxController {
  static CheckOutController to = Get.find();

  TextEditingController addressController = TextEditingController();

  OrderModel? body;

  RxBool loading = false.obs;

  OrderRepository _orderRepository = new OrderRepository();

  RxBool isCashOnDelivery = true.obs;

  Future<Either<dynamic, Failure>?> _order(OrderModel body) async {
    printInfo(info: "Order Body :: ${jsonEncode(body.toJson())}");
    Either<dynamic, Failure>? orderResponse =
        await _orderRepository.order(jsonEncode(body.toJson()));

    return orderResponse;
  }

  Future<dynamic> order({bool isOnlinePayment = false}) async {
    printInfo(info: "App Token ::: ${AuthController.to.token}");

    var _response = null;

    print(
        "Customer ID ::  ${ProfileController.to.user.value.customer_id.toString()}");

    try {
      // AuthController.to.token = await SignInController.to.getToken().;

      if (AuthController.to.token != null) {
        CheckOutController.to.loading.value = true;

        printInfo(
            info:
                "Vendor Offer email : ${ProfileController.to.user.value.email}    ");
        Either<dynamic, Failure>? _data =
            await CheckOutController.to._order(OrderModel(
          lat_value:
              PickCurrentLocationController.to.latlng.value?.latitude.toString(),
          long_value: PickCurrentLocationController.to.latlng.value?.longitude
              .toString(),

          offerId: null,
          discount: null,
          user_id: ProfileController.to.user.value.customer_id.toString(),
          paidAmount: CartController.to.amount.toString(),
          totalAmount: _total_amount(),
          paymentType: 1.toString(),
          payment_status: "pending",
          // 1 == cach and 2 == online
          deliveryFee: "0",
          serviceProviderId: 1,
          //
          customer_email: ProfileController.to.user.value.email,
          customerId: ProfileController.to.user.value.customer_id.toString(),
          orderDetails: CartController.to.cartLst
              .map((e) => OrderDetails(
                  productNameId: e.productNames?.product_name_id.toString(),
                  quantity: e.count.toString(),
                  amount: e.price.toString()))
              .toList(),

          //  serviceProviderId: VendorOfferController.to.selectedVendor.
        ));

        _data?.fold((l) {
          printInfo(info: "Order Response ::: ${l.body}");

          var _decoded_response = jsonDecode(l.body);
          if (_decoded_response["success"] != "false") {
            if (_decoded_response["message"]
                .toString()
                .contains(" stocks are not avaialable")) {
              loading(false);
              AppSnackBar.errorSnackbar(msg: "Stock out.");
            } else {
              CartController.to.clearCart();
              CartController.to.update();
              CartController.to.amount.value = 0;

              printInfo(info: "Order Response ::: ${l.body}");
              // _feedBackRepository.storeFeedBackData(jsonEncode(l.body));
              printInfo(info: "Cash On Delivery Response => ${l}");

              //  Get.offAllNamed(AppRoutes.DISPLAY);
              _response = jsonDecode(l.body);
            }
          } else {
            AppExceptionHandle.errorMessage(_decoded_response["message"]);
          }
        }, (r) {
          print("Right ${r}");
          printInfo(info: "Cash On Delivery Error => ${r.toString()}");
          AppExceptionHandle.exceptionHandle(r);
        });

        CheckOutController.to.loading.value = false;
      }
    } on Exception catch (e) {
      // TODO
      CheckOutController.to.loading.value = false;
      printInfo(info: "Cash On Delivery Cached Error => ${e.toString()}");
    }

    return _response;
  }

  Future<dynamic> onlinePay() async {
    print("App Token ::: ${AuthController.to.token}");

    var id;

    printInfo(info: "App Token ::: ${AuthController.to.token}");

    /*printInfo(
        info:
            "Vendor Offer  : ${CartController.to.cartLst[0].vendorType.offer}    ");*/

    try {
      if (AuthController.to.token != null) {
        CheckOutController.to.loading.value = true;

        Either<dynamic, Failure>? _data =
            await CheckOutController.to._order(OrderModel(
          lat_value: PickCurrentLocationController.to.latlng.value?.latitude,
          long_value: PickCurrentLocationController.to.latlng.value?.longitude,
          user_id: ProfileController.to.user.value.customer_id.toString(),
          /*  offerId:
              (CartController.to.cartLst[0].vendorType.offer.id).toString(),*/
          discount: CartController.to.cartLst[0].productNames?.offer_amount,
          paidAmount: CartController.to.amount.toString(),
          totalAmount: _total_amount(),

          paymentType: 1.toString(),
          payment_status: "pending",

          // 1 == cach and 2 == online
          deliveryFee: "0",

          customer_email: ProfileController.to.user.value.email,

          /*      serviceProviderId:
              CartController.to.cartLst[0].vendorType.id.toString(),*/
          //
          customerId: ProfileController.to.user.value.customer_id.toString(),
          orderDetails: CartController.to.cartLst
              .map((e) => OrderDetails(
                  productNameId: e.productNames?.product_name_id.toString(),
                  quantity: e.count.toString(),
                  amount: e.price.toString()))
              .toList(),

          //  serviceProviderId: VendorOfferController.to.selectedVendor.
        ));

        _data?.fold((l) {
          printInfo(info: "Cash On Delivery Response => ${l.body}");
          var _decoded_response = jsonDecode(l.body);
          if (_decoded_response["success"] != "false") {
            CartController.to.clearCart();
            CartController.to.update();

            printInfo(
                info:
                    "Order ID is  ${_decoded_response["message"]["order"]["id"]}");

            id = _decoded_response["message"]["order"]["id"];
          } else {
            AppExceptionHandle.errorMessage(_decoded_response["message"]);
          }
        }, (r) {
          print("Right ${r}");

          printInfo(info: "Cash On Delivery Error => ${r.toString()}");

          AppExceptionHandle.exceptionHandle(r);
        });

        CheckOutController.to.loading.value = false;

        return id;
      }
    } on Exception catch (e) {
      // TODO
      CheckOutController.to.loading.value = false;
      printInfo(info: "Cash On Delivery Cached Error => ${e.toString()}");
    }
  }

  _total_amount() {
    var _amount;

    if (CartController.to.cartLst[0].productNames?.offer_amount != null) {
      /*  if (CartController.to.cartLst[0].vendorType.offer.offerUnit
              .toString()
              .toLowerCase() !=
          "tk") {*/
      var offer = double.parse((double.parse(CartController
                      .to.cartLst[0].productNames?.offer_amount
                      .toString() ??
                  "0.0") /
              100)
          .toString());

      double _total_amount =
          double.parse(CartController.to.amount.toString()) * offer;

      _amount = CartController.to.amount - _total_amount;
      /* } else {
        _amount = CartController.to.amount -
            CartController.to.cartLst[0].vendorType.offer.amount;
      }*/
    } else {
      _amount = double.parse(CartController.to.amount.toString());
    }

    return _amount.toString();
  }
}
