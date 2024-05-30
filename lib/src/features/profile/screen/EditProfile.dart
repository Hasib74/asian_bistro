import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/common_widgets/app_button.dart';
import '../../../core/common_widgets/app_image_picker.dart';
import '../../../core/common_widgets/app_image_view_widgets.dart';
import '../../../core/common_widgets/app_loading.dart';
import '../../../core/common_widgets/app_text_fields.dart';
import '../../../core/remote/urls/app_urls.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/utils/spaces/AppSpaces.dart';
import 'EditProfileController/ProfileController.dart';

class EditProfile extends StatelessWidget {
  //getx  VendorSignUp controller initial setup

  //Pages variables
  bool valuefirst = false;
  bool valuesecond = false;
  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    this.context = context;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Profile",
            style: Get.textTheme.titleLarge,
          )),
      body: SafeArea(
        child: Obx(() {
          print("User Value => ${ProfileController.to.user.value}");
          print("User Loading => ${ProfileController.to.loading}");

          if (ProfileController.to.user.value.fullName == null) {
            return Center(
              child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.LOG_IN);
                  },
                  child: Text("Please sign in")),
            );
          }

          return Container(
            child: AbsorbPointer(
              absorbing: ProfileController.to.user.value.fullName == null,
              child: Obx(() => Stack(
                children: [
                  SingleChildScrollView(
                    child: _body(),
                  ),
                  ProfileController.to.user.value.fullName == null ||
                      ProfileController.to.loading?.value == true
                      ? _loading()
                      : Container(),
                ],
              )),
            ),
          );
        }),
      ),
    );
  }

  _body() {
    return Column(
      children: [
        AppSpaces.spaces_height_25,
        _image_pick_and_view(context!),
        AppSpaces.spaces_height_25,
        _user_name(),
        AppSpaces.spaces_height_10,

        _location(),
        AppSpaces.spaces_height_10,

        _phoneNumber(),
        //  _billing_information(),
        AppSpaces.spaces_height_10,
        _insert_email(),
        AppSpaces.spaces_height_10,

        // _countryId(),
        AppSpaces.spaces_height_10,

        //_description(),
        // AppSpaces.spaces_height_10,

        //_cardNumber(),
        // AppSpaces.spaces_height_10,

        //  AppSpaces.spaces_height_10,

        AppSpaces.spaces_height_25,

        _update_button(),
      ],
    );
  }

  Row _insert_email() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            horizontal_padding: 0,
            width: 110,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            leadingCenter: false,
            // icon: Icons.email,
            title: "Email",
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                controller: ProfileController.to.emailController,
                padding: 0,
                padding_right: 16,
                textInputType: TextInputType.emailAddress)),
      ],
    );
  }

  Row _location() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        InkWell(
          onTap: () {
            /* var result = Get.toNamed(AppRoutes.PICK_USER_LOCATION);

            result.then((value) async {
              var address = await MapData.mapFunction.latLagToString(value);

              ProfileController.to.addressController.text = address;
            });*/
          },
          child: AppButtonWidget(
              horizontal_padding: 0,
              width: 110,
              height: 45,
              textStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              // icon: Icons.location_on,
              title: "Address",
              leadingCenter: false,
              iconColor: Colors.white),
        ),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
               // focusEnable: false,
                controller: ProfileController.to.addressController,
                padding: 0,
                padding_right: 16,
                textInputType: TextInputType.text)),
      ],
    );
  }

  _user_name() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            leadingCenter: false,
            horizontal_padding: 0,
            width: 110,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //  icon: Icons.perm_identity,

            title: "User Name",
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                controller: ProfileController.to.userNameController,
                padding: 0,
                padding_right: 16,
                textInputType: TextInputType.text)),
      ],
    );
  }

  Widget _image_pick_and_view(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: Stack(
        children: [
          GetBuilder<ProfileController>(
            builder: (_) {
              return InkWell(
                onTap: () async {
                  /*XFile? pickedFile =
                      await ImagePicker().pickImage(source: ImageSource.gallery);*/

                  XFile _xFile = await showProductImageSelectDialog(context);
                  print("XFile.................  ${_xFile.path}");

                  _.setFile(File(_xFile.path));
                },
                child: ImageViewWidget(
                  file: _.file,
                  borderEnable: true,
                  imageSize: 150,
                  imageType: ImageType.RING,
                  imageUrl: ProfileController.to.user.value.photo != null
                      ? ApiUrls.download_base_url +
                      ProfileController.to.user.value.photo
                      : "",
                ),
              );
            },
          ),
          Positioned(
            right: 10,
            bottom: 15.0,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  shape: BoxShape.circle),
              child: Icon(
                Icons.camera_alt,
                size: 10,
              ),
            ),
          )
        ],
      ),
    );
  }

  _update_button() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppButtonWidget(
        // horizontal_padding: 0,

          onTab: () async {
            ProfileController.to.loading?.value = true;

            print("Truuuuuuuuuuuuuuuuuuuue");

            await ProfileController.to.userUpdateProfile();

            //   await VendorHomePageController.to.getVendorProfile();

            ProfileController.to.loading?.value = false;
          },
          textStyle: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          height: 45,
          // icon: Icons.lock,
          leadingCenter: true,
          title: "Update",
          iconColor: Colors.white),
    );
  }

  _loading() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: AppLoading(),
      ),
    );
  }

  _phoneNumber() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            leadingCenter: false,
            horizontal_padding: 0,
            width: 110,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //  icon: Icons.perm_identity,

            title: "Phone Number",
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                controller: ProfileController.to.phoneNumberController,
                padding: 0,
                padding_right: 16,
                textInputType: TextInputType.number)),
      ],
    );
  }

  _countryId() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            leadingCenter: false,
            horizontal_padding: 0,
            width: 110,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //  icon: Icons.perm_identity,

            title: "Country Id",
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
              controller: ProfileController.to.countryIdController,
              padding: 0,
              padding_right: 16,
            )),
      ],
    );
  }

  _description() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            leadingCenter: false,
            horizontal_padding: 0,
            width: 110,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //  icon: Icons.perm_identity,

            title: "Description",
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
              controller: ProfileController.to.descriptionController,
              padding: 0,
              padding_right: 16,
            )),
      ],
    );
  }

  _cardNumber() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            leadingCenter: false,
            horizontal_padding: 0,
            width: 110,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //  icon: Icons.perm_identity,

            title: "Card Number",
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            flex: 2,
            child: AppTextFieldWidget(
              controller: ProfileController.to.cardNumberController,
              padding: 0,
              padding_right: 16,
            )),
        Expanded(
            flex: 1,
            child: AppTextFieldWidget(
              hint: "CVC",
              controller: ProfileController.to.cvcController,
              padding: 0,
              padding_right: 16,
            )),
      ],
    );
  }
}
