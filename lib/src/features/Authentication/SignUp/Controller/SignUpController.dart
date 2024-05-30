import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/Error/failures.dart';
import '../../../../core/app_snack_bar/app_snack_bar.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../auth/domain/model/token.dart';
import '../../OTP/Controller/OtpController.dart';
import '../../SignIn/Controller/SignInController.dart';
import '../../data/authentication_local_repository.dart';
import '../../data/authentication_repository.dart';

class SignUpController extends GetxController {
  TextEditingController nameController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController profileImageController = new TextEditingController();

  bool? isCheckedAcceptTrams = false;
  bool? isSendNotification = false;

  FocusNode focusNode = new FocusNode();

  //call repository
  AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

/*    nameController.text = "jakaria";
    usernameController.text = "jakariacse35";
    emailController.text = "jakariacse35@gmail.com";
    descriptionController.text = "abc... ... ..";

    genderController.text = "1"; //male
    countryController.text = "Bangladesh";
    passwordController.text = "123456";
    confirmPasswordController.text = "123456";*/

/*    phoneController.text = OtpController.to.selectedCountryCode +
        OtpController.to.phoneNumberText.text;*/

/*    MapData.userPosition.determinePosition().then((value) {
      MapData.mapFunction
          .latLagToString(LatLng(value.latitude, value.longitude))
          .then((value) => addressController.text = value);
    });*/
  }

  static SignUpController to = Get.find();

  Future<Token?> getToken() {
    return _authenticationRepository.getToken();
  }

  Future<bool> SignUp() async {
    bool isSuccess = false;
    if (signupValidation() == true) {
      var body = {
        "full_name": nameController.value.text,
        "address": addressController.value.text,
        "description": descriptionController.value.text,
        "phone": "+" + phoneController.value.text,
        "country_id": "+880",
        "country_code": "+880", //Bangladesh
        "email": emailController.value.text,
        "gender_id": genderController.value.text,
        "password": passwordController.value.text,
        "c_password": confirmPasswordController.value.text,
        "user_name": usernameController.value.text,
        "lat_value": "0.0",
        "long_value": "0.0",
      };

      isLoading.value = true;

      Either<dynamic, Failure>? response =
          await _authenticationRepository.userSignUp(body);

      response?.fold((l) {
        if (jsonDecode(l.body)["error"] == null) {
          AuthenticationLocalRepository _authenticationLocalRepo =
              new AuthenticationLocalRepository();

          _authenticationLocalRepo
              .storeToken(Token.fromJson(jsonDecode(l.body)));

          _authenticationLocalRepo.getToken().then((value) {
            AuthController.to.token = value?.token;
          });

          SignUpController.to.isLoading.value = false;

          SignInController.to.emailController.text = emailController.text;
          SignInController.to.passwordController.text = passwordController.text;

          SignInController.to.signIn();

          isSuccess = true;
        } else {
          // ExceptionHandle.exceptionMessage(jsonDecode(l.body)["error"]);

          SignUpController.to.isLoading.value = false;

          isSuccess = false;

          AppSnackBar.errorSnackbar(
              msg: jsonDecode(l.body)["error"].toString());
        }
      }, (r) {
        isLoading.value = false;
        //  ExceptionHandle.exceptionHandle(r);

        isSuccess = false;
      });
    } else {
      isSuccess = false;
    }

    return isSuccess;
  }

  bool signupValidation() {
    if (nameController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Name is required");
      return false;
    } else if (usernameController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "User-name is required");
      return false;
    } else if (phoneController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Phone number is required");
      return false;
    } else if (emailController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Email is required");
      return false;
    } else if (passwordController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Password is required");
      return false;
    } else if (confirmPasswordController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Confirm Password is required");
      return false;
    }   else {
      return true;
    }
  }

  void changeAddress(String value) {
    addressController.text = value;
    update();
  }

  clearData() {
    nameController.clear();
    usernameController.clear();
    phoneController.clear();
    emailController.clear();
    descriptionController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    addressController.clear();
  }
}
