/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common_widgets/app_button.dart';
import '../../../core/common_widgets/app_loading.dart';
import '../../../core/common_widgets/app_text_fields.dart';
import '../../../core/utils/spaces/AppSpaces.dart';
import 'Controller/OtpController.dart';


class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OtpController.to.startCountdownTimer();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpaces.spaces_height_5,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'OTP Code',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          AppTextFieldWidget(
            hint: 'Enter OTP Code',
            textInputType: TextInputType.number,
            controller: OtpController.to.phoneOTPCodeText,
          ),
          AppSpaces.spaces_height_10,
          Obx(
                () {
              if (OtpController.to.isOTPScreenProcessing.value) {
                return Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: AppLoading(),
                  ),
                );
              } else {
                return AppButtonWidget(
                  leadingCenter: true,
                  title: 'Continue',
                  onTab: () {
                    OtpController.to.phoneNumberOTPCodeVerification();
                  },
                );
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Obx(() {
              if (OtpController.to.countDownstart.value > 0) {
                return Text(
                  'Remaining Time  ${OtpController.to.countDownstart.value}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'OTP Code Expired',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppButtonWidget(
                        title: "Resend",
                        leadingCenter: true,
                        backgroundColor: Colors.deepOrange,
                        width: 100,
                        onTab: () {
                          OtpController.to.resendOTPCode();
                        }),
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
*/
