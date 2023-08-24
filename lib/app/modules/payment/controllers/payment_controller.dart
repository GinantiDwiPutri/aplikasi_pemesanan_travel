import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/trip_model.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentController extends GetxController {
  Rx<double> progressIndicator = 0.0.obs;
  Rx<bool> isLoading = true.obs;

  WebViewController webviewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
      Uri.parse(
          'https://berangkut.fun/api/payment?price=${Get.arguments["price"]}&route=${Get.arguments["route"]}&date=${Get.arguments["date"]}&seat=${Get.arguments["seat"]}&clientPhoneNumber=${Get.arguments["clientPhoneNumber"]}&driverPhoneNumber=${Get.arguments["driverPhoneNumber"]}&displayName=${Get.arguments["displayName"]}&email=${Get.arguments["email"]}&tripID=${Get.arguments["tripID"]}'),
    );

  Stream<TripModel> streamTripStatus() {
    return trips
        .doc(Get.arguments['tripID'])
        .snapshots()
        .map((snapshot) => TripModel.fromJson(snapshot));
  }

  @override
  void onInit() {
    super.onInit();
    webviewController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (progress) {
          progressIndicator.value = progress / 100;
        },
        onPageStarted: (url) {
          isLoading.value = true;
        },
        onPageFinished: (url) {
          isLoading.value = false;
        },
        onWebResourceError: (error) {},
      ),
    );
  }

  @override
  void onClose() {
    super.onClose();
    webviewController.clearCache();
    webviewController.clearLocalStorage();
  }
}
