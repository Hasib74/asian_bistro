import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_button.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_text_fields.dart';
import 'package:pizza_user_app/src/core/utils/spaces/AppSpaces.dart';
import 'package:pizza_user_app/src/features/delivery_options/writeAddress/write_address_for_food_order.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/utils/colors/app_colors.dart';
import 'package:get/get.dart';

class WriteAddressScreenCatering extends StatefulWidget {
  const WriteAddressScreenCatering({super.key});

  @override
  State<WriteAddressScreenCatering> createState() =>
      _WriteAddressScreenCateringState();
}

class _WriteAddressScreenCateringState
    extends State<WriteAddressScreenCatering> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: Icon(Icons.close),
        backgroundColor: AppColors.primaryColor,
        title: Text("Add an address"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          //height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSpaces.spaces_height_15,
              AppSpaces.spaces_height_15,
              _textFiledWithLavel(lavel: "Address"),
              AppSpaces.spaces_height_15,
              _textFiledWithLavel(lavel: "Suite/Apartment/Business"),
              AppSpaces.spaces_height_15,
              _textFiledWithLavel(lavel: "Delivery Instructions"),
              AppSpaces.spaces_height_15,
              AppSpaces.spaces_height_15,
              AppSpaces.spaces_height_15,
              AppButtonWidget(
                  title: "Enter",
                  width: 100,
                  leadingCenter: true,
                  onTab: () {

                    Get.back();

                    Get.to(()=>WriteAddressScreenForFoodOrder());
                  }),
              AppSpaces.spaces_height_15,
              AppSpaces.spaces_height_15,
              AppSpaces.spaces_height_15,
              AppSpaces.spaces_height_15,
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: _saveForFuture(),
              // )
            ],
          ),
        ),
      ),
    );
  }

  _textFiledWithLavel({String? lavel, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            lavel ?? "",
            style: Get.textTheme.titleMedium,
          ),
        ),
        AppSpaces.spaces_height_10,
        AppTextFieldWidget(),
      ],
    );
  }

  _saveForFuture() {
    bool _isSaved = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Save this address for future use",
          style: Get.textTheme.titleMedium!
              .copyWith(color: AppColors.primaryColor),
        ),
        CupertinoSwitch(
            value: _isSaved,
            onChanged: (value) {
              setState(() {
                _isSaved = !value;
              });
            })
      ],
    );
  }
}
