import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:aplikasi_pemesanan_travel/app/models/trip_model.dart';
import 'package:get/get.dart';

class ListTravelController extends GetxController {
  Stream<List<TripModel>> streamDataTrips() {
    return firestore.collection('trips').snapshots().map(
          (event) => event.docs
              .map(
                (snapshot) => TripModel.fromJson(snapshot),
              )
              .toList(),
        );
  }
}
