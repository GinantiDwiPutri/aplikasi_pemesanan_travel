import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/models/notification_model.dart';
import 'package:aplikasi_pemesanan_travel/app/theme/text_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
          title: const Text(
            'Pemberitahuan',
            style: TextStyle(
              fontFamily: fontFamily,
              color: blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: StreamBuilder<List<NotificationModel>>(
          stream: controller.getNotifications(),
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
                          horizontal: 15, vertical: 5),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              );
            } else {
              List<NotificationModel> listNotification = snapshot.data!;
              if (listNotification.isEmpty) {
                return const Center(
                  child: Text("Kosong"),
                );
              } else {
                return ListView.builder(
                  itemCount: listNotification.length,
                  itemBuilder: (context, index) {
                    return Material(
                      color: Colors.transparent,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: blackColor,
                              offset: Offset(0.5, 0.5),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat('kk:mm WIB | dd MMMM yyyy').format(
                                DateTime.parse(
                                  listNotification[index].time,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                Center(
                                  child: Image.asset(
                                    "assets/images/notification.png",
                                    height: 50,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listNotification[index].title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        listNotification[index].description,
                                        style: Get.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
