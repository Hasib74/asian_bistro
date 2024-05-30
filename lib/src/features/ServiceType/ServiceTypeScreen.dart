import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/assets.dart';
import '../../core/common_widgets/any_image_view.dart';
import '../../core/global/global_context.dart';
import '../../core/routing/app_routes.dart';
import '../../core/utils/colors/app_colors.dart';
import '../../core/utils/spaces/AppSpaces.dart';
import '../Authentication/SignUp/Controller/SignUpController.dart';
import 'Controller/ServiceTypeController.dart';

class ServiceTypeScreen extends StatefulWidget {
  @override
  _ServiceTypeScreenState createState() => _ServiceTypeScreenState();
}

class _ServiceTypeScreenState extends State<ServiceTypeScreen> {
  //ServiceTypeController? _serviceTypeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  Get.put(ServiceTypeController());
    //  _serviceTypeController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AppSpaces.spaces_height_40,
          _lunchLogo(),
          AppSpaces.spaces_height_20,
          Text(
            "User",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          AppSpaces.spaces_height_20,
          _title(),
          AppSpaces.spaces_height_25,
          AppSpaces.spaces_height_25,
          _appServiceTypes(),
          AppSpaces.spaces_height_25,
          AppSpaces.spaces_height_25,
        ],
      )),
    );
  }

  Widget _lunchLogo() {
    return Container(
        // height: 150,
        // width: 150,
        // decoration: BoxDecoration(
        //   shape: BoxShape.circle,
        //   color: Colors.white,
        // ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnyImageView(
              height: 120,
              width: 120,
              imagePath: Assets.imagesLogo,
              shape: BoxShape.circle,
              //  color: Colors.white,
            )));
  }

  Text _title() {
    return Text(
      "Please choose which service do you need.",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 18,
      ),
    );
  }

  Widget _appServiceTypes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
            onTap: () async {
              // goToNextScreen();

              /*    SharedPreferences sp = await SharedPreferences.getInstance();

              sp.setString("service_type", "grocery");

              GlobalVariable().setBaseUrl();*/

              Get.toNamed(AppRoutes.DISPLAY);
              // Get.to(() => WriteAddressScreen());
            },
            child: RingButtonWidget(
                title: 'Catering', iconAsset: Assets.imagesCateringIcon)),

        InkWell(
          onTap: () async {
            Get.toNamed(AppRoutes.DISPLAY);

            //    Get.to(() => WriteConfirmAddressScreen());
          },
          child: RingButtonWidget(
            title: 'Order Food',
            iconAsset: Assets.imagesOrderFoodIcon,
          ),
        ),

        //   RingButtonWidget(title: 'Grocery', iconAsset: AppAssets.groceryIcon),
      ],
    );
  }

/*
  goToNextScreen() async {
    // AppConstantData.selectServiceName = await LocalDataSourceController.to.sp.get(LocalKey.user_selected_service_name);

    //_loadController();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    new Future.delayed(const Duration(seconds: 2), () async {
      try {
        Token token = await SignUpController.to.getToken();

        print("Toeknnnnnnnnnnnnnnnn => ${token == null}");
        if (token == null) {
          // Get.toNamed(AppRoutes.SERVICE_TYPE_OPTION);
          Future.delayed(Duration.zero)
              .then((value) => Get.offAllNamed(AppRoutes.LOG_IN));
        } else {
        //  AuthController.to.token = token.token;

          Get.offAllNamed(AppRoutes.DISPLAY);
        }
      } on Exception catch (e) {
        // TODO

        print("SplashScreen Error ::: => ${e.toString()}");
      }
    });
  }
*/

  Widget RingButtonWidget(
          {String? title, String? iconAsset, double buttonSize = 110}) =>
      InkWell(
        child: Container(
          margin: EdgeInsets.all(8),
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconAsset!,
                width: 50,
                height: 50,
                alignment: Alignment.center,
                color: AppColors.redColor,
              ),
              Text(
                '${title}',
                style: TextStyle(color: AppColors.redColor, fontSize: 15),
              ),
            ],
          ),
        ),
        /* onTap: () {
        //  Get.toNamed(AppRoutes.DISPLAY);
        },*/
      );
}
