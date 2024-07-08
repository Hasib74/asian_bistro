import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/utils/colors/app_colors.dart';
import 'Controller/PickCurrentLocationController.dart';

/*PickCurrentLocationController _pickCurrentLocationController = Get.find();*/

class PickCurrentLocationScreen extends StatefulWidget {
  @override
  State<PickCurrentLocationScreen> createState() =>
      _PickCurrentLocationScreenState();
}

class _PickCurrentLocationScreenState extends State<PickCurrentLocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PickCurrentLocationController.to.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Location"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            //Obx(() => Text("${PickCurrentLocationController.to.latlng.value}")),
            Expanded(
              child: Obx(() => Stack(
                    children: [
                      GoogleMap(

                          // all the other arguments
                          initialCameraPosition: CameraPosition(
                            zoom: 16.0,
                            target:
                                PickCurrentLocationController.to.latlng.value,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId("userPositionId"),
                              position:
                                  PickCurrentLocationController.to.latlng.value,
                              icon: BitmapDescriptor.defaultMarker,
                            )
                          },
                          myLocationButtonEnabled: false,
                          myLocationEnabled: true,
                          onMapCreated: (GoogleMapController controller) {


                            PickCurrentLocationController
                                .to.pickLocationGoogleMapcontroller
                                .complete(controller);
                          },
                          onTap: (latLng) {
                            print('${latLng.latitude}, ${latLng.longitude}');

                            PickCurrentLocationController.to.latlng.value =
                                LatLng(latLng.latitude, latLng.longitude);
                            /*Get.back(result: LatLng(latLng.latitude, latLng.longitude));*/
                          }),
                      _next_button(),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _next_button() {
    return Positioned(
      bottom: 60,
      right: 16,
      left: 16,
      child: InkWell(
        onTap: () =>
            Get.back(result: PickCurrentLocationController.to.latlng.value),
        child: Container(
          width: 60,
          height: 52,
          decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text("Save Location",
                style: Get.textTheme.titleLarge?.copyWith(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
