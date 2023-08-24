import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/notification_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  Stream<List<NotificationModel>> getNotifications() {
    return users
        .doc(user.value.phoneNumber)
        .collection("notifications")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => NotificationModel.fromJson(e)).toList());
  }
}
