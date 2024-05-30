import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pizza_user_app/src/core/database/local/LocalDataSourceController.dart';
import 'package:pizza_user_app/src/features/auth/domain/model/token.dart';

import '../../../../core/Error/failures.dart';
import '../../../../core/app_exceptions/app_exceptions.dart';
import '../../../../core/app_snack_bar/app_snack_bar.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../auth/repository/device_token_remote_repository.dart';
import '../../../auth/repository/device_token_repository.dart';

import '../../domain/model/User.dart';
import '../../repository/user_repository.dart';

class ProfileController extends GetxController {
  //Vendor Repository Initiaization

  DeviceTokenRepository _deviceTokenRepository = DeviceTokenRemoteRepository();

  Rx<User> user = User().obs;

  UserRepository _userRepository = new UserRepository();

  static ProfileController to = Get.find();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController countryIdController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController cardNumberController = new TextEditingController();
  TextEditingController cvcController = new TextEditingController();

  bool? isActive;

  File? file = null;

  RxBool? loading;

  @override
  void onInit() {
    // TODO: implement onInit
    getUserInfo();
    initialTextFiledValue();
    loading = false.obs;
    super.onInit();
  }

  initialTextFiledValue() {
    print("user value is ${user.value.fullName}");
    userNameController.text = user.value.fullName ?? "";
    addressController.text = user.value.address ?? "";
    phoneNumberController.text = user.value.phone ?? "";
    emailController.text = user.value.email ?? "";
    countryIdController.text = user.value.countryId.toString() ?? "";
    descriptionController.text = user.value.description ?? "";
    cardNumberController.text = user.value.cardNumber ?? "";
    cvcController.text = user.value.cardCvc ?? "";
  }

  Future<User?>? getUserInfo({String? token}) async {
    //if (user.value == null) {

    // print("Get user info .... ${token.toString()}");

    Token? _token = await LocalDataSourceController().getToken();

    if (_token == null) {
      return null;
    }

    AuthController.to.token = _token.token ?? "";

    Either<Failure, http.Response>? res = await _userRepository.getUser();

    res?.fold((l) {
      print("Error is ${l.toString()}");
      return AppExceptionHandle.exceptionHandle(l);
    }, (r) {
      user.value = User.fromJson(jsonDecode(r.body));

      printInfo(info: "User Name ... ${user.value.fullName}");

/*      //set user previous lat lang value ;
      PickCurrentLocationController.to.latlng.value = LatLng(
          double.parse(user.value.lat_value),
          double.parse(user.value.long_value));*/

      initialTextFiledValue();
    });

    return user.value;
    // }
  }

  /*setLoading(isLoading) {
    loading = isLoading;
    update();
  }
*/
  setFile(File file) {
    this.file = file;
    update();
  }

  setIsActiveStatus(bool isActive) {
    this.isActive = isActive;
    update();
  }

  Future<bool> userUpdateProfile() async {
    bool isSuccess = false;

    if (signUpFormValidation()) {
      loading?.value = true;

      User body = User(
        fullName: userNameController.value.text,
        address: addressController.value.text,
        description: descriptionController.value.text,
        countryId: "+88",
        email: emailController.value.text,
        phone: phoneNumberController.value.text,
        cardCvc: cvcController.value.text,
        cardNumber: cardNumberController.value.text,
        customer_id: user.value.customer_id.toString(),
        genderId: user.value.genderId.toString(),
        /*lat_value:
            PickCurrentLocationController.to.latlng.value.latitude.toString(),
        long_value:
            PickCurrentLocationController.to.latlng.value.longitude.toString(),*/
        photo: "",
        createdAt: "",
        updatedAt: "",
      );

      Either<dynamic, Failure>? response = await _userRepository.updateProfile(
          user: body, file: file, imageKey: "photo");

      response?.fold((l) {
        //  printInfo(info: "Status Code is : : : ${l.statusCode}");

        printInfo(info: "Left ============>  ${l}");

        if (l["success"] != null) {
          getUserInfo();

          AppSnackBar.successSnackbar(msg: l["message"].toString());
        } else if (l["error"] != null) {
          AppSnackBar.errorSnackbar(msg: l["message"].toString());
        } else {
          isSuccess = true;
        }

        loading?.value = false;
      }, (r) {
        loading?.value = false;

        // ExceptionHandle.exceptionHandle(r);

        print("Errror for : : :");

        isSuccess = false;
      });
    } else {
      loading?.value = false;

      isSuccess = false;
    }

    return isSuccess;
  }

  saveDeviceToken(String deviceToken) async {
    String? deviceToken = await _deviceTokenRepository.getDeviceToken();

    print("Device Token is : : : ${deviceToken.toString()}");

    _deviceTokenRepository.saveDeviceToken(
        deviceToken, user.value.customer_id.toString());
  }

  signUpFormValidation() {
    if (userNameController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "User Name can not be empty");
      return false;
    } else if (addressController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Address can not be empty");
      return false;
    } else if (phoneNumberController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Phone Number can not be empty");
      return false;
    } else if (emailController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Email can not be empty");
      return false;
    } else if (countryIdController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Country ID can not be empty");
      return false;
    }
    /*else if (descriptionController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Description can not be empty");
      return false;
    }*/
    /*else if (cardNumberController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Card Number can not be empty");
      return false;
    }*/ /*else if (cvcController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "CVC can not be empty");
      return false;
    } */
    else {
      return true;
    }
  }
}
