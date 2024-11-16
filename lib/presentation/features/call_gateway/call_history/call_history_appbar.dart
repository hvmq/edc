import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common_widgets/all.dart';
import '../../../resource/styles/app_colors.dart';
import '../all.dart';
import 'call_history_controller.dart';

class CallHistoryAppBar extends CommonAppBar {
  CallHistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      automaticallyImplyLeading: false,
      titleType: AppBarTitle.none,
      titleWidget: GetBuilder<CallGatewayController>(
        builder: (callGatewayController) {
          return GetBuilder(
            init: Get.find<CallHistoryController>(),
            builder: (controller) {
              if (callGatewayController.currentIndex.value == 2) {
                return SlidingSwitch(
                  value: controller.switchCallHistory.value,
                  textOn: callGatewayController.l10n.call_history__missed,
                  textOff: callGatewayController.l10n.call_history__all,
                  colorOn: AppColors.white,
                  colorOff: AppColors.white,
                  inactiveColor: AppColors.text4,
                  contentSize: 14,
                  width: 230.w,
                  height: 55.h,
                  onChanged: (value) {
                    controller.updateCallHistoryAppBar(value);
                  },
                  onTap: () {},
                  onSwipe: () {},
                );
              }

              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
