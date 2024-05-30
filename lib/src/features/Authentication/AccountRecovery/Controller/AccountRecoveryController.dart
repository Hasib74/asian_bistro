import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../../core/Error/failures.dart';
import '../../../../core/routing/app_routes.dart';
import '../../data/authentication_repository.dart';
import '../../data/otp_repository.dart';


class AccountRecoveryController extends GetxController {
  static AccountRecoveryController to = Get.find();
  TextEditingController phoneNumberText = TextEditingController();
  TextEditingController phoneOTPCodeText = TextEditingController();

  String selectedCountryCode = '+880';
  List<String> allCountries = ["+880", "+1"];

  static String? userPhonoNo;


  bool isPhoneNoScreenProcessingInprogress = false;
  bool isOTPScreenProcessing = false;
  AuthenticationRepository _authenticationRepository =
      new AuthenticationRepository();
  OtpRepository _otpRepository = new OtpRepository();

  @override
    void onInit() {
      // TODO: implement onInit
      super.onInit();
      loadCountries();
    }

    phoneNumberVerification()
    {
      if(phoneNumberFormValidation()) {
        isPhoneNoScreenProcessingInprogress = true;
        update();
        String phoneNo = phoneNumberText.text;
        String countryCode = selectedCountryCode.substring(1);
        if(phoneNo.contains(countryCode)) {
          phoneNo = phoneNo.substring(countryCode.length);
        }else if (phoneNo[0] == '0') {
          phoneNo = phoneNo.substring(1);
        }
        phoneNo = countryCode + '' +phoneNo;
        userPhonoNo = phoneNo;
        print("phone number is..........${userPhonoNo}");

        sendAccountRecoveryPassword(userPhonoNo??'');
      }
    }

    updateSelectedMenuItem(String newValue) {
      selectedCountryCode = newValue;
      update();
    }

    sendAccountRecoveryPassword(String phoneNumber) async {
      Either<http.Response,Failure>? response = await _authenticationRepository.sendAccountRecoveryPassword(
        phoneNumber);

        response?.fold((l) {
          print("success.........."+l.body);
          isPhoneNoScreenProcessingInprogress = false;
          Map valueMap = jsonDecode(l.body.toString());
       

          if((valueMap['success'] == 'true') && (valueMap['status_code'] == '200')) {
            update();
            Get.toNamed(AppRoutes.LOG_IN);
            successSnackbar(msg: "New Password sent successfully");
            isPhoneNoScreenProcessingInprogress = false;
          }
         else if((valueMap['success'] == 'true') && (valueMap['status_code'] == '404')) {
           update();
            errorSnackbar(msg: "Not Registered Number");
            isPhoneNoScreenProcessingInprogress = false;
          }
          else {
            update();
            errorSnackbar(msg: "Network Error");
          }
        }, (r) {
          isPhoneNoScreenProcessingInprogress = false;
          update();
          errorSnackbar(msg: "Network Error");
        });
    }

    phoneNumberFormValidation() {
    if (phoneNumberText.text.isEmpty ) {
      errorSnackbar(msg: "Invalid Phone Number");
      return false;
    } else if (!phoneNumberText.text.isNum) {
      errorSnackbar(msg: "Invalid Phone Number");
      return false;
    }
    return true;
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

    void successSnackbar({@required String? msg}) {

        Get.snackbar('$msg', "Success !",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[200],
        icon: Icon(
          Icons.check_circle_outline_outlined,
          color: Colors.white,
        ),
        colorText: Colors.white);
  }

}