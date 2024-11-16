import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../../models/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import '../../../routing/routers/app_pages.dart';
import 'all.dart';
import 'widgets/contact_info_detail.dart';

class ContactAppBar extends CommonAppBar {
  ContactAppBar({super.key});

  void _onSearchPressed() {
    Get.toNamed(Routes.search);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(
      init: ContactController(),
      builder: (controller) {
        return CommonAppBar(
          automaticallyImplyLeading: false,
          text: context.l10n.contact__list,
          titleType: AppBarTitle.text,
          centerTitle: false,
          titleTextStyle: AppTextStyles.s16w500,
          actions: [
            // AnimatedBuilder(
            //   animation: controller.animationController,
            //   builder: (context, child) {
            //     return Transform.rotate(
            //       angle: controller.animationController.value * 2 * math.pi,
            //       child: AppIcon(
            //         icon: Icons.refresh_outlined,
            //         color: Colors.white,
            //         padding: AppSpacing.edgeInsetsAll12.copyWith(right: 8),
            //         onTap: () {
            //           if (!controller.isDisabledBtnSync.value) {
            //             controller.animationController.repeat();
            //             controller.reSyncContactLocal();
            //           }
            //         },
            //       ),
            //     );
            //   },
            // ),
            // AppIcon(
            //   icon: AppIcons.addTab,
            //   onTap: () async {
            //     controller.changeIsEditContact = true;
            //     final UserContact user = UserContact(
            //       contactFirstName: '',
            //       contactLastName: '',
            //       contactPhoneNumber: '',
            //     );

            //     _onInfoPressed(user: user, controller: controller);
            //   },
            // ),
            AppIcon(
              padding:
                  AppSpacing.edgeInsetsAll12.copyWith(right: 0, left: Sizes.s8),
              icon: AppIcons.search,
              onTap: _onSearchPressed,
            ),
          ],
        );
      },
    );
  }

  void _onInfoPressed({
    required UserContact user,
    required ContactController controller,
  }) {
    Get.bottomSheet(
      SizedBox(
        height: 0.6.sh,
        child: ContactInfoDetail(
          user: user,
          isAddContact: true,
        ),
      ),
      isScrollControlled: true,
    ).then((value) {
      controller.isoCode.value = '';
      controller.phoneEdit.value = '';
      controller.avatarUrl.value = '';
      controller.inputEnterPhoneController.clear();
      controller.changeIsEditContact = false;
      controller.isAvatarLocal.value = false;
    });
  }
}
