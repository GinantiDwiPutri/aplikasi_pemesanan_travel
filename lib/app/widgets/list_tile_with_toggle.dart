import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListTileWithToggle extends StatelessWidget {
  const CustomListTileWithToggle({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.widget,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: Get.width,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 8,
                    child: Row(
                      children: [
                        Icon(icon),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: widget,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
