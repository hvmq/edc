import 'package:flutter/material.dart';

class AppDisableWidget extends StatelessWidget {
  final Widget child;
  final bool isDisable;

  const AppDisableWidget({required this.child, Key? key, this.isDisable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisable,
      child: Opacity(
        opacity: isDisable ? 0.5 : 1,
        child: child,
      ),
    );
  }
}
