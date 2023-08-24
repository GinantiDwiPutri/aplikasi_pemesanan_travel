import 'package:aplikasi_pemesanan_travel/app/controllers/user_controller.dart';
import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/progress_dialog.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class LoginController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  Rx<String> phoneNumber = ''.obs;
  Rx<String> otp = ''.obs;
  Rx<bool> isLoading = false.obs;

  void verifyPhoneNumber() {
    isLoading.value = true;

    // Get.toNamed(Routes.DASHBOARD);

    try {
      auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 59),
        phoneNumber: "+62$phoneNumber",
        verificationCompleted: (phoneAuthCredential) {
          // Get.snackbar('Berhasil', "$phoneAuthCredential");
        },
        verificationFailed: (firebaseAuthException) {
          isLoading.value = false;
          // Get.snackbar("Error", "$firebaseAuthException");
        },
        codeSent: (verificationId, resendToken) {
          // Get.snackbar("OTP Terkirim", "$verificationId dan $resendToken");
          Get.bottomSheet(
            Container(
              height: Get.height * 0.4,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SMS OTP sudah dikirim",
                    style: Get.textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Masukkan kode OTP yang telah kami kirimkan ke nomor HP-mu, +62$phoneNumber",
                    style: Get.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Pinput(
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsRetrieverApi,
                    length: 6,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    ],
                    onChanged: (value) {
                      otp.value = value;
                    },
                    onCompleted: (value) {
                      sendOTP(verificationId, otp.value);
                    },
                  ),
                ],
              ),
            ),
            isDismissible: false,
          );
          isLoading.value = false;
        },
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {},
      );
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      // Get.snackbar("Error", e.toString());
    }
  }

  sendOTP(String verificationId, String otp) async {
    Get.dialog(
      const ProgressDialog(
        message: "Mohon Tunggu",
      ),
    );

    try {
      var credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await auth.signInWithCredential(credential);
      // Get.snackbar("Login Berhasil", "message");
      Get.find<UserController>()
          .checkUserRegistered(auth.currentUser?.phoneNumber);
    } catch (e) {
      Get.back();
      // Get.snackbar("Login Gagal", "message");
    }
  }

  void deletePhoneNumber() {
    phoneNumber.value = "";
    phoneNumberController.clear();
  }
}
