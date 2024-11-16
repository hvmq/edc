import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/styles/app_colors.dart';
import '../../../../resource/styles/gaps.dart';
import '../../../../resource/styles/text_styles.dart';

class BlogDetailView extends StatelessWidget {
  const BlogDetailView({required this.blog, super.key});
  final dynamic blog;

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBar: CommonAppBar(
          titleType: AppBarTitle.text,
          // text: context.l10n.button__sign_up,
          text: context.l10n.blog__blog_detail,
          titleTextStyle: AppTextStyles.s20w600.text5Color,
          leadingIconColor: AppColors.button5,
        ),
        body: Padding(
          padding: AppSpacing.edgeInsetsV20,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: AppSpacing.edgeInsetsH20,
                  child: Text(
                    blog['title'],
                    style: AppTextStyles.s28w700,
                  ),
                ),
                const SizedBox(height: 32),
                Image.network(
                  blog['image'],
                  fit: BoxFit.cover,
                  width: Get.width,
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: AppSpacing.edgeInsetsH20,
                  child: Text(
                    blog['content'],
                    style: AppTextStyles.s14Base,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
