import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resource/resource.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    required this.values,
    required this.currentValue,
    super.key,
    this.padding,
    this.textStyle,
    this.buttonPadding,
    this.onChange,
  }) : assert(values.length == 2);
  final String currentValue;
  final List<String> values;
  final Function(String value)? onChange;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? buttonPadding;

  @override
  Widget build(BuildContext context) {
    final finalBorderRadius = BorderRadius.circular(Sizes.s128);
    const linearColors = AppColors.button2;

    final itemFirst = Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
      child: Padding(
        padding: buttonPadding ?? AppSpacing.edgeInsetsV4H8,
        child: SizedBox(
          child: Text(
            values.first.toString(),
            style: textStyle ?? AppTextStyles.s14w500,
          ),
        ),
      ),
    );

    final itemSecond = Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
      child: Padding(
        padding: buttonPadding ?? AppSpacing.edgeInsetsV4H8,
        child: Text(
          values[1].toString(),
          style: textStyle ?? AppTextStyles.s14w500,
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        final index = values.indexOf(currentValue);
        onChange?.call(values[(index + 1) % 2]);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: AppColors.label45.withOpacity(0.58),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    itemFirst,
                    itemSecond,
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  alignment: currentValue == values.first
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 1.0],
                        colors: linearColors,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 2.3,
                        ),
                      ],
                      borderRadius: finalBorderRadius,
                    ),
                    padding: padding ??
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
                    child: Padding(
                      padding: buttonPadding ?? AppSpacing.edgeInsetsV4H8,
                      child: Text(
                        values[1].toString(),
                        style: (textStyle ?? AppTextStyles.s14w500).copyWith(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: padding ??
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
                      child: Padding(
                        padding: buttonPadding ?? AppSpacing.edgeInsetsV4H8,
                        child: SizedBox(
                          child: Text(
                            values.first.toString(),
                            style: textStyle ?? AppTextStyles.s14w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: padding ??
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
                      child: Padding(
                        padding: buttonPadding ?? AppSpacing.edgeInsetsV4H8,
                        child: Text(
                          values[1].toString(),
                          style: textStyle ?? AppTextStyles.s14w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
