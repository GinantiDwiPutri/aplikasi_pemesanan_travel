import 'package:aplikasi_pemesanan_travel/app/controllers/location_controller.dart';
import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedDate = DateTime.now().obs;

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  Stream<List<TripModel>> streamDataTrips() {
    return trips
        .where('status', isEqualTo: 'Menunggu Keberangkatan')
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (snapshot) => TripModel.fromJson(snapshot),
              )
              .toList(),
        );
  }

  @override
  void onInit() {
    super.onInit();
    Get.find<LocationController>().locatePosition();
  }
}
