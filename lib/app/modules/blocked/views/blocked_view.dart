import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/blocked_controller.dart';

class BlockedView extends GetView<BlockedController> {
  const BlockedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          alignment: WrapAlignment.center,
          children: [
            Image.asset(
              "assets/images/blocked.png",
              width: 200,
            ),
            const Text(
              'Sepertinya anda telah melakukan pelanggaran. Kami menutup hak akses anda.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
