import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../controllers/tracking_detail_controller.dart';

class TrackingDetailView extends GetView<TrackingDetailController> {
  const TrackingDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                  return Stack(
                    children: [
                      SlidingUpPanel(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        maxHeight: MediaQuery.of(context).size.height * 0.5,
                        defaultPanelState: PanelState.OPEN,
                        parallaxEnabled: true,
                        parallaxOffset: 0.6,
                        panel: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[500],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    controller.order.route,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    "Keberangkatan: ${trip['date']} pukul ${trip['time']} WIB",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("Driver Travel:"),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
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
                                      onPressed: () => Get.toNamed(
                                          Routes.CHAT_ROOM,
                                          arguments: {
                                            "phoneNumber":
                                                driver['phoneNumber'],
                                            "displayName":
                                                driver['displayName'],
                                            "carType": driver['carType'],
                                            "carNumber": driver['carNumber'],
                                          }),
                                      icon: const Icon(
                                        BoxIcons.bx_chat,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "ID Perjalanan : ${controller.order.tripID}"),
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
                              ],
                            ),
                          ),
                        ),
                        body: const GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(-1.8325392, 109.9760239),
                            zoom: 15.0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5,
                        top: 35,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: const Icon(BoxIcons.bx_arrow_back),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 60,
                        top: 35,
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width - 65,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Text(
                                "Tinjau Perjalananmu",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
