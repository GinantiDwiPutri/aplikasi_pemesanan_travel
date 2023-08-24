import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/trip_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChooseSeatController extends GetxController {
  final TripModel trip = Get.arguments;

  Stream<DocumentSnapshot<Object?>> getDriver() {
    return drivers.doc(trip.driverPhoneNumber).snapshots();
  }

  Stream<DocumentSnapshot<Object?>> getTrip() {
    return trips.doc(trip.id).snapshots();
  }
}
