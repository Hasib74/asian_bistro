import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common_widgets/app_button.dart';
import '../../../core/common_widgets/app_loading.dart';
import '../../../core/common_widgets/app_text_fields.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../core/utils/spaces/AppSpaces.dart';
import '../OTP/Controller/OtpController.dart';
import 'Controller/SignUpController.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //getx  VendorSignUp controller initial setup
  SignUpController _signupController = Get.put(SignUpController());

  var arg;

  //Pages variables
  bool valuefirst = false;

  bool valuesecond = false;

  //BuildContext? context;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SignUpController.to.isLoading.value = false;

    SignUpController.to.clearData();
  }

  @override
  Widget build(BuildContext context) {
    /*  SignUpController.to.phoneController.text =
        OtpController.to.userPhonoNo.value;*/

    arg = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        child: Stack(
          children: [
            _body(context),
            _loading(),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppSpaces.spaces_height_25,
          _name(),
          AppSpaces.spaces_height_10,
          _user_name(),
          AppSpaces.spaces_height_10,
          _phone_number(),
          AppSpaces.spaces_height_10,
          _location(),
          AppSpaces.spaces_height_10,
          _insert_email(),
          AppSpaces.spaces_height_10,
          _password(),
          AppSpaces.spaces_height_10,
          _c_password(),
          AppSpaces.spaces_height_10,
          AppSpaces.spaces_height_10,
          AppSpaces.spaces_height_10,
          trms_and_condition(context),
          AppSpaces.spaces_height_20,
          AppSpaces.spaces_height_20,
          AppSpaces.spaces_height_20,
          _sign_up_button(),
          AppSpaces.spaces_height_10,
        ],
      ),
    );
  }

  Row _name() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextFieldWidget(
            hint: "Name",
            focusNode: SignUpController.to.focusNode,
            padding: 0,
            controller: _signupController.nameController),
      ],
    );
  }

  _user_name() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextFieldWidget(
            hint: "User Name",
            focusNode: SignUpController.to.focusNode,
            padding: 0,
            controller: _signupController.usernameController),
      ],
    );
  }

  Row _phone_number() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextFieldWidget(
            hint: "Phone Number",
            focusNode: SignUpController.to.focusNode,
            // focusEnable: false,
            padding: 0,
            controller: _signupController.phoneController),
      ],
    );
  }

  _location() {
    return InkWell(
      onTap: () async {
        /* var picked_location =
                    await Get.toNamed(AppRoutes.PICK_USER_LOCATION);
                print("Picked Location : ${picked_location}");*/

        /*var result = await showLocationPicker(
                  context,
                  MapData.googleMapToken,
                  myLocationButtonEnabled: true,
                  layersButtonEnabled: true,
                  desiredAccuracy: LocationAccuracy.bestForNavigation,
                  language: 'en',
                  requiredGPS: true,
                  appBarColor: AppColors.white,
                );

                print(result);

                print("Location picked :: ${result.address}");
                print("Location picked latlang:: ${result.latLng}");
                print("Location picked place id:: ${result.placeId}");

                SignUpController.to.addressController.text = result.address;
                // SignUpController.to. = result.latLng;
                PickCurrentLocationController.to.latlng.value = result.latLng;*/
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextFieldWidget(
              hint: "Location",
              //focusEnable: false,
              padding: 0,
              controller: SignUpController.to.addressController),
        ],
      ),
    );
  }

  Row _insert_email() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextFieldWidget(
            hint: "Email",
            focusNode: SignUpController.to.focusNode,
            padding: 0,
            controller: _signupController.emailController),
      ],
    );
  }

  Row _password() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextFieldWidget(
            hint: "Password",
            focusNode: SignUpController.to.focusNode,
            obscureText: true,
            padding: 0,
            controller: _signupController.passwordController),
      ],
    );
  }

  _c_password() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextFieldWidget(
            hint: "Confirm Password",
            focusNode: SignUpController.to.focusNode,
            obscureText: true,
            padding: 0,
            controller: _signupController.confirmPasswordController),
      ],
    );
  }

  Container trms_and_condition(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: () {
        showTermsndCondition(context);
      },
      child: Column(
        children: [
          AppSpaces.spaces_width_10,
          Container(
            height: 10,
            child: Row(children: <Widget>[
              Checkbox(
                checkColor: AppColors.primaryColor,
                value: SignUpController.to.isCheckedAcceptTrams,
                onChanged: (bool? value) {
                  setState(() {
                    SignUpController.to.isCheckedAcceptTrams = true;
                  });
                },
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                'I accept the terms & condition',
                style: TextStyle(fontSize: 10.0),
              ),
            ]),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 10,
            child: Row(children: <Widget>[
              Checkbox(
                checkColor: AppColors.primaryColor,
                value: SignUpController.to.isSendNotification,
                onChanged: (bool? value) {
                  setState(() {
                    SignUpController.to.isSendNotification = value!;
                  });
                },
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                'Send notification when new items are available',
                style: TextStyle(fontSize: 10.0),
              ),
            ]),
          )
        ],
      ),
    ));
  }

  Widget _sign_up_button() {
    return AppButtonWidget(
      leadingCenter: true,
      onTab: () async {
        SignUpController.to.focusNode.unfocus();

        if (await _signupController.SignUp()) {
          if (arg == AppRoutes.CHECK_OUT) {
            Get.back(result: true);
          } else {
            Get.offAllNamed(AppRoutes.DISPLAY);
          }
        }
        // _signupController.setLoading(isLoading: false);
      },
      title: 'Sign Up',
    );
  }

  _loading() {
    return Obx(() {
      print(
          "SignUpController.to.isLoading.value :: ${SignUpController.to.isLoading.value}");
      return Positioned.fill(
          child: Align(
        alignment: Alignment.center,
        child: SignUpController.to.isLoading.value ? AppLoading() : Container(),
      ));
    });
  }

  void showTermsndCondition(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Get.toNamed(AppRoutes.LOG_IN);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Accept"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Terms & Condition"),
      content: Text("Terms & Condition goes here!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
