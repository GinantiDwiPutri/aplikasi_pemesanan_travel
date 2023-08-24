import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/order_model.dart';
import 'package:aplikasi_pemesanan_travel/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  final OrderModel order = Get.arguments;

  RxDouble rating = 0.0.obs;

  Stream<DocumentSnapshot<Object?>> getDriver() {
    return drivers.doc(order.driverPhoneNumber).snapshots();
  }

  Stream<DocumentSnapshot<Object?>> getTrip() {
    return trips.doc(order.tripID).snapshots();
  }

  void saveRating() async {
    await orders.doc(order.orderId).update({
      'rating': rating.value.toInt(),
    });

    Fluttertoast.showToast(msg: "Rating Berhasil Disimpan");

    Get.toNamed(Routes.DASHBOARD);
  }

  @override
  void onInit() {
    super.onInit();
    rating.value = order.rating.toDouble();
  }

  @override
  void onClose() {
    super.onClose();
    rating.close();
  }
}
