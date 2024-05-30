import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/Error/failures.dart';
import '../../../../core/app_exceptions/app_exceptions.dart';
import '../../../../core/app_snack_bar/app_snack_bar.dart';
import '../../../../core/database/local/LocalDataSourceController.dart';
import '../../../../core/firebase_helper/Firebase/FirebaseRepoManeger.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../auth/domain/model/token.dart';
import '../../../profile/screen/EditProfileController/ProfileController.dart';
import '../../data/authentication_local_repository.dart';
import '../../data/authentication_repository.dart';

class SignInController extends GetxController {
  AuthenticationRepository _authenticationRepository =
      new AuthenticationRepository();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  RxBool isLoading = false.obs;

  static SignInController to = SignInController();

  FocusNode focusNode = new FocusNode();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    /* emailController.text = "hasibakon74@gmail.com";
    passwordController.text = "123456";*/
  }

  Future<Token?> getToken() {
    return _authenticationRepository.getToken();
  }

  Future<bool> signIn() async {
    bool isSuccess = false;
    if (signInValidation()) {
      isLoading.value = true;

      var body = {
        "email": emailController.value.text,
        "password": passwordController.value.text,
      };

      Either<dynamic, Failure>? response =
          await _authenticationRepository.signIn(body);

      response?.fold((l) async {
        // try {
        printInfo(info: "Sign in info ::::: ${l.body}");
        if (jsonDecode(l.body)["error"] == null) {
          AuthenticationLocalRepository authenticationLocalRepo =
              AuthenticationLocalRepository();

          // var token = _authenticationLocalRepo.getToken();

          // if(jsonDecode(l))

          try {
            AuthController.to.token = jsonDecode(l.body)["token"];
            print(
                "Token.............................  ${AuthController.to.token}");
            print("Token in sign in controller ${AuthController.to.token}");

            LocalDataSourceController.to
                .setToken(Token.fromJson(jsonDecode(l.body)));

            await ProfileController.to
                .getUserInfo(token: AuthController.to.token);

            _saveToken(jsonDecode(l.body)["token"]);

            emailController.clear();
            passwordController.clear();
          } on Exception catch (e) {
            // TODO

            print("Exception in sign in controller ${e.toString()}");
          }

          Get.back(result: true);

          isSuccess = true;
        } else {
          // ExceptionHandle.exceptionMessage(jsonDecode(l.body)["message"]);

          isSuccess = false;

          AppSnackBar.errorSnackbar(
              msg: jsonDecode(l.body)["message"].toString());
        }
        // } /*on Exception catch (e) {
        // TODO

        //}*/
      }, (r) {
        // ExceptionHandle.exceptionHandle(r);

        isSuccess = false;

        AppExceptionHandle.errorMessage(
            "Failed to login. Please check your email and password");
      });
    } else {
      isSuccess = false;
    }

    isLoading.value = false;

    return isSuccess;
  }

  signInValidation() {
    bool isValidated = false;

    if (emailController.text.isEmpty) {
      isValidated = false;
      AppSnackBar.errorSnackbar(msg: "Email is required");
      return false;
    } else if (passwordController.text.isEmpty) {
      isValidated = false;

      AppSnackBar.errorSnackbar(msg: "Password is required");
      return false;
    } else {
      isValidated = true;
    }

    return isValidated;
  }

  void _saveToken(String? token) async {
    print("Device Token ............ ${token}");
    if (token != null) {
      ProfileController.to.getUserInfo()?.then((value) async {
        String _deviceToken = await FirebaseRepoManager.fbTokenRepository
            .getFirebaseDeviceToken();
        print("DeviceToken ............ ${_deviceToken}");
        ProfileController.to.saveDeviceToken(_deviceToken);
      });
    }
  }
}
