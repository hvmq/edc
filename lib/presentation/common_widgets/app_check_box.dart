import 'package:flutter/material.dart';

import '../resource/resource.dart';

class AppCheckBox extends StatefulWidget {
  final bool value;
  final Function(bool?)? onChanged;
  const AppCheckBox({required this.value, super.key, this.onChanged});

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.value,
      onChanged: (value) {
        widget.onChanged!(value);
      },
      side: const BorderSide(color: AppColors.border2),
      checkColor: AppColors.text2,
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.text1;
          }

          return Colors.transparent;
        },
      ),
    );
  }
}
