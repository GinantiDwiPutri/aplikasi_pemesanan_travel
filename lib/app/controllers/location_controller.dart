import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/direction_model.dart';
import 'package:aplikasi_pemesanan_travel/app/models/polyline_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  var position = DirectionModel().obs;
  var destination = DirectionModel().obs;
  var polyline = PolylineModel().obs;

  LocationPermission? locationPermission;

  checkLocationPermission() async {
    locationPermission = await Geolocator.checkPermission();

    switch (locationPermission) {
      case LocationPermission.denied:
        locationPermission = await Geolocator.requestPermission();
        break;
      case LocationPermission.deniedForever:
        locationPermission = await Geolocator.requestPermission();
        break;
      case LocationPermission.whileInUse:
        locatePosition();
        break;
      case LocationPermission.always:
        locatePosition();
        break;
      case LocationPermission.unableToDetermine:
        locationPermission = await Geolocator.requestPermission();
        break;

      default:
    }
  }

  locatePosition() async {
    try {
      Position geo = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      DirectionModel directions = DirectionModel();

      directions.locationLatitude = geo.latitude;
      directions.locationLongitude = geo.longitude;
      directions.locationName =
          await getAddress(LatLng(geo.latitude, geo.longitude));

      position(directions);
      position.refresh();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<String> getAddress(LatLng position) async {
    try {
      String url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleMapKey";

      // ignore: prefer_typing_uninitialized_variables
      var result, httpResponse = await GetConnect().get(url);
      switch (httpResponse.statusCode) {
        case 200:
          var responseData = httpResponse.body;
          Map<String, dynamic> data = Map<String, dynamic>.from(responseData);
          result = data["results"][2]["formatted_address"];

          break;
        default:
          result = "Tidak Terdeteksi";
      }
      return result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return "Gagal Mendapatkan Lokasi";
    }
  }

  getPolylineDistanceAndDuration(LatLng origin, LatLng destination) async {
    try {
      String url =
          "https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$googleMapKey";

      var httpResponse = await GetConnect().get(url);
      PolylineModel result = PolylineModel();
      switch (httpResponse.statusCode) {
        case 200:
          var responseData = httpResponse.body;
          Map<String, dynamic> data = Map<String, dynamic>.from(responseData);

          result.distanceText =
              data["routes"][0]["legs"][0]["distance"]["text"];
          result.distanceValue =
              data["routes"][0]["legs"][0]["distance"]["value"];
          result.durationText =
              data["routes"][0]["legs"][0]["duration"]["text"];
          result.durationValue =
              data["routes"][0]["legs"][0]["duration"]["value"];
          result.points = data["routes"][0]["overview_polyline"]["points"];

          polyline(result);
          polyline.refresh();
          break;
      }
      return result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
