/*
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/Error/failures.dart';
import '../../../../core/Network/network_info.dart';
import '../../../../core/remote/app_helper/app_remote_helper.dart';
import '../../../../core/remote/urls/app_urls.dart';
import '../../../../core/routing/app_routes.dart';
import '../../data/otp_repository.dart';


class OtpController extends GetxController {
  static OtpController to = Get.find();
  TextEditingController phoneNumberText = TextEditingController();
  TextEditingController phoneOTPCodeText = TextEditingController();

  RxString selectedCountryCode = '+880'.obs;
  List<String> allCountries = ["+880", "+1"];

  RxString userPhonoNo = ''.obs;

  RxBool isPhoneNoScreenProcessingInprogress = false.obs;
  RxBool isOTPScreenProcessing = false.obs;

  RxInt countDownstart = 30.obs;
  int phoneVerificationOTCode = 0;

  OtpRepository _otpRepository = new OtpRepository();

  @override
  void onInit() {
    super.onInit();
    loadCountries();
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }

  */
/*
   ==============================================================
   ===================== Phone Number Screen ====================
   ==============================================================
   *//*

  phoneNumberVerification() {
    generateRandomNumber();
    if (phoneNumberFormValidation() && phoneVerificationOTCode > 999) {
      isPhoneNoScreenProcessingInprogress.value = true;
      update();
      String phoneNo = phoneNumberText.text;
      String countryCode = selectedCountryCode.substring(1);
      if (phoneNo.contains(countryCode)) {
        phoneNo = phoneNo.substring(countryCode.length);
      } else if (phoneNo[0] == '0') {
        phoneNo = phoneNo.substring(1);
      }
      phoneNo = countryCode + '' + phoneNo;
      userPhonoNo.value = phoneNo;
      print("phone number okey...${phoneNo}");
      sendOTPCode(userPhonoNo.value);
    }
  }

  sendOTPCode(String phoneNumber) async {
    Either<http.Response, Failure>? authResponse =
        await _otpRepository.sendPhoneVerificationOTPCode(
            phoneNumber, phoneVerificationOTCode.toString());

    authResponse?.fold((l) {
      print("phone otp send suscess " + l.body);
      isPhoneNoScreenProcessingInprogress.value = false;
      Map valueMap = jsonDecode(l.body.toString());
      if (valueMap['success'] == 'true') {
        Get.toNamed(AppRoutes.OTP_SCREEN);
      } else {
        update();
        errorSnackbar(msg: "Network Error");
      }
    }, (r) {
      isPhoneNoScreenProcessingInprogress.value = false;
      update();
      errorSnackbar(msg: "Network Error");
    });
  }

  */
/* updateSelectedMenuItem(String newValue) {
    selectedCountryCode = newValue;
    update();
  }*//*


  phoneNumberFormValidation() {
    if (phoneNumberText.text.isEmpty || phoneNumberText.text.length < 10) {
      errorSnackbar(msg: "Invalid Phone Number");
      return false;
    } else if (!phoneNumberText.text.isNum) {
      errorSnackbar(msg: "Invalid Phone Number");
      return false;
    }
    return true;
  }

  */
/*
   ==============================================================
   ===================== OTP Check =============================
   ==============================================================
   *//*


  phoneNumberOTPCodeVerification() async {
    if (phoneVerificationOTCode == 0) {
      errorSnackbar(msg: "Your OTP Code Expired");
      Get.toNamed(AppRoutes.SIGNUP_SCREEN, arguments: userPhonoNo);
    } else if (phoneVerificationOTCode.toString() == phoneOTPCodeText.text) {
      Get.toNamed(AppRoutes.SIGNUP_SCREEN, arguments: userPhonoNo);
    } else {
      errorSnackbar(msg: "Invalid OTP Code");

      Get.toNamed(AppRoutes.SIGNUP_SCREEN, arguments: userPhonoNo);
    }
  }

  phoneNumberOTPCodeFormValidation() {
    if (phoneOTPCodeText.text.isEmpty) {
      print('opt error ${phoneOTPCodeText.text}');
      errorSnackbar(msg: "Invalid OTP Code");
      return false;
    }
    return true;
  }

  */
/*
   ==============================================================
   ===================== OTP Resend =============================
   ==============================================================
   *//*


  void resendOTPCode() {
    print('resend code ');
    generateRandomNumber();
    sendOTPCode(userPhonoNo.value);
    startCountdownTimer();
  }

  Timer? _timer;
  int timerIncrementStepValue = 30;

  void startCountdownTimer() {
    countDownstart.value = 1 + timerIncrementStepValue;
    if (_timer != null) {
      print('reset timer');
      _timer?.cancel();
    }
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (countDownstart.value <= 0) {
          print('invalid timer');
          _timer?.cancel();
          _timer = null;
          phoneVerificationOTCode = 0;
          timerIncrementStepValue += 20;
        } else {
          countDownstart.value--;
          print('calling again ${countDownstart}');
        }
        update();
      },
    );
  }

  */
/*
   ==============================================================
   ===================== HELPER METHODS =============================
   ==============================================================
   *//*


  Future<Either<dynamic, Failure>> getCountries() async {
    try {
      if (await NetworkInfoController.to.isConnected) {
        print("SUB BODY country ");
        dynamic response = await ApiClient.Request(
            url: "${ApiUrls.country_list}",
            enableHeader: false,
            body: null,
            method: Method.GET);

        return Left(response);
      } else {
        print("network error is occured");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  void loadCountries() async {
    Either<dynamic, Failure>? authResponse =
        await _otpRepository.getAllCountries();
    authResponse?.fold((l) {
      Map valueMap = jsonDecode(l.body);
      print(valueMap['message']);
      List<String> list = <String>[];
      valueMap['message'].forEach((v) {
        list.add(v['phone_code'].toString());
        print(v['phone_code'].toString());
      });
      if (list.length > 2) {
        allCountries = list;
        update();
      }
    }, (r) {});
  }

  void errorSnackbar({@required String? msg}) {
    Get.snackbar('$msg', "Error !",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.deepOrange[200],
        colorText: Colors.white);
  }

  int generateRandomNumber() {
    Random random = new Random();
    int max = 9999, min = 1000;
    phoneVerificationOTCode = min + random.nextInt(max - min);
    print("range value is " + phoneVerificationOTCode.toString());
    return phoneVerificationOTCode;
  }
}
*/
