import 'package:aplikasi_pemesanan_travel/app/controllers/location_controller.dart';
import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/models/trip_model.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final locateC = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    whiteColor,
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Lokasimu Sekarang",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Obx(() {
                                if (locateC.position.value.locationName !=
                                    "Null") {
                                  return Text(
                                    locateC.position.value.locationName
                                        .toString(),
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[500]!,
                                    highlightColor: Colors.grey[200]!,
                                    period: const Duration(seconds: 1),
                                    child: Container(
                                      height: 20,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                }
                              }),
                            ],
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: const Icon(
                        //     BoxIcons.bx_search,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      "Keberangkatan Travel Yang Tersedia",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<List<TripModel>>(
                      stream: controller.streamDataTrips(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: primaryColor),
                          );
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Terjadi Kesalahan"),
                            );
                          }

                          List<TripModel> trip = snapshot.data!;
                          if (trip.isEmpty) {
                            return Center(
                              child: Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                alignment: WrapAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/no-trip.png",
                                    width: 200,
                                  ),
                                  const Text(
                                    'Aduhh, gaada keberangkatan travel yang tersedia nih.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: trip.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Get.toNamed(
                                  Routes.CHOOSE_SEAT,
                                  arguments: trip[index],
                                ),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            trip[index].route,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("Tanggal: ${trip[index].date}"),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              "Jam Berangkat: ${trip[index].time} WIB"),
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/images/route.png",
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
