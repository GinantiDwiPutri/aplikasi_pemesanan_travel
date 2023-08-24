import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/user_model.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/progress_dialog.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  Rx<String> name = ''.obs;
  Rx<String> email = ''.obs;

  void register() async {
    Get.dialog(
      const ProgressDialog(message: "Mohon Tunggu"),
    );

    try {
      await users.doc(auth.currentUser?.phoneNumber).set({
        'uid': auth.currentUser?.uid,
        'phoneNumber': auth.currentUser?.phoneNumber,
        'displayName': name.value,
        'email': email.value,
        'emailVerifiedAt': '',
        'photoURL': '',
        'updatedTime': '',
        'status': 'active',
        'creationTime': DateTime.now().toIso8601String(),
        'lastSignInTime': DateTime.now().toIso8601String(),
      });

      await users
          .doc(auth.currentUser?.phoneNumber)
          .collection('notifications')
          .add({
        'title': 'Selamat Datang!',
        'description':
            'Dapatkan pelayanan dan penawaran terbaik kami di Berangkut!',
        'isRead': false,
        'time': DateTime.now().toIso8601String(),
      });

      final getUser = await users.doc(auth.currentUser?.phoneNumber).get();
      final userData = getUser.data() as Map<String, dynamic>;

      user(UserModel.fromJson(userData));
      user.refresh();

      Get.offAllNamed(Routes.DASHBOARD);
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "message");
    }
  }
}
