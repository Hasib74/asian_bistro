import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class UserLocation {
  loc.Location _location = new loc.Location();

  Future<loc.LocationData?> determinePosition() async {
    // location permission

    var status = await Permission.location.status;

    if (!status.isGranted) {
      await Permission.location.request();
    }

    if (status.isGranted) {
      return await _location.getLocation();
    }
  }

  Future<Placemark> getCurrentLocationAsString() async {
    loc.LocationData _location_data = await _location.getLocation();

    List<Placemark> placemarks = await placemarkFromCoordinates(
        _location_data.latitude!, _location_data.longitude!);

    var first = placemarks[0];

    return first;
  }
}
