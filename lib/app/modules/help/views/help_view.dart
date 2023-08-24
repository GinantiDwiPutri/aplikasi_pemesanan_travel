import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/models/help_model.dart';
import 'package:aplikasi_pemesanan_travel/app/theme/text_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/help_controller.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
          title: const Text(
            'Mari Kami Bantu',
            style: TextStyle(
              fontFamily: fontFamily,
              color: blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: StreamBuilder<List<HelpModel>>(
          stream: controller.streamDataHelps(),
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
              List<HelpModel> help = snapshot.data!;
              return ListView.builder(
                itemCount: help.length,
                itemBuilder: (context, index) {
                  return GFAccordion(
                    collapsedTitleBackgroundColor: whiteColor,
                    titleChild: Text(
                      help[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    contentChild: Text(
                      help[index].content,
                      style: const TextStyle(
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
}
