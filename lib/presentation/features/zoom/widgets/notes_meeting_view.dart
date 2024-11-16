import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../base/base_view.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import '../zoom_home_controller.dart';
import 'add_note.dart';
import 'note_detail.dart';
import 'note_item.dart';

class NotesMeetingView extends BaseView<ZoomHomeController> {
  const NotesMeetingView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
        backgroundColor: const Color(0xffF2F3F9),
        appBar: CommonAppBar(
          titleType: AppBarTitle.text,
          text: l10n.zoom__notes,
          titleTextStyle: AppTextStyles.s20w600.text5Color,
          leadingIconColor: AppColors.button5,
          actions: [
            AppIcon(
              icon: AppIcons.create,
              color: AppColors.button5,
              size: 32,
              onTap: () {
                showGeneralDialog(
                    barrierLabel: 'Barrier',
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionDuration: const Duration(milliseconds: 400),
                    context: context,
                    pageBuilder: (_, __, ___) {
                      return const AddTaskClassic(
                        type: 'add',
                      );
                    },
                    transitionBuilder: (_, anim, __, child) {
                      Tween<Offset> tween;

                      // if (anim.status == AnimationStatus.reverse) {
                      //   tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
                      // } else {
                      //   tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
                      // }

                      tween =
                          Tween(begin: const Offset(0, 1), end: Offset.zero);

                      return SlideTransition(
                        position: tween.animate(
                          CurvedAnimation(
                              parent: anim, curve: Curves.easeInOut),
                        ),
                        //mờ
                        // child: FadeTransition(
                        //   opacity: anim,
                        //   child: child,
                        // ),
                        child: child,
                      );
                    });
              },
            )
          ],
        ),
        body: Padding(
          padding: AppSpacing.edgeInsetsH20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.zoom__all_tasks,
                style: AppTextStyles.s20w600.text5Color,
              ),
              AppSpacing.gapH12,
              Expanded(
                  child: Obx(() => ListView.builder(
                      itemCount: controller.meetingNoteList.length,
                      itemBuilder: (context, index) => ListItemWidget(
                            index: index,
                            note: controller.meetingNoteList[index],
                            onClicked: () {
                              Get.to(() => NoteDetail(
                                    note: controller.meetingNoteList[index],
                                  ));
                            },
                          ))))
            ],
          ),
        ));
  }
}
