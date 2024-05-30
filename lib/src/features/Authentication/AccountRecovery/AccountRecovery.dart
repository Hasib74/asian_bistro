
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:loading_indicator/loading_indicator.dart';

import '../../../core/common_widgets/app_button.dart';
import '../../../core/common_widgets/app_text_fields.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../core/utils/spaces/AppSpaces.dart';
import 'Controller/AccountRecoveryController.dart';


class AccountRecovery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                'Account Recovery',
                style: Theme.of(context).textTheme.titleMedium,
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

            GetBuilder<AccountRecoveryController>(
              builder: (_){
                print("is loading "+_.isPhoneNoScreenProcessingInprogress.toString());
                if(_.isPhoneNoScreenProcessingInprogress){
                  return Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: LoadingIndicator(indicatorType: Indicator.lineSpinFadeLoader) ,
                    ),
                  );
                }else {
                  return AppButtonWidget(
                    leadingCenter: true,
                    title: 'Continue',
                    onTab: () {
                      AccountRecoveryController.to.phoneNumberVerification();
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget createPhoneNumberTextField() {
    return Expanded(
      child: AppTextFieldWidget(
        maxLines: 1,
        hint: 'Enter your phone number',
        textInputType: TextInputType.number,
        controller: AccountRecoveryController.to.phoneNumberText,
      ),
    );
  }

  Widget createCountryDropdownlist() {
    return GetBuilder<AccountRecoveryController>(
      builder: (_){
        return Container(
          width: 100,
          decoration: BoxDecoration(
              border: Border.all(width: 1,color: AppColors.grayColor),
            ),
            child: Center(
              child: DropdownButton(
                value: AccountRecoveryController.to.selectedCountryCode.toString(),
                onChanged: (newValue) {
                  print(newValue);
                  _.selectedCountryCode = newValue ??"";
                  _.updateSelectedMenuItem(newValue ??"");
                },
                items: AccountRecoveryController.to.allCountries.map((countryCode){
                  return DropdownMenuItem(
                    child: new Text(countryCode.toString(),textAlign: TextAlign.center,),
                    value: countryCode.toString(),
                  );
                }).toList(),
              ),
            ),
          );
  },
  );
  }


}