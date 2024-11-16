import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widgets/shimmer.dart';
import '../../../../resource/styles/styles.dart';

class ShimmerLoadingMission extends StatelessWidget {
  const ShimmerLoadingMission({super.key});

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 262.0;
    const double cardWeight = 180;

    Widget buildContainer(
            double height, double width, bool isCircle, double radius) =>
        Container(
          height: height,
          width: width,
          decoration: isCircle
              ? BoxDecoration(
                  shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                  color: AppColors.white,
                )
              : BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(radius)),
        );
    return Shimmer.fromColors(
        baseColor: AppColors.background6,
        highlightColor: AppColors.background6.withOpacity(0.5),
        child: SizedBox(
          height: 262.0,
          width: 180,
          // margin: const EdgeInsets.only(right: Sizes.s8),
          child: Stack(
              // alignment: Alignment.center,
              // clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    height: 262.0 - Sizes.s8 * 2,
                    width: 180 - Sizes.s8 * 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.background6,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: Sizes.s8.h,
                      horizontal: Sizes.s12.w,
                    ),
                    margin: EdgeInsets.zero,
                    child: Column(children: [
                      // buildContainer(50.w, 50.w, true, 100),
                      // AppSpacing.gapH8,
                      // buildContainer(20.w, 100.w, false, 20),
                      // AppSpacing.gapH8,
                      // buildContainer(20.w, 100.w, false, 20),
                      Stack(
                        children: [
                          Stack(
                            children: [
                              buildContainer(cardHeight * 0.7,
                                  cardWeight - Sizes.s8 * 4, false, 10),
                              Positioned(
                                child: buildContainer(cardHeight * 0.7,
                                    cardWeight - Sizes.s8 * 4, false, 10),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: cardHeight * 0.7,
                            child: Column(
                              children: [
                                AppSpacing.gapH8,
                                buildContainer(60, 60, true, 100),
                                AppSpacing.gapH4,
                                Expanded(
                                  child: buildContainer(60, 120, true, 10),
                                ),
                                AppSpacing.gapH4,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildContainer(
                                      20, double.infinity, true, 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      buildContainer(30, double.infinity, false, 999),
                    ]),
                  ),
                ),
              ]),
        ));
  }
}
