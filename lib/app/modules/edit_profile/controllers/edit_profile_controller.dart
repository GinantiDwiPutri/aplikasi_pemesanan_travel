import 'dart:io';

import 'package:aplikasi_pemesanan_travel/app/controllers/user_controller.dart';
import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  TextEditingController nameController =
      TextEditingController(text: user.value.displayName);
  TextEditingController emailController =
      TextEditingController(text: user.value.email);

  Rx<String> name = '${user.value.displayName}'.obs;
  Rx<String> email = '${user.value.email}'.obs;

  final ImagePicker picker = ImagePicker();
  final ImageCropper cropper = ImageCropper();

  String url = '';
  XFile? image;
  Rx<File> imageCropping = File("-").obs;

  Rx<bool> isLoading = false.obs;

  void pickImageFromGallery() async {
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        CroppedFile? croppedImage = await cropper.cropImage(
          sourcePath: image!.path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
        );

        imageCropping.value = File(croppedImage!.path);

        Get.back();
      }
    } catch (e) {
      Get.snackbar("Error", "message");
      print('! Error Pick Image From Gallery ===== $e');
    }
  }

  void pickImageFromCamera() async {
    try {
      image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        CroppedFile? croppedImage = await cropper.cropImage(
          sourcePath: image!.path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
        );

        imageCropping.value = File(croppedImage!.path);

        Get.back();
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
      print('! Error Pick Image From Camera ===== $e');
    }
  }

  void deletePhoto() async {
    try {
      await users.doc(user.value.phoneNumber).update({
        'photoURL': '',
      });

      Get.find<UserController>().getDataUser();

      imageCropping.value = File("-");

      Get.back();
    } catch (e) {
      Get.snackbar("Error", "$e");
      print('! Error Delete Photo ===== $e');
    }
  }

  void editProfile() async {
    try {
      isLoading.value = true;

      if (imageCropping.value.path != '-') {
        String extension = image!.name.split('.').last;

        await storage
            .ref('users/${user.value.uid}.$extension')
            .putFile(imageCropping.value);
        url = await storage
            .ref('users/${user.value.uid}.$extension')
            .getDownloadURL();
      }

      await users.doc(user.value.phoneNumber).update({
        'displayName': nameController.text,
        'email': emailController.text,
        'photoURL': url,
        'updatedTime': DateTime.now().toIso8601String(),
      });

      await users.doc(user.value.phoneNumber).collection('notifications').add({
        'title': 'Edit Profil Berhasil',
        'description': 'Mengubah data tidak dapat dilakukan terlalu sering.',
        'isRead': false,
        'time': DateTime.now().toIso8601String(),
      });

      Get.find<UserController>().getDataUser();

      Get.offNamed(Routes.DASHBOARD);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "$e");
      print('! Error Edit Profile ===== $e');
    }
  }
}
