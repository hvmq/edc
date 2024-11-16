import 'dart:ui';

import 'package:flutter/material.dart';

import '../resource/resource.dart';

class AppBlurryContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final double blur;
  final BoxShape boxShape;
  final Color? color;

  const AppBlurryContainer({
    required this.child,
    super.key,
    this.padding = AppSpacing.edgeInsetsAll16,
    this.blur = 8.0,
    this.margin = EdgeInsets.zero,
    this.borderRadius = Sizes.s16,
    this.boxShape = BoxShape.rectangle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: boxShape == BoxShape.circle
          ? BorderRadius.zero
          : BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            shape: boxShape,
            borderRadius: boxShape == BoxShape.circle
                ? null
                : BorderRadius.circular(borderRadius),
            color: color ?? AppColors.opacityBackground,
          ),
          child: child,
        ),
      ),
    );
  }
}
