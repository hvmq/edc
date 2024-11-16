import 'dart:ui';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../../../routing/routers/app_pages.dart';
import '../../../search_user/views/search_user_bottom_sheet.dart';
import '../../all.dart';
import 'widgets/actions_chat_details_widget.dart';
import 'widgets/edit_info_group_chat.dart';
import 'widgets/mute_conversation_action_widget.dart';
import 'widgets/setting_group_widget.dart';

part '_group_chat_details.dart';
part '_private_chat_details.dart';
part 'widgets/_images_tab_view.dart';
part 'widgets/_link_tab_view.dart';
part 'widgets/_members_tab_view.dart';
part 'widgets/_video_tab_view.dart';
part 'widgets/_voice_tab_view.dart';

class ConversationDetailsView extends BaseView<ConversationDetailsController> {
  const ConversationDetailsView({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Obx(
      () => controller.conversation.isGroup
          ? _GroupChatDetails(controller: controller)
          : _PrivateChatDetails(
              controller: controller,
              chatHubController: Get.find<ChatHubController>(),
            ),
    );
  }
}
