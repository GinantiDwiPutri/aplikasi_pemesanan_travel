import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/models/order_model.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controllers/tracking_controller.dart';

class TrackingView extends GetView<TrackingController> {
  const TrackingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Tinjau Perjalanan',
            style: Get.textTheme.headlineSmall,
          ),
          leadingWidth: 0,
        ),
        body: StreamBuilder<List<OrderModel>>(
          stream: controller.getOrderDataOnProcess(),
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
                        Routes.TRACKING_DETAIL,
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
                                color: Colors.amber,
                                shape: BoxShape.rectangle,
                              ),
                              child: Center(
                                child: Text(
                                  order[index].seat,
                                  style: const TextStyle(
                                    fontSize: 16,
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
                                    height: 5,
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
