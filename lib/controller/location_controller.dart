import 'package:app_ifix/constants/controllers.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeoLocationController extends GetxController {
  static GeoLocationController instance = Get.find();
  Position? currentPosition;
  Position? lastKnowPosition;
  RxString currentAddress = 'Việt Nam'.obs;

  void determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
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
        print('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    storeController.sortByDistance(currentPosition!);
    storeController.check.value = true;
    getAddressFromLatLng();
  }

  void getLastKnownPosition() async {
    lastKnowPosition = await Geolocator.getLastKnownPosition();
  }

  double getDistance(double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(currentPosition!.latitude,
        currentPosition!.longitude, endLatitude, endLongitude);
  }

  void getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);
      Placemark place = placemarks[0];

      currentAddress.value =
          " ${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }
}
