import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisabledButton extends StatelessWidget {
  const DisabledButton({super.key, required this.text});

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
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
