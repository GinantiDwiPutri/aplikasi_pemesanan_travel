import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  const InvoiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    color: primaryColor,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: whiteColor,
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: 15,
              right: 15,
              child: Center(
                child: Column(
                  children: [
                    Lottie.asset(
                      "assets/lottie/animation_ll5hbhp5.json",
                      height: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Center(
                        child: Text(
                          "Pembayaran Berhasil!",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              left: 15,
              right: 15,
              child: PrimaryButton(
                onTap: () => Get.offNamed(Routes.DASHBOARD),
                text: "Kembali Ke Beranda",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
