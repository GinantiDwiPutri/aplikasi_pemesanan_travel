import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String orderId;
  String time;
  String clientPhoneNumber;
  String driverPhoneNumber;
  String route;
  String status;
  String seat;
  int rating;
  String cost;
  String tripID;

  OrderModel({
    required this.orderId,
    required this.time,
    required this.clientPhoneNumber,
    required this.driverPhoneNumber,
    required this.route,
    required this.status,
    required this.seat,
    required this.rating,
    required this.cost,
    required this.tripID,
  });

  factory OrderModel.fromJson(DocumentSnapshot snapshot) {
    return OrderModel(
      orderId: snapshot.id,
      time: snapshot['time'],
      clientPhoneNumber: snapshot['clientPhoneNumber'],
      driverPhoneNumber: snapshot['driverPhoneNumber'],
      route: snapshot['route'],
      status: snapshot['status'],
      seat: snapshot['seat'],
      rating: snapshot['rating'] as int,
      cost: snapshot['cost'],
      tripID: snapshot['tripID'],
    );
  }
}
