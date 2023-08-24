import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:aplikasi_pemesanan_travel/app/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controllers/choose_seat_controller.dart';

class ChooseSeatView extends GetView<ChooseSeatController> {
  const ChooseSeatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
          title: const Text(
            'Pilih Kursi',
            style: TextStyle(
              fontFamily: fontFamily,
              color: blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: StreamBuilder(
            stream: controller.getTrip(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final trip = snapshot.data!;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      runSpacing: 0,
                      spacing: 5,
                      children: [
                        const Text(
                          "Rute :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          trip['route'],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      runSpacing: 0,
                      spacing: 5,
                      children: [
                        const Text(
                          "Tanggal :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          trip['date'],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      runSpacing: 0,
                      spacing: 5,
                      children: [
                        const Text(
                          "Jam Keberangkatan :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${trip['time']} WIB",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      runSpacing: 0,
                      spacing: 5,
                      children: [
                        const Text(
                          "Harga Kursi :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Rp. ${trip['price']}",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    StreamBuilder(
                      stream: controller.getDriver(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        }

                        return Row(
                          children: [
                            (snapshot.data!['photoURL'] == "")
                                ? const CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/images/man.png",
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      snapshot.data!['photoURL'],
                                    ),
                                  ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!['displayName'],
                                    style: Get.textTheme.headlineSmall,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${snapshot.data!['carType']} (${snapshot.data!['carNumber']})",
                                    style: Get.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  Get.toNamed(Routes.CHAT_ROOM, arguments: {
                                "phoneNumber": snapshot.data!['phoneNumber'],
                                "displayName": snapshot.data!['displayName'],
                                "carType": snapshot.data!['carType'],
                                "carNumber": snapshot.data!['carNumber'],
                              }),
                              icon: const Icon(
                                BoxIcons.bx_chat,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        (trip['A1'] == "")
                            ? InkWell(
                                onTap: () => Get.toNamed(
                                  Routes.PAYMENT,
                                  arguments: {
                                    "price": trip['price'],
                                    "date": trip['date'],
                                    "route": trip['route'],
                                    "seat": 'A1',
                                    "clientPhoneNumber": user.value.phoneNumber,
                                    "driverPhoneNumber":
                                        trip['driverPhoneNumber'],
                                    "displayName": user.value.displayName,
                                    "email": user.value.email,
                                    "tripID": trip.id,
                                  },
                                ),
                                child: Image.asset(
                                  "assets/images/seat.png",
                                  height: 100,
                                ),
                              )
                            : InkWell(
                                onTap: () => Fluttertoast.showToast(
                                  msg: "Sudah Berisi Penumpang",
                                ),
                                child: Image.asset(
                                  "assets/images/seat-fill.png",
                                  height: 100,
                                ),
                              ),
                        (trip['A2'] == "")
                            ? InkWell(
                                onTap: () => Get.toNamed(
                                  Routes.PAYMENT,
                                  arguments: {
                                    "price": trip['price'],
                                    "date": trip['date'],
                                    "route": trip['route'],
                                    "seat": 'A2',
                                    "clientPhoneNumber": user.value.phoneNumber,
                                    "driverPhoneNumber":
                                        trip['driverPhoneNumber'],
                                    "displayName": user.value.displayName,
                                    "email": user.value.email,
                                    "tripID": trip.id,
                                  },
                                ),
                                child: Image.asset(
                                  "assets/images/seat.png",
                                  height: 100,
                                ),
                              )
                            : InkWell(
                                onTap: () => Fluttertoast.showToast(
                                  msg: "Sudah Berisi Penumpang",
                                ),
                                child: Image.asset(
                                  "assets/images/seat-fill.png",
                                  height: 100,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        (trip['A3'] == "")
                            ? InkWell(
                                onTap: () => Get.toNamed(
                                  Routes.PAYMENT,
                                  arguments: {
                                    "price": trip['price'],
                                    "date": trip['date'],
                                    "route": trip['route'],
                                    "seat": 'A3',
                                    "clientPhoneNumber": user.value.phoneNumber,
                                    "driverPhoneNumber":
                                        trip['driverPhoneNumber'],
                                    "displayName": user.value.displayName,
                                    "email": user.value.email,
                                    "tripID": trip.id,
                                  },
                                ),
                                child: Image.asset(
                                  "assets/images/seat.png",
                                  height: 100,
                                ),
                              )
                            : InkWell(
                                onTap: () => Fluttertoast.showToast(
                                  msg: "Sudah Berisi Penumpang",
                                ),
                                child: Image.asset(
                                  "assets/images/seat-fill.png",
                                  height: 100,
                                ),
                              ),
                        (trip['A4'] == "")
                            ? InkWell(
                                onTap: () => Get.toNamed(
                                  Routes.PAYMENT,
                                  arguments: {
                                    "price": trip['price'],
                                    "date": trip['date'],
                                    "route": trip['route'],
                                    "seat": 'A4',
                                    "clientPhoneNumber": user.value.phoneNumber,
                                    "driverPhoneNumber":
                                        trip['driverPhoneNumber'],
                                    "displayName": user.value.displayName,
                                    "email": user.value.email,
                                    "tripID": trip.id,
                                  },
                                ),
                                child: Image.asset(
                                  "assets/images/seat.png",
                                  height: 100,
                                ),
                              )
                            : InkWell(
                                onTap: () => Fluttertoast.showToast(
                                  msg: "Sudah Berisi Penumpang",
                                ),
                                child: Image.asset(
                                  "assets/images/seat-fill.png",
                                  height: 100,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      );
}
