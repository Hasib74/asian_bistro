/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_snack_bar/app_snack_bar.dart';
import '../../../core/common_widgets/app_button.dart';
import '../../../core/common_widgets/app_loading.dart';
import '../../../core/common_widgets/app_text_fields.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../core/utils/spaces/AppSpaces.dart';
import 'Controller/OtpController.dart';


class PhoneAuthentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Get.put(PhoneAuthentication());

    //  OtpController.to.phoneNumberText.text = "8801731540704";

    // OtpController.to.loadCountries();

    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpaces.spaces_height_5,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select Country Code',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  createCountryDropdownlist(),
                  createPhoneNumberTextField(),
                ],
              ),
            ),
            AppSpaces.spaces_height_10,
            Obx(() {
              print(
                  OtpController.to.isPhoneNoScreenProcessingInprogress.value);
              if (OtpController
                  .to.isPhoneNoScreenProcessingInprogress.value) {
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
                    if (OtpController
                        .to.phoneNumberText.value.text.isPhoneNumber) {
                      OtpController.to.phoneNumberVerification();

                      Get.toNamed(AppRoutes.OTP_SCREEN);
                    } else {
                      AppSnackBar.errorSnackbar(
                          msg: "Please enter your number");
                    }
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }

  Widget createPhoneNumberTextField() {
    return Expanded(
      child: AppTextFieldWidget(
        hint: 'Enter your phone number',
        maxLength: 10,
        textInputType: TextInputType.number,
        controller: OtpController.to.phoneNumberText,
      ),
    );
  }

  Widget createCountryDropdownlist() {
    return Obx(() {
      return Container(
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.grayColor),
        ),
        child: Center(
          child: DropdownButton(
            value: OtpController.to.selectedCountryCode.toString(),
            onChanged: (newValue) {
              print(newValue);
              OtpController.to.selectedCountryCode.value = newValue ?? "";
            },
            items: OtpController.to.allCountries.map((countryCode) {
              return DropdownMenuItem(
                child: new Text(
                  countryCode.toString(),
                  textAlign: TextAlign.center,
                ),
                value: countryCode.toString(),
              );
            }).toList(),
          ),
        ),
      );
    });
  }

// Widget createCountryDropdownlist1(){
//   return Obx(()=>Container (
//     width: 100,
//      decoration: BoxDecoration(
//        border: Border.all(width: 1,color: AppColors.grayColor),
//      ),
//     child: Center(
//       child: DropdownButton(
//         value: OtpController.to.selectedCountryCode.value,
//         onChanged: (newValue) {
//           // setState(() {
//           OtpController.to.selectedCountryCode.value = newValue;
//           // });
//         },
//         items: countryCodes.map((location) {
//           return DropdownMenuItem(
//             child: new Text(location,textAlign: TextAlign.center,),
//             value: location,
//           );
//         }).toList(),
//       ),
//     ),
//   ));
//
// }
//

}
*/
