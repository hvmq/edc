part of '../conversation_details_view.dart';

class _LinkTabView extends StatelessWidget {
  const _LinkTabView({
    required this.controller,
  });

  final ConversationDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            if (controller.links.isEmpty)
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: Sizes.s32,
                  ),
                  child: Text(
                    context.l10n.conversation_resources__no_links,
                    style: AppTextStyles.s16w500,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (controller.links.isNotEmpty)
              SliverList.separated(
                itemCount: controller.links.length,
                itemBuilder: (context, index) {
                  final link = controller.links[index];

                  return AnyLinkPreview(
                    link: link,
                    cache: const Duration(days: 5),
                    bodyMaxLines: 5,
                    backgroundColor: Colors.white,
                    titleStyle: AppTextStyles.s16w600.text2Color,
                    bodyStyle: AppTextStyles.s12w400.subText2Color,
                  );
                },
                separatorBuilder: (context, index) => AppSpacing.gapH16,
              ),
          ],
        );
      },
    );
  }
}
