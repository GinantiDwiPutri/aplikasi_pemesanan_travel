import 'package:get/get.dart';
import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: PageView.builder(
          controller: controller.pageController,
          onPageChanged: controller.currentPage,
          scrollDirection: Axis.vertical,
          itemCount: controller.isDarkMode.isFalse
              ? controller.welcomeLight.length
              : controller.welcomeDark.length,
          itemBuilder: (context, index) => SafeArea(
            child: Obx(
              () => Container(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 20,
                  right: 20,
                ),
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: whiteColor,
                  image: DecorationImage(
                    image: AssetImage(controller.isDarkMode.isFalse
                        ? "assets/images/${controller.welcomeLight[index]['images']}"
                        : "assets/images/${controller.welcomeDark[index]['images']}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.isDarkMode.isFalse
                                    ? "${controller.welcomeLight[index]['title']}"
                                    : "${controller.welcomeDark[index]['title']}",
                                style: const TextStyle(
                                  fontFamily: "Rubik",
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${controller.welcomeLight[index]['caption']}",
                                style: const TextStyle(
                                  fontFamily: "Rubik",
                                  fontSize: 16,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => Column(
                            children: List.generate(
                              controller.welcomeLight.length,
                              (index) => GestureDetector(
                                onTap: () => controller.pageController
                                    .animateToPage(index,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut),
                                child: Container(
                                  width: 8,
                                  height: (controller.currentPage == index)
                                      ? 32
                                      : 8,
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (controller.currentPage == index)
                                        ? controller.isDarkMode.isTrue
                                            ? secondaryColor
                                            : primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Material(
                        color: controller.isDarkMode.isTrue
                            ? secondaryColor
                            : primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            (controller.currentPage ==
                                    controller.welcomeLight.length - 1)
                                ? Get.toNamed(Routes.LOGIN)
                                : controller.pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: (controller.currentPage ==
                                    controller.welcomeLight.length - 1)
                                ? const Text(
                                    "Masuk atau Mendaftar",
                                    style: TextStyle(
                                      fontFamily: "Rubik",
                                      color: whiteColor,
                                    ),
                                  )
                                : const Text(
                                    "Lanjut",
                                    style: TextStyle(
                                      fontFamily: "Rubik",
                                      color: whiteColor,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: SimpleBuilder(
      //   builder: (_) {
      //     return Obx(() {
      //       return FloatingActionButton(
      //         backgroundColor:
      //             controller.isDarkMode.isTrue ? secondaryColor : primaryColor,
      //         onPressed: () {
      //           if (controller.isDarkMode.isTrue) {
      //             getStorage.write('isDarkMode', false);
      //           } else {
      //             getStorage.write('isDarkMode', true);
      //           }
      //         },
      //         child: controller.isDarkMode.isTrue
      //             ? const Icon(
      //                 BoxIcons.bx_sun,
      //                 color: whiteColor,
      //               )
      //             : const Icon(
      //                 BoxIcons.bx_moon,
      //               ),
      //       );
      //     });
      //   },
      // ),
    );
  }
}
