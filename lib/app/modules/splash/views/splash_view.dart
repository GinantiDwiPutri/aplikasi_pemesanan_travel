import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 50,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      "assets/logo/logo.png",
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                  ),
                  const Text(
                    "BERANGKUT",
                    style: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  Text(
                    "Oleh",
                    style: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Kayong Developer",
                    style: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
