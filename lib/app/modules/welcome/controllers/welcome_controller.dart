import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  PageController pageController = PageController();
  var currentPage = 0.obs;

  Rx<bool> isDarkMode = false.obs;

  final welcomeLight = [
    {
      'images': 'light-one.jpg',
      'title': 'Selamat Datang di \nBerangkut',
      'caption':
          'Kami akan membantu semua kebutuhanmu di mana pun dan kapan pun',
    },
    {
      'images': 'light-two.jpg',
      'title': 'Jagonya Transportasi \ndan Logistik',
      'caption': 'Kami anterin kamu atau paketmu kemana pun gampang banget',
    },
    {
      'images': 'light-three.jpg',
      'title': 'Perjalanan Jauh Pun Tidak Masalah',
      'caption': 'Layanan kami tersebar hingga di pelosok Kabupaten Ketapang',
    },
  ];

  final welcomeDark = [
    {
      'images': 'dark-one.png',
      'title': 'Selamat Datang di \nBerangkut',
      'caption':
          'Kami akan membantu semua kebutuhanmu di mana pun dan kapan pun',
    },
    {
      'images': 'dark-two.png',
      'title': 'Jagonya Transportasi \ndan Logistik',
      'caption': 'Kami anterin kamu atau paketmu kemana pun gampang banget',
    },
    {
      'images': 'dark-three.png',
      'title': 'Perjalanan Jauh Pun Tidak Masalah',
      'caption': 'Layanan kami tersebar hingga di pelosok Kabupaten Ketapang',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    getStorage.listenKey('isDarkMode', (value) {
      isDarkMode.value = value;
    });
  }

  @override
  void onClose() {
    super.onClose();
    isDarkMode.close();
    currentPage.close();
    pageController.dispose();
  }
}
