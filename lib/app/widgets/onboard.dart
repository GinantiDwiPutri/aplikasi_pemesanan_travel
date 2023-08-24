import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardWidget extends StatelessWidget {
  const OnBoardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: Get.height / 4,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Get.textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
         description,
          textAlign: TextAlign.center,
          style: Get.textTheme.bodySmall,
        ),
        const Spacer(),
      ],
    );
  }
}
