import 'package:flutter/material.dart';

import '../../../../core/all.dart';
import '../../../../models/note.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import 'add_note.dart';

class NoteDetail extends StatefulWidget {
  final Note note;
  const NoteDetail({required this.note, super.key});

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBar: CommonAppBar(
          titleType: AppBarTitle.none,
          titleTextStyle: AppTextStyles.s20w600.text5Color,
          leadingIconColor: AppColors.button5,
          actions: [
            AppIcon(
              icon: AppIcons.edit,
              color: AppColors.button5,
              size: 20,
            ).clickable(() {
              showGeneralDialog(
                  barrierLabel: 'Barrier',
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: const Duration(milliseconds: 400),
                  context: context,
                  pageBuilder: (_, __, ___) {
                    return AddTaskClassic(
                      type: 'edit',
                      note: widget.note,
                    );
                  },
                  transitionBuilder: (_, anim, __, child) {
                    Tween<Offset> tween;

                    // if (anim.status == AnimationStatus.reverse) {
                    //   tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
                    // } else {
                    //   tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
                    // }

                    tween = Tween(begin: const Offset(0, 1), end: Offset.zero);

                    return SlideTransition(
                      position: tween.animate(
                        CurvedAnimation(parent: anim, curve: Curves.easeInOut),
                      ),
                      //mờ
                      // child: FadeTransition(
                      //   opacity: anim,
                      //   child: child,
                      // ),
                      child: child,
                    );
                  });
            })
          ],
        ),
        body: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.note.title,
                style: AppTextStyles.s24w700,
              ),
              AppSpacing.gapH4,
              Text(
                widget.note.description ?? '',
                style: AppTextStyles.s16w400,
              ),
            ],
          ),
        ));
  }
}
