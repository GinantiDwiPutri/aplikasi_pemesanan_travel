import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/disabled_button.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/loading_button.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/primary_button.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/required_label_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.HELP),
              icon: const Icon(
                BoxIcons.bx_help_circle,
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Masukkan Nomor HP",
                    style: Get.textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Kami perlu nomor handphonemu untuk masuk atau mendaftar dalam aplikasi",
                    style: Get.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RequiredLabelText(label: "Nomor Handphone"),
                      Row(
                        children: [
                          Text(
                            "+62",
                            style: Get.textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: controller.phoneNumberController,
                              onChanged: (value) {
                                controller.phoneNumber.value = value;
                              },
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]{0,13}')),
                              ],
                              cursorColor: primaryColor,
                              cursorWidth: 3,
                              decoration: InputDecoration(
                                hintText: "08xxxxxxx",
                                focusColor: blackColor,
                                fillColor: blackColor,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 3,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      controller.deletePhoneNumber(),
                                  icon: const Icon(BoxIcons.bx_x_circle),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Obx(
              () => Positioned(
                  bottom: 10,
                  child: Wrap(
                    direction: Axis.vertical,
                    runSpacing: 10,
                    children: [
                      RichText(
                        text: TextSpan(
                            text:
                                "Dengan masuk atau mendaftar, anda menyetujui\n",
                            style: Theme.of(context).textTheme.bodySmall,
                            children: [
                              TextSpan(
                                text: "Ketentuan Layanan",
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Get.toNamed(Routes.TERMS_OF_SERVICE),
                              ),
                              const TextSpan(text: "\tdan\t"),
                              TextSpan(
                                text: "Kebijakan Privasi",
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap =
                                      () => Get.toNamed(Routes.PRIVACY_POLICY),
                              ),
                            ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      (controller.phoneNumber.value.length >= 11)
                          ? (controller.isLoading.isTrue)
                              ? const LoadingButton(text: "Kirim OTP")
                              : PrimaryButton(
                                  onTap: () => controller.verifyPhoneNumber(),
                                  text: "Kirim OTP",
                                )
                          : const DisabledButton(text: "Kirim OTP"),
                    ],
                  )),
            ),
          ],
        ),
      );
}
