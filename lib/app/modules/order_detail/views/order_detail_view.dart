import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:aplikasi_pemesanan_travel/app/theme/text_theme.dart';
import 'package:aplikasi_pemesanan_travel/app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../controllers/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  const OrderDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Riwayat Perjalanan',
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
      body: StreamBuilder(
          stream: controller.getDriver(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var driver = snapshot.data!;

            return StreamBuilder(
                stream: controller.getTrip(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var trip = snapshot.data!;

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                (driver["photoURL"] == "")
                                    ? const CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/images/man.png",
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          driver["photoURL"],
                                        ),
                                      ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        driver['displayName'],
                                        style: Get.textTheme.headlineSmall,
                                      ),
                                      Text(
                                        "${driver['carType']}, ${driver['carNumber']}",
                                        style: Get.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      Get.toNamed(Routes.CHAT_ROOM, arguments: {
                                    "phoneNumber": driver['phoneNumber'],
                                    "displayName": driver['displayName'],
                                    "carType": driver['carType'],
                                    "carNumber": driver['carNumber'],
                                  }),
                                  icon: const Icon(
                                    BoxIcons.bx_chat,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("ID Perjalanan : ${controller.order.tripID}"),
                          Text("Rute : ${controller.order.route}"),
                          Text("Nomor Kursi : ${controller.order.seat}"),
                          Text("Harga : Rp. ${controller.order.cost}"),
                          Text("Status Perjalanan : ${trip['status']}"),
                          Text(
                              "Waktu Reservasi : ${DateFormat('kk:mm WIB | dd MMMM yyyy').format(
                            DateTime.parse(
                              controller.order.time,
                            ),
                          )}"),
                          const Divider(),
                          Center(
                            child: (controller.order.rating == 0)
                                ? const Text("Belum Diberi Rating")
                                : RatingBar.builder(
                                    ignoreGestures: true,
                                    initialRating: controller.rating.toDouble(),
                                    itemSize: 40,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: (controller.order.rating == 0)
                                  ? PrimaryButton(
                                      onTap: () => showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Beri Rating"),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Obx(
                                                () => RatingBar.builder(
                                                  minRating: 1,
                                                  initialRating: controller
                                                      .rating.value
                                                      .toDouble(),
                                                  itemSize: 35,
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    controller.rating.value =
                                                        rating;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  controller.saveRating(),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      text: "Beri Rating",
                                    )
                                  : PrimaryButton(
                                      onTap: () => showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Beri Rating"),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Obx(
                                                () => RatingBar.builder(
                                                  minRating: 1,
                                                  initialRating: controller
                                                      .rating.value
                                                      .toDouble(),
                                                  itemSize: 35,
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    controller.rating.value =
                                                        rating;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  controller.saveRating(),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      text: "Ubah Rating",
                                    )),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
