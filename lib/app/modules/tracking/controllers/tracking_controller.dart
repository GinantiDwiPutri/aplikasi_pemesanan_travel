import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/order_model.dart';
import 'package:get/get.dart';

class TrackingController extends GetxController {
  Stream<List<OrderModel>> getOrderDataOnProcess() {
    return orders
        .where('status', isEqualTo: 'Dalam Proses')
        .where('clientPhoneNumber', isEqualTo: user.value.phoneNumber)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => OrderModel.fromJson(e)).toList());
  }
}
