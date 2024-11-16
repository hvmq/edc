import 'package:flutter/material.dart';

import '../../core/extensions/all.dart';
import '../../core/utils/view_util.dart';
import '../resource/resource.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    required this.body,
    Key? key,
    this.appBar,
    this.backgroundColor,
    this.hideKeyboardWhenTouchOutside = false,
    this.applyAutoPaddingBottom = false,
    this.bottomNavigationBar,
    this.backgroundLayer = false,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Color? backgroundColor;
  final bool hideKeyboardWhenTouchOutside;
  final bool applyAutoPaddingBottom;
  final Widget? bottomNavigationBar;
  final bool backgroundLayer;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background16,
      appBar: appBar,
      body: backgroundLayer
          ? Stack(
              children: [_buildBackgroud(), body],
            )
          : Padding(
              padding: _getBottomPadding(context),
              child: body,
            ),
      bottomNavigationBar: bottomNavigationBar,
    );

    return hideKeyboardWhenTouchOutside
        ? GestureDetector(
            onTap: () => ViewUtil.hideKeyboard(context),
            child: scaffold,
          )
        : scaffold;
  }

  EdgeInsetsGeometry _getBottomPadding(BuildContext context) {
    if (!applyAutoPaddingBottom) {
      return EdgeInsets.zero;
    }

    var bottomPadding = context.bottomPadding;
    if (context.bottomViewInsets == 0) {
      bottomPadding = Sizes.s16;
    }

    return const EdgeInsets.only();
  }

  Widget _buildBackgroud() => Align(
        // alignment: Alignment.bottomCenter,
        child: Assets.images.layerBackground1
            .image(width: double.infinity, fit: BoxFit.cover),
      );
}
