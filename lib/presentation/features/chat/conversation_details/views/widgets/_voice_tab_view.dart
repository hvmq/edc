part of '../conversation_details_view.dart';

class _VoiceTabView extends StatelessWidget {
  const _VoiceTabView({
    required this.controller,
  });

  final ConversationDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScrollView(
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          if (controller.audios.isEmpty)
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(
                  top: Sizes.s32,
                ),
                child: Text(
                  context.l10n.conversation_resources__no_voice,
                  style: AppTextStyles.s16w500,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (controller.audios.isNotEmpty)
            SliverList.separated(
              itemCount: controller.audios.length,
              separatorBuilder: (context, index) => AppSpacing.gapH16,
              itemBuilder: (context, index) {
                final audioUrl = controller.audios[index];

                return Align(
                  alignment: Alignment.centerLeft,
                  child: VoiceMessageView(
                    backgroundColor: AppColors.label1Color,
                    activeSliderColor: AppColors.text4,
                    circlesColor: AppColors.primary,
                    // notActiveSliderColor: Colors.transparent,
                    controller: VoiceController(
                      audioSrc: audioUrl,
                      isFile: false,
                      maxDuration: const Duration(seconds: 10),
                      onComplete: () {},
                      onPause: () {},
                      onPlaying: () {},
                      onError: (err) {},
                    ),
                  ),
                );
              },
            ),
        ],
      );
    });
  }
}
