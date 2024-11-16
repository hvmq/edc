import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';

class BottomSheetSearchMessage extends StatefulWidget {
  const BottomSheetSearchMessage({super.key});

  @override
  State<BottomSheetSearchMessage> createState() =>
      _BottomSheetSearchMessageState();
}

class _BottomSheetSearchMessageState extends State<BottomSheetSearchMessage> {
  Widget _buildAppbar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: AppIcon(icon: AppIcons.arrowLeft)),
          Text(
            Get.context!.l10n.title_search_chat,
            style: AppTextStyles.s20w700,
          ),
          const SizedBox(
            width: Sizes.s32,
          ),
        ],
      );

  Widget _buildTextFieldSearch() => TextFormField(
        onChanged: (value) {
          // setState(() {
          //   filter = value;
          // });
        },
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: context.l10n.global__search,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15),
            child: AppIcon(
              icon: AppIcons.searchLg,
              color: AppColors.button5,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border2, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border2, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border2, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.button5, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border2, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          contentPadding: EdgeInsets.zero,
        ),
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
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Sizes.s20,
              left: Sizes.s20,
              right: Sizes.s20,
            ),
            child: Column(
              children: [
                _buildAppbar(),
                AppSpacing.gapH20,
                _buildTextFieldSearch(),
              ],
            ),
          ),
          _buildListUser(),
        ],
      ),
    );
  }
}
