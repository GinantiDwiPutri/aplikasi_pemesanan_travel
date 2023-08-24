import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String title;
  String description;
  bool isRead;
  String time;

  NotificationModel({
    required this.title,
    required this.description,
    required this.isRead,
    required this.time,
  });

  factory NotificationModel.fromJson(DocumentSnapshot snapshot) {
    return NotificationModel(
      title: snapshot['title'],
      description: snapshot['description'],
      isRead: snapshot['isRead'],
      time: snapshot['time'],
    );
  }
}
