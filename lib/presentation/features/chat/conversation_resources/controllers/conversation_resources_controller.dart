import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../models/conversation.dart';
import '../../../../base/base_controller.dart';

class ConversationResourcesArguments {
  final Conversation conversation;

  const ConversationResourcesArguments({
    required this.conversation,
  });
}

class ConversationResourcesController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late final Conversation conversation;
  late final TabController tabController;

  final RxList<String> _images = <String>[].obs;
  List<String> get images => _images.reversed.toList();

  final RxList<String> _videos = <String>[].obs;
  List<String> get videos => _videos.reversed.toList();

  final RxList<String> _audios = <String>[].obs;
  List<String> get audios => _audios.reversed.toList();

  final RxList<String> _links = <String>[].obs;
  List<String> get links => _links.reversed.toList();

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 4, vsync: this);
    final args = Get.arguments as ConversationResourcesArguments;
    conversation = args.conversation;

    _loadConversationResources();
    _loadConversationLinks();
  }

  Future<void> _loadConversationResources() async {}

  Future<void> _loadConversationLinks() async {}
}
