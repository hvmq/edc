import 'package:flutter/material.dart';

import '../../../../../../core/all.dart';
import '../../../../../resource/resource.dart';
import 'setting_item.dart';

class SettingItem {
  final Object? icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;

  SettingItem({
    required this.title,
    this.icon,
    this.onTap,
    this.trailing,
  });
}

class SettingGroupWidget extends StatelessWidget {
  final String groupName;
  final List<SettingItem> children;

  const SettingGroupWidget({
    required this.groupName,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return AppSpacing.emptyBox;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(groupName, style: AppTextStyles.s16w600.text5Color),
        AppSpacing.gapH8,
        Container(
          padding: AppSpacing.edgeInsetsAll12,
          decoration: BoxDecoration(
            borderRadius: AppRadius.borderRadius12,
            color: AppColors.white,
            border: Border.all(color: AppColors.border2, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children.map(
              (item) {
                final isLast = children.indexOf(item) == children.length - 1;

                return SettingItemWidget(
                  icon: item.icon,
                  title: item.title,
                  onTap: item.onTap,
                  trailing: item.trailing,
                  isShowDivider: !isLast,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
