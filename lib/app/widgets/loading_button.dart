import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: Get.width * 0.9,
        height: Get.height * 0.08,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: whiteColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                color: whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
