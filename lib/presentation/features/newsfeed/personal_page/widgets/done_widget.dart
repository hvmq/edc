import 'package:flutter/material.dart';

import '../../../../resource/resource.dart';

class DoneMissonIconWidget extends StatelessWidget {
  const DoneMissonIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: AppSpacing.edgeInsetsAll4,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.green1,
          ),
          child: Center(
            child: Container(
              padding: AppSpacing.edgeInsetsAll8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blue1,
              ),
            ),
          ),
        ),
        const Positioned(
          child: Icon(
            Icons.done,
            color: AppColors.green1,
            size: 20,
          ),
        ),
      ],
    );
  }
}

class NotDoneMissonIconWidget extends StatelessWidget {
  const NotDoneMissonIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: AppSpacing.edgeInsetsAll4,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.grey1,
          ),
          child: Center(
            child: Container(
              padding: AppSpacing.edgeInsetsAll8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blue2,
              ),
            ),
          ),
        ),
        Positioned(
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.grey1,
            ),
          ),
        ),
      ],
    );
  }
}
