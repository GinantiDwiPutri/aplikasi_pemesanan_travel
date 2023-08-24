import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:flutter/material.dart';

class RequiredLabelText extends StatelessWidget {
  const RequiredLabelText({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Text(
          "*",
          style: TextStyle(
            color: dangerColor,
          ),
        ),
      ],
    );
  }
}
