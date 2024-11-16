import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/all.dart';
import '../../../models/all.dart';
import '../../base/all.dart';
import '../../common_widgets/all.dart';
import '../../common_widgets/app_blurry_container.dart';
import '../../resource/resource.dart';
import 'all.dart';

class NotificationView extends BaseView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        text: l10n.notification__title,
        titleType: AppBarTitle.text,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () async {
              controller.refreshNotifications();
            },
            child: CustomScrollView(
              controller: controller.scroll,
              slivers: [
                if (controller.notifications.isEmpty)
                  SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppIcon(icon: AppIcons.bell, size: 100),
                        AppSpacing.gapH16,
                        Text(
                          l10n.notification__no_notification,
                          style: AppTextStyles.s16w400,
                        ),
                      ],
                    ),
                  ),
                SliverList.separated(
                  itemBuilder: (context, index) {
                    final notification = controller.notifications[index];

                    return _buildNotificationItem(
                      context: context,
                      notification: notification,
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => AppSpacing.gapH16,
                  itemCount: controller.notifications.length,
                ),
                SliverToBoxAdapter(
                  child: controller.isLoadingLoadMore.value
                      ? Container(
                          padding: const EdgeInsets.all(Sizes.s12),
                          child: const AppDefaultLoading(
                            color: AppColors.white,
                          ),
                        )
                      : const SizedBox(
                          height: Sizes.s24,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required BuildContext context,
    required NotificationModel notification,
    required int index,
  }) {
    return AppBlurryContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: AppTextStyles.s16w600,
                    ),
                    AppSpacing.gapH4,
                    Text(
                      notification.contentText,
                      style: AppTextStyles.s14w400,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8, top: 16),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: notification.readAt == null
                      ? AppColors.negative
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              DateTimeUtil.timeAgo(
                context,
                notification.createdAt ?? DateTime.now(),
              ),
              style: AppTextStyles.s12w400,
            ),
          ),
        ],
      ),
    ).clickable(() {
      controller.onTapNotification(
        notification: notification,
        index: index,
      );
    });
  }
}
