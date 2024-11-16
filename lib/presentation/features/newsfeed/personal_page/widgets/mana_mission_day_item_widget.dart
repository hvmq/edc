import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/mana_mission/mana_mission.dart';
import '../../../../resource/resource.dart';
import '../../../all.dart';
import 'done_widget.dart';

class ManaMissionDayItemWidget extends StatelessWidget {
  final ManaMission manaMission;

  const ManaMissionDayItemWidget({
    required this.manaMission,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String getLanguageValue(String key) {
      return manaMission.userMission?.languages![key];
    }

    const double cardHeight = 262.0;
    const double cardWeight = 180;
    final isDone = manaMission.isComplete();

    return Container(
      width: cardWeight,
      height: cardHeight,
      margin: const EdgeInsets.only(right: Sizes.s8),
      child: Stack(
        // alignment: Alignment.center,
        // clipBehavior: Clip.none,
        children: [
          Container(
            height: cardHeight - Sizes.s8 * 2,
            width: cardWeight - Sizes.s8 * 2,
            decoration: BoxDecoration(
              color: AppColors.background6,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25))
              ],
            ),
            padding: EdgeInsets.symmetric(
              vertical: Sizes.s12.h,
              horizontal: Sizes.s12.w,
            ),
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                Stack(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Assets.images.missonCardBackground.image(
                            height: cardHeight * 0.7,
                            width: cardWeight - Sizes.s8 * 4,
                            fit: BoxFit.cover,
                            opacity: const AlwaysStoppedAnimation(0.5),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            height: cardHeight * 0.7,
                            width: cardWeight - Sizes.s8 * 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.primary.withOpacity(0.8)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: cardHeight * 0.7,
                      child: Column(
                        children: [
                          AppSpacing.gapH8,
                          CachedNetworkImage(
                            imageUrl: manaMission.userMission?.image ?? '',
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
                            errorWidget: (_, __, ___) => Assets.icons.image.svg(
                              width: 60,
                              height: 60,
                              color: AppColors.negative,
                            ),
                          ),
                          AppSpacing.gapH4,
                          Expanded(
                            child: Obx(() => AutoSizeText(
                                  '',
                                  style: AppTextStyles.s12w600
                                      .copyWith(color: AppColors.text2),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ),
                          AppSpacing.gapH4,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  manaMission.isComplete()
                                      ? context.l10n.mana_mission__complete
                                      : '${manaMission.userMission?.reward ?? 0} Neutron',
                                  style: AppTextStyles.s14w600.text2Color,
                                ),
                                Text(
                                  '${manaMission.progress?.accomplished ?? 0}/${manaMission.progress?.total ?? 0}',
                                  style: AppTextStyles.s14w600.text2Color,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                if (!isDone)
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(999)),
                    child: Center(
                      child: Text(
                        context.l10n.profile__misson_card_do_now,
                        style: AppTextStyles.s12w600.text2Color,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (isDone) ...[
            Container(
              height: cardHeight - Sizes.s8 * 2,
              width: cardWeight - Sizes.s8 * 2,
              decoration: BoxDecoration(
                color: AppColors.blue1.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: Sizes.s20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: DoneMissonIconWidget(),
                  ),
                  AppSpacing.gapW4,
                  Text(
                    context.l10n.button__done,
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.green1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    ).clickable(() {
      if (isDone) return;
      // Navigate to chat
      Get.find<HomeController>().changeTab = 2;
    });
  }
}
