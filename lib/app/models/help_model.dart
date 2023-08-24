import 'package:cloud_firestore/cloud_firestore.dart';

class HelpModel {
  String title;
  String content;
  String on;

  HelpModel({
    required this.title,
    required this.content,
    required this.on,
  });

  factory HelpModel.fromJson(DocumentSnapshot snapshot) {
    return HelpModel(
      title: snapshot['title'],
      content: snapshot['content'],
      on: snapshot['on'],
    );
  }
}
