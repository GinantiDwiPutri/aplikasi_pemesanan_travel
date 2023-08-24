import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  RxBool isShowEmoji = false.obs;

  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  TextEditingController chatController = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamChats() {
    return drivers
        .doc(Get.arguments['phoneNumber'])
        .collection("chats")
        .doc(user.value.phoneNumber)
        .collection("messages")
        .orderBy('time')
        .snapshots();
  }

  void newChat() async {
    await drivers
        .doc(Get.arguments['phoneNumber'])
        .collection("chats")
        .doc(user.value.phoneNumber)
        .set({'displayName': user.value.displayName});

    await drivers
        .doc(Get.arguments['phoneNumber'])
        .collection("chats")
        .doc(user.value.phoneNumber)
        .collection("messages")
        .add({
      'sender': user.value.phoneNumber,
      'receiver': Get.arguments['phoneNumber'],
      'message': chatController.text,
      'time': DateTime.now().toIso8601String(),
      'isRead': false,
    });

    chatController.clear();
  }
}
