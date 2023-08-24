import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/user_model.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  void checkUserRegistered(String? phoneNumber) async {
    try {
      final checkUser = await users.doc(phoneNumber).get();

      if (checkUser.data() == null) {
        Get.back();
        Get.toNamed(Routes.REGISTER);
      } else {
        await users.doc(phoneNumber).update({
          "lastSignInTime": DateTime.now().toIso8601String(),
        });

        getDataUser();

        Get.back();
        Get.offAllNamed(Routes.SPLASH);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void getDataUser() async {
    try {
      final getUser = await users.doc(auth.currentUser?.phoneNumber).get();
      final userData = getUser.data() as Map<String, dynamic>;

      user(UserModel.fromJson(userData));
      user.refresh();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onInit() {
    users.doc(user.value.phoneNumber).snapshots().listen((event) {});
    super.onInit();
  }
}
