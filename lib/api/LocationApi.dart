import 'package:location/location.dart';
import 'package:flutter/services.dart';

class LocationApi {
  Location _location = Location();
  String error;

  static LocationApi _instance; // singleton
  static LocationApi getInstance() => _instance ??= LocationApi();

  Future<LocationData> getLocation() async {

    LocationData location;

    try {
      location = await _location.getLocation();
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }
      location = null;
    }

    return location;
  }
}
