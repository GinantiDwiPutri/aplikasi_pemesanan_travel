import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<bool> isDarkMode = false.obs;

  void onThemeChanged(value) {
    getStorage.write('isDarkMode', value);
  }

  @override
  void onInit() {
    super.onInit();
    getStorage.listenKey('isDarkMode', (value) {
      isDarkMode.value = value;
    });
  }
}
