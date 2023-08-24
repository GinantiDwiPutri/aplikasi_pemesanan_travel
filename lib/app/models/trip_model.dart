import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  String id;
  String time;
  String date;
  String driverPhoneNumber;
  String route;
  String status;
  String a1;
  String a2;
  String a3;
  String a4;

  TripModel({
    required this.id,
    required this.time,
    required this.date,
    required this.driverPhoneNumber,
    required this.route,
    required this.status,
    required this.a1,
    required this.a2,
    required this.a3,
    required this.a4,
  });

  factory TripModel.fromJson(DocumentSnapshot snapshot) {
    return TripModel(
      id: snapshot.id,
      time: snapshot['time'],
      date: snapshot['date'],
      driverPhoneNumber: snapshot['driverPhoneNumber'],
      route: snapshot['route'],
      status: snapshot['status'],
      a1: snapshot['A1'],
      a2: snapshot['A2'],
      a3: snapshot['A3'],
      a4: snapshot['A4'],
    );
  }
}
