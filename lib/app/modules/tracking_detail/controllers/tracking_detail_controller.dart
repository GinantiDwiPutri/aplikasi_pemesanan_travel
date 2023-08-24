import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TrackingDetailController extends GetxController {
  final OrderModel order = Get.arguments;

  Stream<DocumentSnapshot<Object?>> getDriver() {
    return drivers.doc(order.driverPhoneNumber).snapshots();
  }

  Stream<DocumentSnapshot<Object?>> getTrip() {
    return trips.doc(order.tripID).snapshots();
  }
}
