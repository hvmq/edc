import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/base_view.dart';
import '../../../../common_widgets/button.dart';
import '../../../../common_widgets/common_app_bar.dart';
import '../../../../common_widgets/common_scaffold.dart';
import '../../../../resource/resource.dart';
import '../document_detail/document_detail_view.dart';
import 'homework_controller.dart';

class HomeworkView extends BaseView<HomeworkController> {
  const HomeworkView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      // appBar: AppBar(
      //   leading: AppIcon(
      //     padding: const EdgeInsets.only(left: Sizes.s20),
      //     icon: AppIcons.arrowLeft,
      //     color: AppColors.button5,

      //   ).clickable(() => Get.back),
      //     elevation: 10,
      //     backgroundColor: Colors.transparent,
      // ),
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        // text: context.l10n.button__sign_up,
        text: 'Homework',
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
        backgroundColor: Colors.white,
        elevation: 100,
        actions: const [
          Icon(Icons.menu, color: AppColors.button5),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              for (int i = 0; i < 5; i++) ...[
                homeworkItem(),
                AppSpacing.gapH28,
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget homeworkItem() {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppSpacing.gapH32,
                    Text(
                      'Homework1 - Practice Blockchain',
                      style: AppTextStyles.s18w700,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                      style: AppTextStyles.s12w400,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          'Deadline:',
                          style: AppTextStyles.s12w600,
                        ),
                        Text(
                          ' 3 days',
                          style: AppTextStyles.s12w400,
                        ),
                      ],
                    ),
                    Text(
                      'Status: -',
                      style: AppTextStyles.s12w600,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.button5,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Document: Refer to the Blockchain project',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ).clickable(() {
                  Get.to(() => const DocumentDetailView());
                }),
              ),
              Positioned(
                top: 0,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.button5,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  child: Text('--',
                      style:
                          AppTextStyles.s12w700.copyWith(color: Colors.white)),
                ).clickable(() {
                  Get.to(() => const DocumentDetailView());
                }),
              )
            ],
          ),
          AppSpacing.gapH12,
          AppButton.secondary(
            padding: AppSpacing.edgeInsetsAll12,
            onPressed: () {},
            width: double.infinity,
            label: 'Done',
            color: const Color(0xff52C91D),
            textStyleLabel: AppTextStyles.s18w500.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
