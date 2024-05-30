import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../core/common_widgets/app_button.dart';
import '../../../core/common_widgets/app_loading.dart';
import '../../../core/common_widgets/app_text_fields.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../core/utils/spaces/AppSpaces.dart';
import 'Controller/SignInController.dart';

class SignIn extends StatelessWidget {
  var argument;

  @override
  Widget build(BuildContext context) {
    argument = Get.arguments;

    print("Argument is  ${argument}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Obx(
        () => AbsorbPointer(
          absorbing: SignInController.to.isLoading.value,
          child: Stack(
            children: [
              _body(),
              _loading(),
            ],
          ),
        ),
      ),
    );
  }

  _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextFieldWidget(
            leadingIcon: Icons.perm_identity,
            hint: "Email",
            focusNode: SignInController.to.focusNode,
            controller: SignInController.to.emailController),
        AppSpaces.spaces_height_15,

        AppTextFieldWidget(
            obscureText: true,
            leadingIcon: Icons.lock,
            hint: "Password",
            focusNode: SignInController.to.focusNode,
            controller: SignInController.to.passwordController),

        AppSpaces.spaces_height_25,

        AppButtonWidget(
            onTab: () async {
              SignInController.to.focusNode.unfocus();
              SignInController.to.isLoading(true);
              bool isSuccess = await SignInController.to.signIn();
              if (isSuccess) {
                if (argument == null) {

                  Get.offAllNamed(AppRoutes.DISPLAY);
                  // Get.offAllNamed(AppRoutes.SERVICE_TYPE_OPTION);
                } else {
                  Get.back(result: true); }
              }
              SignInController.to.isLoading(false);
            },
            title: "Log In",
            leadingCenter: true,
            horizontal_padding: 16),
        AppSpaces.spaces_height_30,

        _createAccount_or_recoverAccount(),

        // _social_logIn(),

        //Spacer(),

        AppSpaces.spaces_height_25,

       // argument == "Checkout" ? Container() : _skip(),

        //AppTextFieldWidget(),
      ],
    );
  }

  Padding _createAccount_or_recoverAccount() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              InkWell(
                child: new Text(
                  "Create account",
                  style: Get.textTheme.titleLarge
                      ?.copyWith(color: AppColors.primaryColor),
                ),
                onTap: () {
                  print("click on create account");
                  Get.toNamed(AppRoutes.SIGNUP_SCREEN, arguments: argument);
                },
              ),
              Container(
                width: 130,
                height: 1,
                color: AppColors.primaryColor,
              )
            ],
          ),
          // Column(
          //   children: [
          //     InkWell(
          //       child: new Text(
          //         "Recover account",
          //         style: Get.textTheme.bodySmall
          //             ?.copyWith(color: AppColors.primaryColor),
          //       ),
          //       onTap: () {
          //         Get.toNamed(AppRoutes.ACCOUNT_RECOVER);
          //       },
          //     ),
          //     Container(
          //       width: 100,
          //       height: 1,
          //       color: AppColors.primaryColor,
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }

/*  _social_logIn() {
    return Column(
      children: [
        AppSpaces.spaces_height_10,
        Text(
          "Signin With",
          style: Get.theme.textTheme.headline1,
        ),
        AppSpaces.spaces_height_10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.facebook,
              width: 40,
              height: 40,
            ),
            AppSpaces.spaces_width_10,
            SvgPicture.asset(
              AppAssets.google,
              width: 40,
              height: 40,
            ),
            AppSpaces.spaces_width_10,
            SvgPicture.asset(
              AppAssets.twitter,
              width: 40,
              height: 40,
            ),
          ],
        ),
      ],
    );
  }*/

  _skip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => Get.offAllNamed(AppRoutes.DISPLAY),
          child: Text(
            "Skip >",
            style: Get.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.primaryColor),
          ),
        ),
        AppSpaces.spaces_width_25,
      ],
    );
  }

  _loading() {
    return Obx(() {
      return SignInController.to.isLoading.value
          ? Positioned.fill(
              child: Align(
              alignment: Alignment.center,
              child: AppLoading(),
            ))
          : Container();
    });
  }
}
