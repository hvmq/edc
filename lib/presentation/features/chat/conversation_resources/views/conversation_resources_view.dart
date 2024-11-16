// ignore_for_file: prefer-single-widget-per-file

import 'package:any_link_preview/any_link_preview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../../core/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../../all.dart';

part 'widgets/_images_tab_view.dart';
part 'widgets/_link_tab_view.dart';
part 'widgets/_video_tab_view.dart';
part 'widgets/_voice_tab_view.dart';

class ConversationResourcesView
    extends BaseView<ConversationResourcesController> {
  const ConversationResourcesView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        text: l10n.conversation_resources__title,
      ),
      body: Column(
        children: [
          _buildTabBar(),
          AppSpacing.gapH8,
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _ImageTabView(controller: controller),
                _VideoTabView(controller: controller),
                _VoiceTabView(controller: controller),
                _LinkTabView(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      labelColor: AppColors.text4,
      indicatorColor: AppColors.text4,
      dividerColor: AppColors.subText1,
      dividerHeight: 0.5,
      controller: controller.tabController,
      tabs: [
        Tab(text: l10n.conversation_resources__tab_image),
        Tab(text: l10n.conversation_resources__tab_video),
        Tab(text: l10n.conversation_resources__tab_voice),
        Tab(text: l10n.conversation_resources__tab_links),
      ],
    );
  }
}
