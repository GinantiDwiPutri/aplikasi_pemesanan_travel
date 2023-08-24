import 'dart:io';

import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/theme/text_theme.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/disabled_button.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/loading_button.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/primary_button.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/required_label_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profil',
            style: TextStyle(
              fontFamily: fontFamily,
              color: blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: blackColor,
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              BoxIcons.bx_arrow_back,
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
                  child: Row(
                    children: [
                      Obx(
                        () => ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: (controller.imageCropping.value.path == '-')
                              ? (user.value.photoURL == "")
                                  ? Image.asset(
                                      "assets/images/man.png",
                                      width: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      user.value.photoURL!,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    )
                              : Image.file(
                                  File(controller.imageCropping.value.path),
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        onPressed: () => Get.bottomSheet(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: Get.height * 0.15,
                            decoration: const BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      controller.pickImageFromGallery(),
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    direction: Axis.vertical,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: secondaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          BoxIcons.bx_image,
                                          color: primaryColor,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Galeri",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                GestureDetector(
                                  onTap: () => controller.pickImageFromCamera(),
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    direction: Axis.vertical,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: secondaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          BoxIcons.bx_camera,
                                          color: primaryColor,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Kamera",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                GestureDetector(
                                  onTap: () => controller.deletePhoto(),
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    direction: Axis.vertical,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: secondaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          BoxIcons.bx_trash,
                                          color: primaryColor,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Hapus",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: const Text("Ganti Foto"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RequiredLabelText(label: 'Nama Lengkap'),
                      TextField(
                        controller: controller.nameController,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          controller.name.value = value;
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RequiredLabelText(label: 'Email'),
                      TextField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          controller.email.value = value;
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            Obx(
              () => Positioned(
                bottom: 10,
                child: (controller.isLoading.isFalse)
                    ? saveButton()
                    : const LoadingButton(text: "Simpan"),
              ),
            ),
          ],
        ),
      );

  Widget saveButton() {
    return Obx(() {
      if (controller.name.value != user.value.displayName ||
          controller.email.value != user.value.email ||
          controller.imageCropping.value.path != '-') {
        return PrimaryButton(
          onTap: () => controller.editProfile(),
          text: "Simpan",
        );
      } else {
        return const DisabledButton(text: "Simpan");
      }
    });
  }
}
