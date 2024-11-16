import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/extensions/all.dart';
import '../../common_widgets/app_icon.dart';
import '../../resource/styles/gaps.dart';
import '../../routing/routers/app_pages.dart';
import 'notification_controller.dart';

class NotificationsIcon extends StatelessWidget {
  const NotificationsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (controller) {
        return Stack(
          children: [
            _buildIcon(context),
            if (controller.unreadNotificationsCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    controller.unreadNotificationsCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ).clickable(() {
          Get.toNamed(Routes.notification);
        });
      },
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Sizes.s2,
        right: Sizes.s2,
      ),
      child: AppIcon(
        icon: AppIcons.bell,
        padding: const EdgeInsets.all(6),
      ),
    );
  }
}
