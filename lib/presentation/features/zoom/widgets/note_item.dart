import 'package:flutter/material.dart';

import '../../../../core/all.dart';
import '../../../../models/note.dart';
import '../../../resource/resource.dart';

class ListItemWidget extends StatelessWidget {
  final int index;
  final Note note;
  final VoidCallback onClicked;
  const ListItemWidget(
      {required this.index,
      required this.onClicked,
      required this.note,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClicked();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: AppTextStyles.s16w700,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              note.description ?? '',
              style: AppTextStyles.s14w500.subText2Color,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
