import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';

class BottomSheetBlockList extends StatefulWidget {
  const BottomSheetBlockList({super.key});

  @override
  State<BottomSheetBlockList> createState() => _BottomSheetBlockListState();
}

class _BottomSheetBlockListState extends State<BottomSheetBlockList> {
  List<int> selects = [];
  Widget _buildAppbar() => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                Get.context!.l10n.button__done,
                style: AppTextStyles.s16w500.copyWith(color: AppColors.button6),
              ),
            ),
            Text(
              Get.context!.l10n.button_block_list,
              style: AppTextStyles.s20w700,
            ),
            GestureDetector(
              onTap: () {
                final List<int> newIndexes =
                    List.generate(10, (index) => index);
                selects.addAll(newIndexes);
                setState(() {});
              },
              child: Text(
                Get.context!.l10n.button_select_all,
                style: AppTextStyles.s16w500.copyWith(color: AppColors.button6),
              ),
            ),
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
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: Sizes.s16),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppCheckBox(
                        value: selects.contains(index),
                        onChanged: (value) {
                          if (value != null) {
                            if (value) {
                              selects.add(index);
                            } else {
                              selects.remove(index);
                            }
                          }
                          setState(() {});
                        },
                      ),
                      Expanded(
                        child: ListTile(
                          leading: const AppCircleAvatar(
                            size: Sizes.s52,
                            url:
                                'https://lh3.googleusercontent.com/ZvbTH3mz6XJAaUIKbQ2BnEz66R0NoWogcictifHmWr43rf6Sz9xDYdQazcnb7JuyVddbT3Fv_bvO31mtSMD1U-uLl95v2M6RBEoypOJ9_CqdT6kN=w960-rj-nu-e365',
                          ),
                          title: const Text(
                            'Han So Hee',
                            style: AppTextStyles.s16Base,
                          ),
                          subtitle: Text(
                            'Hey John! Heard of this freelancer Alex? Thinking of hiring him for my project.',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTextStyles.s14Base
                                .copyWith(color: AppColors.text5),
                          ),
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
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppbar(),
          AppSpacing.gapH20,
          _buildBlockList(),
        ],
      ),
    );
  }
}
