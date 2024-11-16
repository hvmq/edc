import 'dart:async';

import 'package:flutter/material.dart';

import '../resource/resource.dart';
import 'all.dart';

enum AppButtonType { primary, secondary }

class AppButton extends StatefulWidget {
  const AppButton.primary(
      {super.key,
      this.label,
      this.icon,
      this.onPressed,
      this.width,
      this.height,
      this.borderRadius,
      this.isLoading = false,
      this.padding,
      this.isDisabled = false,
      this.textStyleLabel,
      this.color,
      this.boderColor,
      this.isAnimation = true})
      : type = AppButtonType.primary,
        assert(
          label != null || icon != null,
          'Label or icon must be provided.',
        );
  const AppButton.secondary(
      {super.key,
      this.label,
      this.icon,
      this.onPressed,
      this.width,
      this.height,
      this.borderRadius,
      this.isLoading = false,
      this.padding,
      this.isDisabled = false,
      this.textStyleLabel,
      this.color,
      this.boderColor,
      this.isAnimation = true})
      : type = AppButtonType.secondary,
        assert(
          label != null || icon != null,
          'Label or icon must be provided.',
        );

  final String? label;
  final Widget? icon;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isLoading;
  final EdgeInsets? padding;
  final AppButtonType type;
  final bool isDisabled;
  final TextStyle? textStyleLabel;
  final Color? color;
  final Color? boderColor;
  final bool isAnimation;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    if (widget.type == AppButtonType.secondary) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
      );

      _animation = Tween<double>(begin: -1, end: 2.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));

      _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
        _controller.forward(from: 0.0);
      });
    }
  }

  @override
  void dispose() {
    if (widget.type == AppButtonType.secondary) {
      _controller.dispose();
      _timer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textColor = AppColors.white;
    const textColorNull = AppColors.button5;
    final textColorDisable = AppColors.text1.withOpacity(0.3);

    final textStyles = AppTextStyles.s18w600.copyWith(
      color: widget.isDisabled
          ? textColorDisable
          : widget.color == null
              ? textColorNull
              : textColor,
      height: 1.2,
    );

    final child = widget.isLoading
        ? _buildLoading(textColor)
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null)
                SizedBox.square(dimension: Sizes.s20, child: widget.icon),
              if (widget.icon != null && widget.label != null) AppSpacing.gapW4,
              if (widget.label != null)
                Text(
                  widget.label!,
                  textAlign: TextAlign.center,
                  style: widget.textStyleLabel ?? textStyles,
                ),
            ],
          );

    final finalBorderRadius =
        BorderRadius.circular(widget.borderRadius ?? Sizes.s128);
    final finalPadding = widget.padding ?? AppSpacing.edgeInsetsAll16;

    final linearColors = widget.isDisabled
        ? AppColors.button4.map((e) => e.withOpacity(0.58)).toList()
        : AppColors.button2;

    final button = widget.type == AppButtonType.primary
        ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 1.0],
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                textStyle: textStyles,
                shape: RoundedRectangleBorder(borderRadius: finalBorderRadius),
                padding: finalPadding,
              ),
              onPressed: widget.isDisabled ? null : widget.onPressed,
              child: child,
            ),
          )
        : GestureDetector(
            onTap: widget.isDisabled ? null : widget.onPressed,
            child: SizedBox(
              child: Stack(
                children: [
                  Container(
                    width: widget.width,
                    padding: finalPadding,
                    decoration: BoxDecoration(
                      color: widget.color == null
                          ? Colors.white
                          : widget.isDisabled
                              ? AppColors.disable
                              : widget.color!,
                      border: Border.all(
                        color: widget.isDisabled
                            ? AppColors.disable
                            : widget.color ??
                                widget.boderColor ??
                                AppColors.button5,
                      ),
                      borderRadius: finalBorderRadius,
                    ),
                    child: child,
                  ),
                  if (widget.color != null &&
                      widget.isDisabled == false &&
                      widget.isAnimation)
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return FractionalTranslation(
                            translation: Offset(_animation.value, 0),
                            child: child,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.0),
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.3),
                              ],
                              stops: const [0.0, 0.5, 1.0, 1.5],
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: button,
    );
  }

  Widget _buildLoading(Color color) {
    return AppDefaultLoading(
      size: Sizes.s20,
      color: color,
    );
  }
}
