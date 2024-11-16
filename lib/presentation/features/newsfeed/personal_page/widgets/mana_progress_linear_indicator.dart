import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../resource/styles/app_colors.dart';
import '../../../../resource/styles/text_styles.dart';
import 'done_widget.dart';

class ManaProgressLinearIndicator extends StatefulWidget {
  const ManaProgressLinearIndicator({
    required this.currentValue,
    required this.limit,
    super.key,
  });
  final int currentValue;
  final int limit;

  @override
  State<ManaProgressLinearIndicator> createState() =>
      _ManaProgressLinearIndicatorState();
}

class _ManaProgressLinearIndicatorState
    extends State<ManaProgressLinearIndicator> {
  List<int> values = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int startValue = 0;
    final int distanceValue = widget.limit ~/ 5;
    while (true) {
      startValue += distanceValue;
      startValue = min(startValue, widget.limit);
      values.add(startValue);
      if (startValue >= widget.limit) {
        break;
      }
    }
    values = values.where((e) {
      return (e == widget.limit) || (widget.limit - e) >= distanceValue;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.center,
      children: [
        const SizedBox(
          // padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          width: double.infinity,
          height: 50,
        ),
        Container(
          // padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8 + 5, left: 8, right: 8),
          height: 20,
          color: AppColors.blue2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < values.length; i++) ...[
              if (widget.currentValue >= values[i])
                Column(
                  children: [
                    const SizedBox(
                        width: 40, height: 40, child: DoneMissonIconWidget()),
                    Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          values[i].toString(),
                          style: AppTextStyles.s18w600
                              .copyWith(
                                color: AppColors.grey2,
                              )
                              .copyWith(
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = AppColors.blue2,
                              ),
                        ),
                        // Solid text as fill.
                        Text(
                          values[i].toString(),
                          style: AppTextStyles.s18w600.copyWith(
                            color: AppColors.grey1,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              else
                Column(
                  children: [
                    const SizedBox(
                        width: 40,
                        height: 40,
                        child: NotDoneMissonIconWidget()),
                    Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          values[i].toString(),
                          style: AppTextStyles.s18w600
                              .copyWith(
                                color: AppColors.blue2,
                              )
                              .copyWith(
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = AppColors.blue2,
                              ),
                        ),
                        // Solid text as fill.
                        Text(values[i].toString(),
                            style: AppTextStyles.s18w600.copyWith(
                              color: AppColors.white,
                            )),
                      ],
                    )
                  ],
                ),
            ]
          ],
        )
      ],
    );
  }
}
