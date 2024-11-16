import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../resource/resource.dart';
import '../all.dart';
import 'mana_mission_day_item_widget.dart';
import 'mana_progress_linear_indicator.dart';
import 'shimmer_loading_mission.dart';

class ManaMissionWidget extends GetView<PersonalPageController> {
  const ManaMissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: controller.currentUser.premium == 'vip'
                ? (904 * (1.sw - 40 - 22)) / 764
                : 416,
            decoration: controller.currentUser.premium == 'vip'
                ? BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/images/mission-vip.png')),
                    // color: AppColors.white,

                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2, color: Colors.black.withOpacity(0.25))
                    ],
                  )
                : BoxDecoration(
                    color: controller.currentUser.premium == 'business'
                        ? Colors.transparent
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: controller.currentUser.premium == 'business'
                        ? []
                        : [
                            BoxShadow(
                                blurRadius: 2,
                                color: Colors.black.withOpacity(0.25))
                          ],
                  ),
            // margin: const EdgeInsets.symmetric(
            //   horizontal: Sizes.s20,
            //   vertical: Sizes.s24,
            // ),
            padding: const EdgeInsets.only(
              left: Sizes.s20,
              top: Sizes.s20,
              bottom: Sizes.s12,
            ),
            // padding: AppSpacing.edgeInsetsAll16,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: Sizes.s24,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            l10n.profile__misson_title,
                            style: AppTextStyles.s16w700.copyWith(
                              color: AppColors.text2,
                            ),
                          ),
                          // Text(
                          //   l10n.profile__phone_exits,
                          //   style: AppTextStyles.s16w700.copyWith(
                          //     color: AppColors.text8,
                          //   ),
                          // ),
                          const Spacer(),
                          Row(
                            children: [
                              Obx(
                                () => Text(
                                  '${controller.mana?.mana ?? 0}/${controller.mana?.maxMana ?? 50} Neutron',
                                  style: AppTextStyles.s16w700.copyWith(
                                    color: AppColors.text2,
                                  ),
                                ),
                              ),
                              // AppSpacing.gapW4,
                              // const CircleAvatar(
                              //   backgroundColor: AppColors.pacificBlue,
                              //   radius: Sizes.s14,
                              //   child: Icon(
                              //     Icons.add,
                              //     color: AppColors.white,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      AppSpacing.gapH12,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //       child: ManaMissionTypeWidget(
                      //         missionManaType: controller.rxMissionManaType,
                      //       ),
                      //     ),
                      //     // InkWell(
                      //     //   onTap: controller.onRefreshManaMission,
                      //     //   child: const CircleAvatar(
                      //     //     backgroundColor: AppColors.pacificBlue,
                      //     //     radius: Sizes.s14,
                      //     //     child: Icon(
                      //     //       Icons.cached_outlined,
                      //     //       color: AppColors.white,
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),
                      // AppSpacing.gapH12,
                    ],
                  ),
                ),
                AppSpacing.gapH12,
                Padding(
                  padding: const EdgeInsets.only(
                    right: Sizes.s24,
                  ),
                  child: Obx(
                    () => ManaProgressLinearIndicator(
                      currentValue: controller.mana?.mana ?? 0,
                      limit: controller.mana?.maxMana ?? 50,
                    ),
                  ),
                ),
                AppSpacing.gapH12,
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          controller.isLoadingMisson.value
                              ? const ShimmerLoadingMission()
                              : ManaMissionDayItemWidget(
                                  manaMission: controller.manaMissions[index],
                                ),
                      itemCount: controller.isLoadingMisson.value
                          ? 2
                          : controller.manaMissions.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
