import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';

import '../../../core/Map/MapFunction.dart';

class PickCurrentLocationController extends GetxController {
  RxBool loading = false.obs;

  Rx<LatLng?> latlng = LatLng(0.0, 0.0).obs;

  static PickCurrentLocationController to =
      Get.find<PickCurrentLocationController>();

  Completer<GoogleMapController> pickLocationGoogleMapcontroller = Completer();

  RxString? addressName = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getCurrentLocation();
  }

  Future getCurrentLocation() async {
    loading = true.obs;

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    Position _currentPosition = await Geolocator.getCurrentPosition();

    latlng.value =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);

    printInfo(info: "Current Location :: ${latlng.value}");

    update();

    getLocationWithStringName();
  }

  Future<String?> getLocationWithStringName() async {
    String? address = await MapFunction().latLagToString(latlng.value ?? LatLng(0, 0));

    addressName?.value = address ?? "";

    update();

    return address;
  }
}
