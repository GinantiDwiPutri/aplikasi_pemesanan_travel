import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/custom_divider.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/danger_button.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/list_tile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Obx(
                    () => (user.value.photoURL == "")
                        ? const CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/images/man.png",
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                              user.value.photoURL!,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            "${user.value.displayName}",
                            style: Get.textTheme.headlineSmall,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Text(
                            "${user.value.phoneNumber}",
                            style: Get.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.toNamed(Routes.NOTIFICATION),
                    icon: const Icon(
                      BoxIcons.bx_bell,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  CustomListTile(
                    icon: BoxIcons.bx_pencil,
                    title: 'Edit Profil',
                    onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
                  ),
                  const CustomDivider(),
                  CustomListTile(
                    icon: BoxIcons.bx_log_out_circle,
                    title: 'Keluar',
                    onTap: () => Get.bottomSheet(
                      Container(
                        padding: const EdgeInsets.all(20),
                        height: Get.height * 0.30,
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Flexible(
                              child: Text(
                                "Kamu yakin ingin keluar dari aplikasi?",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DangerButton(
                              onTap: () {
                                auth.signOut();
                                Get.offAllNamed(Routes.SPLASH);
                              },
                              text: "Keluar",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const CustomDivider(),
                  CustomListTile(
                    icon: BoxIcons.bxs_help_circle,
                    title: 'FAQ',
                    onTap: () => Get.toNamed(Routes.HELP),
                  ),
                  const CustomDivider(),
                  CustomListTile(
                    icon: BoxIcons.bx_file_blank,
                    title: 'Ketentuan Layanan',
                    onTap: () => Get.toNamed(Routes.TERMS_OF_SERVICE),
                  ),
                  const CustomDivider(),
                  CustomListTile(
                    icon: BoxIcons.bx_info_circle,
                    title: 'Kebijakan Privasi',
                    onTap: () => Get.toNamed(Routes.PRIVACY_POLICY),
                  ),
                  const CustomDivider(),
                  // SimpleBuilder(
                  //   builder: (_) => CustomListTileWithToggle(
                  //     icon: BoxIcons.bx_moon,
                  //     title: 'Mode Gelap',
                  //     onTap: () {
                  //       controller
                  //           .onThemeChanged(!getStorage.read('isDarkMode'));
                  //     },
                  //     widget: Switch(
                  //       value: getStorage.read('isDarkMode'),
                  //       onChanged: (value) {
                  //         controller.onThemeChanged(value);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // const CustomDivider(),
                ],
              ),
            ),
          ],
        ),
      );
}
