import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';

class BottomSheetCreateMessage extends StatefulWidget {
  const BottomSheetCreateMessage({super.key});

  @override
  State<BottomSheetCreateMessage> createState() =>
      _BottomSheetCreateMessageState();
}

class _BottomSheetCreateMessageState extends State<BottomSheetCreateMessage> {
  Widget _buildAppbar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              Get.context!.l10n.button__cancel,
              style: AppTextStyles.s16w500.copyWith(color: AppColors.button6),
            ),
          ),
          Text(
            Get.context!.l10n.new_mess_title,
            style: AppTextStyles.s20w700,
          ),
          const SizedBox(
            width: Sizes.s32,
          ),
        ],
      );

  Widget _buildTextField() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: AppColors.border2,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            AppIcon(
              icon: AppIcons.create,
              color: AppColors.button5,
            ),
            AppSpacing.gapW8,
            Text(
              Get.context!.l10n.text_to,
              style: AppTextStyles.s16w500,
            ),
            AppSpacing.gapW4,
            const Expanded(
              child: TextField(
                // controller: _controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white30),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  // _controller.clear();
                });
              },
            ),
          ],
        ),
      );

  Widget _buildTextSuggestion() => Text(
        Get.context!.l10n.text_suggestion,
        style: AppTextStyles.s16w600.copyWith(color: AppColors.border2),
      );

  Widget _buildListUser() => Expanded(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: Sizes.s16),
              child: Column(
                children: [
                  const ListTile(
                    leading: AppCircleAvatar(
                      size: Sizes.s52,
                      url:
                          'https://lh3.googleusercontent.com/ZvbTH3mz6XJAaUIKbQ2BnEz66R0NoWogcictifHmWr43rf6Sz9xDYdQazcnb7JuyVddbT3Fv_bvO31mtSMD1U-uLl95v2M6RBEoypOJ9_CqdT6kN=w960-rj-nu-e365',
                    ),
                    title: Text(
                      'Han So Hee',
                      style: AppTextStyles.s16Base,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 74.w),
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
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Sizes.s20,
              left: Sizes.s20,
              right: Sizes.s20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppbar(),
                AppSpacing.gapH20,
                _buildTextField(),
                AppSpacing.gapH20,
                _buildTextSuggestion(),
              ],
            ),
          ),
          _buildListUser(),
        ],
      ),
    );
  }
}
