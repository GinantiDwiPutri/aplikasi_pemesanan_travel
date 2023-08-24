import 'package:aplikasi_pemesanan_travel/app/controllers/user_controller.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  int currentIndex = 0;

  void selectIndex(int index) {
    currentIndex = index;
    update();

    Get.find<UserController>().getDataUser();
  }

  @override
  void onInit() {
    Get.find<UserController>().getDataUser();
    super.onInit();
  }
}
