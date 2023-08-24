import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/models/trip_model.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:aplikasi_pemesanan_travel/app/theme/text_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/list_travel_controller.dart';

class ListTravelView extends GetView<ListTravelController> {
  const ListTravelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
          title: const Text(
            'Semua Keberangkatan Travel',
            style: TextStyle(
              fontFamily: fontFamily,
              color: blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: StreamBuilder<List<TripModel>>(
          stream: controller.streamDataTrips(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: List.generate(
                  3,
                  (index) => Shimmer.fromColors(
                    baseColor: Colors.grey[500]!,
                    highlightColor: Colors.grey[200]!,
                    period: const Duration(milliseconds: 500),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
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

              return Center(
                child: Text("${snapshot.data}"),
              );
              // return ListView.builder(
              //   itemCount: trip.length,
              //   itemBuilder: (context, index) {
              //     return InkWell(
              //       onTap: () =>
              //           Get.toNamed(Routes.CHOOSE_SEAT, arguments: trip[index]),
              //       child: Container(
              //         margin: const EdgeInsets.symmetric(
              //           horizontal: 20,
              //           vertical: 10,
              //         ),
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 10,
              //           vertical: 10,
              //         ),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(
              //             color: primaryColor,
              //           ),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   trip[index].route,
              //                   style: const TextStyle(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   height: 5,
              //                 ),
              //                 Text("Tanggal: ${trip[index].date}"),
              //                 const SizedBox(
              //                   height: 5,
              //                 ),
              //                 Text("Jam Berangkat: ${trip[index].time} WIB"),
              //               ],
              //             ),
              //             Image.asset(
              //               "assets/images/route.png",
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // );
            }
          },
        ),
      );
}
