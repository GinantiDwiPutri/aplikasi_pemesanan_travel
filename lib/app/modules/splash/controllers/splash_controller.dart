import 'package:aplikasi_pemesanan_travel/app/controllers/location_controller.dart';
import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/user_model.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  void checkLoggedInUser() {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      try {
        if (auth.currentUser != null) {
          final getUser = await users.doc(auth.currentUser!.phoneNumber).get();
          final userData = getUser.data() as Map<String, dynamic>;

          user(UserModel.fromJson(userData));
          user.refresh();

          if (userData['status'] == "blocked") {
            Get.offNamed(Routes.BLOCKED);
          } else {
            Get.offNamed(Routes.DASHBOARD);
          }
        } else {
          Get.offNamed(Routes.WELCOME);
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());

        auth.signOut();

        Get.offNamed(Routes.WELCOME);
      }
    });
  }

  @override
  void onInit() {
    Get.find<LocationController>().checkLocationPermission();
    super.onInit();
  }

  @override
  void onReady() {
    checkLoggedInUser();
    super.onReady();
  }
}
