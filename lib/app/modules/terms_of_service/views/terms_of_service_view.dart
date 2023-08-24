import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/theme/text_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/terms_of_service_controller.dart';

class TermsOfServiceView extends GetView<TermsOfServiceController> {
  const TermsOfServiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
          title: const Text(
            'Ketentuan Layanan',
            style: TextStyle(
              fontFamily: fontFamily,
              color: blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: Obx(
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
        ),
      );
}
