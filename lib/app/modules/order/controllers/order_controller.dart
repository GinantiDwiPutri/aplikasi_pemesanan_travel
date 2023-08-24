import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  Stream<List<OrderModel>> getOrderDataDone() {
    return orders
        .where('clientPhoneNumber', isEqualTo: user.value.phoneNumber)
        .where('status', isEqualTo: 'Selesai')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => OrderModel.fromJson(e)).toList());
  }
}
