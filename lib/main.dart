import 'package:aplikasi_pemesanan_travel/app/controllers/location_controller.dart';
import 'package:aplikasi_pemesanan_travel/app/controllers/user_controller.dart';
import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();
  await GetStorage.init();

  Get.put(UserController(), permanent: true);
  Get.put(LocationController(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeData = getStorage.writeIfNull('isDarkMode', false);

  @override
  Widget build(BuildContext context) {
    return SimpleBuilder(
      builder: (context) {
        bool isDarkMode = getStorage.read('isDarkMode');

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDarkMode ? themeDataDark : themeDataLight,
          title: "Berangkut",
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
