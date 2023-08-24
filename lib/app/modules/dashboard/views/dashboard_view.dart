import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/modules/home/views/home_view.dart';
import 'package:aplikasi_pemesanan_travel/app/modules/order/views/order_view.dart';
import 'package:aplikasi_pemesanan_travel/app/modules/profile/views/profile_view.dart';
import 'package:aplikasi_pemesanan_travel/app/modules/tracking/views/tracking_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => GetBuilder<DashboardController>(
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: SafeArea(
                child: IndexedStack(
                  index: controller.currentIndex,
                  children: [
                    HomeView(),
                    const TrackingView(),
                    const OrderView(),
                    const ProfileView(),
                  ],
                ),
              ),
              bottomNavigationBar: Material(
                elevation: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    bottomNavigationItemBar(
                        BoxIcons.bx_home_circle, BoxIcons.bxs_home_circle, 0),
                    bottomNavigationItemBar(
                        BoxIcons.bx_map_pin, BoxIcons.bxs_map_pin, 1),
                    bottomNavigationItemBar(
                        BoxIcons.bx_list_ul, BoxIcons.bx_list_ul, 2),
                    bottomNavigationItemBar(
                        BoxIcons.bx_user_circle, BoxIcons.bxs_user_circle, 3),
                  ],
                ),
              ),
            ),
          );
        },
      );

  Widget bottomNavigationItemBar(
          IconData icon, IconData iconActive, int index) =>
      GetBuilder<DashboardController>(
        builder: (controller) {
          return GestureDetector(
            onTap: () => controller.selectIndex(index),
            child: Container(
              height: Get.height * 0.1,
              width: Get.width / 4,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    (controller.currentIndex == index) ? iconActive : icon,
                    color: (controller.currentIndex == index)
                        ? primaryColor
                        : Colors.grey.withOpacity(0.5),
                  ),
                  (controller.currentIndex == index)
                      ? Container(
                          margin: const EdgeInsets.only(top: 3),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
        },
      );
}
