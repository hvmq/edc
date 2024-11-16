import 'package:flutter/material.dart';

import '../resource/styles/app_colors.dart';
import '../resource/styles/gaps.dart';

class CheckBoxButton extends StatelessWidget {
  final bool isSelected;
  final double size;

  const CheckBoxButton({
    required this.isSelected,
    this.size = Sizes.s24,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: isSelected ? const EdgeInsets.all(2) : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.s12),
        border: Border.all(
          color: isSelected ? AppColors.button5 : AppColors.text1,
          width: Sizes.s2,
        ),
      ),
      child: isSelected
          ? Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.button5),
            )
          : null,
    );
  }
}
