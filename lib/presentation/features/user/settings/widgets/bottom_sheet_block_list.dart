import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../../all.dart';
import '../setting_controller.dart';

class BottomSheetBlocklist extends StatelessWidget {
  final SettingController controller;
  const BottomSheetBlocklist({required this.controller, super.key});

  Widget _buildAppbar() => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GestureDetector(
            //   onTap: () => Get.back(),
            //   child: Text(
            //     Get.context!.l10n.button__done,
            //     style: AppTextStyles.s16w500.copyWith(color: AppColors.button6),
            //   ),
            // ),
            Text(
              Get.context!.l10n.button_block_list,
              style: AppTextStyles.s20w700,
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Text(
            //     Get.context!.l10n.button_select_all,
            //     style: AppTextStyles.s16w500.copyWith(color: AppColors.button6),
            //   ),
            // ),
          ],
        ),
      );

  Widget _buildBodyEmpty() => Expanded(
        child: Center(
          child: Text(
            Get.context!.l10n.text_empty,
            style: AppTextStyles.s18Base.copyWith(color: AppColors.text5),
          ),
        ),
      );

  Widget _buildBlockList() => Expanded(
          child: Obx(
        () => ListView.builder(
          itemCount: controller.userInfoList.length,
          itemBuilder: (context, index) {
            final user = controller.userInfoList[index];
            return Padding(
              padding: const EdgeInsets.only(top: Sizes.s16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: AppCircleAvatar(
                            url: user['avatar_path'],
                          ),
                          title: Text(
                            '${user['first_name']} ${user['last_name']}',
                            style: AppTextStyles.s16Base,
                          ),
                          // subtitle: Text(
                          //   'Hey John! Heard of this freelancer Alex? Thinking of hiring him for my project.',
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 1,
                          //   style: AppTextStyles.s14Base
                          //       .copyWith(color: AppColors.text5),
                          // ),
                          trailing: IconButton(
                              onPressed: () {
                                controller.confirmUnBlockUser(
                                    int.parse(user['id']), index);
                              },
                              icon: AppIcon(
                                icon: AppIcons.block,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Sizes.s48.h),
                    child: const Divider(
                      color: AppColors.border2,
                      thickness: 0.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppbar(),
          AppSpacing.gapH20,
          controller.userInfoList.isEmpty
              ? _buildBodyEmpty()
              : _buildBlockList(),
        ],
      ),
    );
  }
}
