import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/help_model.dart';
import 'package:get/get.dart';

class HelpController extends GetxController {
  Stream<List<HelpModel>> streamDataHelps() {
    return firestore
        .collection('helps')
        .where('on', isEqualTo: 'Berangkut')
        .snapshots()
        .map(
          (event) => event.docs
              .map((snapshot) => HelpModel.fromJson(snapshot),)
              .toList(),
        );
  }
}
