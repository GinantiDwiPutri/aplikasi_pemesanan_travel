import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/models/order_model.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Riwayat Perjalanan Kamu',
            style: Get.textTheme.headlineSmall,
          ),
          leadingWidth: 0,
        ),
        body: StreamBuilder<List<OrderModel>>(
          stream: controller.getOrderDataDone(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              List<OrderModel> order = snapshot.data!;
              if (order.isEmpty) {
                return Center(
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/box.png",
                        width: 200,
                      ),
                      const Text(
                        'Kami tidak menemukan data apapun.\nKamu belum pernah reservasi travel disini.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: order.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.toNamed(
                        Routes.ORDER_DETAIL,
                        arguments: order[index],
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: primaryColor,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.rectangle,
                              ),
                              child: Center(
                                child: Text(
                                  order[index].seat,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order[index].route,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  (order[index].rating == 0)
                                      ? const Text("Belum Diberi Rating")
                                      : RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating:
                                              order[index].rating.toDouble(),
                                          itemSize: 18,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: const [
                                      Text("Detail"),
                                      Icon(BoxIcons.bx_chevron_right)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          },
        ),
      );
}
