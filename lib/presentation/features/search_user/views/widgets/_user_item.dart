import 'package:flutter/material.dart';

import '../../../../../models/user.dart';
import '../../../../common_widgets/check_box_button.dart';
import '../../../../common_widgets/circle_avatar.dart';
import '../../../../resource/resource.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    required this.user,
    required this.onTap,
    this.isSelected = false,
    this.isSelectable = false,
    Key? key,
  }) : super(key: key);

  final User user;
  final VoidCallback onTap;
  final bool isSelectable;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      leading: AppCircleAvatar(
        url: user.avatarPath ?? '',
        size: Sizes.s48,
      ),
      onTap: onTap,
      title: Text(
        user.fullName,
        style: AppTextStyles.s16w400,
      ),
      trailing: isSelectable ? CheckBoxButton(isSelected: isSelected) : null,
    );
  }
}
