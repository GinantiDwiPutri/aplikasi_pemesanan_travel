import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/models/trip_model.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:aplikasi_pemesanan_travel/app/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
          title: const Text(
            'Pembayaran',
            style: TextStyle(
              fontFamily: fontFamily,
              color: blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            await Fluttertoast.showToast(
                msg: "Pembayaran Reservasi Dibatalkan");

            return true;
          },
          child: StreamBuilder<TripModel>(
            stream: controller.streamTripStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              TripModel trip = snapshot.data!;
              if (Get.arguments['seat'] == 'A1') {
                if (trip.a1 != "") {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      Get.offNamed(Routes.INVOICE);

                      Fluttertoast.showToast(msg: "Reservasi Travel Berhasil");
                    },
                  );
                }
              }

              if (Get.arguments['seat'] == 'A2') {
                if (trip.a2 != "") {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      Get.offNamed(Routes.INVOICE);

                      Fluttertoast.showToast(msg: "Reservasi Travel Berhasil");
                    },
                  );
                }
              }

              if (Get.arguments['seat'] == 'A3') {
                if (trip.a3 != "") {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      Get.offNamed(Routes.INVOICE);

                      Fluttertoast.showToast(msg: "Reservasi Travel Berhasil");
                    },
                  );
                }
              }

              if (Get.arguments['seat'] == 'A4') {
                if (trip.a4 != "") {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      Get.offNamed(Routes.INVOICE);

                      Fluttertoast.showToast(msg: "Reservasi Travel Berhasil");
                    },
                  );
                }
              }

              return Obx(
                () => (controller.isLoading.isTrue)
                    ? Column(
                        children: [
                          LinearProgressIndicator(
                            value: controller.progressIndicator.value,
                            color: Colors.green,
                          ),
                          const Expanded(
                            child: Center(
                              child: Text("Mohon Tunggu..."),
                            ),
                          ),
                        ],
                      )
                    : WebViewWidget(
                        controller: controller.webviewController,
                      ),
              );
            },
          ),
        ),
      );
}
