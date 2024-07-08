import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/features/Authentication/SignIn/Controller/SignInController.dart';

import '../../../core/Error/failures.dart';
import '../../../core/app_exceptions/app_exceptions.dart';
import '../../../core/app_snack_bar/app_snack_bar.dart';
import '../../../core/database/local/LocalDataSourceController.dart';
import '../../PickCurrentLocation/Controller/PickCurrentLocationController.dart';
import '../../all_products/data/domain/model/product_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../../cart/controller/CartController.dart';
import '../../cart/domain/model/cart_model.dart';
import '../../order/data/repository/OrderRepository.dart';
import '../../profile/screen/EditProfileController/ProfileController.dart';
import '../domain/model/OrderModel.dart';

class CheckOutController extends GetxController {
  static CheckOutController to = Get.find();

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

    printInfo(info: "Customer ID ::  ${ProfileController.to}");

    var _response = null;

    print("Customer ID ::  ${CartController.to.amount.toString()}");

    try {
      // AuthController.to.token = await SignInController.to.getToken().;

      if (AuthController.to.token != null) {
        CheckOutController.to.loading.value = true;

        printInfo(
            info:
                "Vendor Offer email : ${ProfileController.to.user.value.email}    ");
        Either<dynamic, Failure>? _data =
            await CheckOutController.to._order(new OrderModel(
          offerId: null,
          discount: null,
          user_id: ProfileController.to.user.value.customer_id.toString(),
          paidAmount: CartController.to.amount.toString(),
          totalAmount: total_amount(),
          paymentType: 1.toString(),
          payment_status: "pending",
          // 1 == cach and 2 == online
          deliveryFee: "0",
          serviceProviderId: 1,
          //
          customer_email: ProfileController.to.user.value.email,
          customerId: ProfileController.to.user.value.customer_id.toString(),

          orderDetails: CartController.to.cartLst
              .map(
                (e) => OrderDetails(
                  productSize: e.productNames?.productSize.toString(),
                  productNameId: e.productNames?.product_name_id.toString(),
                  quantity: e.count.toString(),
                  amount: e.price.toString(),
                  product_name: e.productNames?.productName.toString(),
                  extraItems: e.productNames?.extraItems
                      ?.map((e) => OrderExtraItems(
                            extra_item_id: e.extraItemId.toString(),
                            extra_item_price: e.extraItemPrice.toString(),
                          ))
                      .toList(),
                ),
              )
              .toList(),
          lat_value: PickCurrentLocationController.to.latlng.value.latitude,
          long_value: PickCurrentLocationController.to.latlng.value.longitude,
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
            await CheckOutController.to._order(new OrderModel(
          lat_value: PickCurrentLocationController.to.latlng.value.latitude,
          long_value: PickCurrentLocationController.to.latlng.value.longitude,
          user_id: ProfileController.to.user.value.customer_id.toString(),
          /*  offerId:
              (CartController.to.cartLst[0].vendorType.offer.id).toString(),*/
          discount: CartController.to.cartLst[0].productNames?.offer_amount,
          paidAmount: CartController.to.amount.toString(),
          totalAmount: total_amount(),

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
                    productSize: e.productNames?.productSize.toString(),
                    productNameId: e.productNames?.product_name_id.toString(),
                    quantity: e.count.toString(),
                    amount: e.price.toString(),
                    extraItems: e.productNames?.extraItems
                        ?.map((e) => OrderExtraItems(
                              extra_item_id: e.extraItemId.toString(),
                              extra_item_price: e.extraItemPrice.toString(),
                            ))
                        .toList(),
                  ))
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

  total_amount() {
    double _amount = 0.0;
    /* try {*/
    List<Cart> _temp_cart_list = [];
    var response = LocalDataSourceController.to.getCartList();
    printInfo(info: "GetCart =>> ${response}");

    List data = jsonDecode(response);

    data.forEach((element) {
      printInfo(info: "GetCart CARTLIST 12 =>> ${element}");
      var body = jsonDecode(element);
      _temp_cart_list.add(new Cart(
        count: body["qty"],
        price: body["price"],
        productNames: ProductNames.fromJson(body[
            "productname"]), /*   vendorType: VendorOfferController.to.selectedVendor.value*/
      ));
    });

    printInfo(info: "_temp_cart_list  ${_temp_cart_list.length}");
    //_amount(0.0);

    _temp_cart_list.forEach((element) {
      _amount += double.parse((int.parse(element.count.toString()) *
              double.parse(element.productNames?.price ?? "0.0"))
          .toString());
      /* if (isPlus) {
          print("Amount ==> ${element.price}");

        }*/
    });

    _temp_cart_list.forEach((element) {
      // printInfo(
      //     info: "Extra Items price == ${element.productNames?.extraItems}");

      if (element.productNames?.extraItems?.isNotEmpty ==true) {
        _amount += double.parse(element.productNames?.extraItems
                ?.map((e) => e.extraItemPrice)
                .reduce((value, element) =>
                    "${double.parse(value!) + double.parse(element!)}") ??
            "0");
      }
    });

/*      _temp_cart_list.forEach((element) {
        print("Cart Size price 666: ${element.productNames?.sizePrice}");
        amount.value += double.parse(element.productNames?.sizePrice ?? "0.0");
      });*/

    print("Total Amount ::: ${_amount.toString()}");
    /*  } catch (err) {
      return "0.0";
    }*/

    return _amount.toString();
  }
}
