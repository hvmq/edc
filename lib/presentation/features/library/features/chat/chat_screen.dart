import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color.dart';
import '../../features/chat/chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  final ChatController chatController;
  const ChatScreen(this.chatController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'hello'.tr,
          style: TextStyle(color: AppColor.primaryColor),
        ),
      ),
    );
  }
}
