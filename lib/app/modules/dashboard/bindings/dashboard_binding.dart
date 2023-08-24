import 'package:aplikasi_pemesanan_travel/app/modules/home/controllers/home_controller.dart';
import 'package:aplikasi_pemesanan_travel/app/modules/order/controllers/order_controller.dart';
import 'package:aplikasi_pemesanan_travel/app/modules/profile/controllers/profile_controller.dart';
import 'package:aplikasi_pemesanan_travel/app/modules/tracking/controllers/tracking_controller.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.put<HomeController>(
      HomeController(),
    );
    Get.lazyPut<TrackingController>(
      () => TrackingController(),
    );
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
