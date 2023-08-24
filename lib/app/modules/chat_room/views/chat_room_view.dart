import 'package:aplikasi_pemesanan_travel/app/global/color.dart';
import 'package:aplikasi_pemesanan_travel/app/global/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 90,
            iconTheme: const IconThemeData(
              color: blackColor,
            ),
            leading: InkWell(
              onTap: () => Get.back(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(BoxIcons.bx_arrow_back),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/man.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Get.arguments["displayName"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "${Get.arguments["carType"]}, ${Get.arguments["carNumber"]}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: blackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamChats(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.waiting) {
                      var listChat = snapshot.data?.docs;
                      return ListView.builder(
                        itemCount: listChat!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              ItemChat(
                                isSender: (listChat[index]["sender"] ==
                                        user.value.phoneNumber)
                                    ? true
                                    : false,
                                msg: listChat[index]["message"],
                                time: listChat[index]["time"],
                                timeBefore: listChat[index]["time"],
                              )
                            ],
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: controller.isShowEmoji.isTrue
                      ? 5
                      : context.mediaQueryPadding.bottom,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        autocorrect: false,
                        controller: controller.chatController,
                        focusNode: controller.focusNode,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: IconButton(
                            onPressed: () {
                              controller.focusNode.unfocus();
                              controller.isShowEmoji.toggle();
                            },
                            icon: const Icon(Icons.emoji_emotions_outlined),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: primaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Material(
                      borderRadius: BorderRadius.circular(100),
                      color: primaryColor,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () => controller.newChat(),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => (controller.isShowEmoji.isTrue)
                    ? const SizedBox(
                        height: 325,
                        child: EmojiPicker(
                          config: Config(backspaceColor: primaryColor),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      );
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key? key,
    required this.isSender,
    required this.msg,
    required this.time,
    required this.timeBefore,
  }) : super(key: key);

  final bool isSender;
  final String msg;
  final String time;
  final String timeBefore;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: isSender
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                msg,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              DateFormat('kk:mm WIB').format(
                DateTime.parse(
                  time,
                ),
              ),
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
}
