import 'package:flutter/material.dart';

import '../../../../../core/all.dart';
import '../../../../base/base_view.dart';
import '../../../../common_widgets/common_app_bar.dart';
import '../../../../common_widgets/common_scaffold.dart';
import '../../../../resource/resource.dart';
import 'document_detail_controller.dart';

class DocumentDetailView extends BaseView<DocumentDetailController> {
  const DocumentDetailView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    Widget contentWidget() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Intensive Blockchain course',
              style: AppTextStyles.s20w700,
            ),
            AppSpacing.gapH12,
            Text(
              '''orem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with:
“Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.”
The purpose of lorem ipsum is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn't distract from the layout. A practice not without controversy, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.
The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it's seen all around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum.''',
              style: AppTextStyles.s14w400,
            ),
          ],
        ),
      );
    }

    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      // appBar: AppBar(
      //   leading: AppIcon(
      //     padding: const EdgeInsets.only(left: Sizes.s20),
      //     icon: AppIcons.arrowLeft,
      //     color: AppColors.button5,

      //   ).clickable(() => Get.back),
      //     elevation: 10,
      //     backgroundColor: Colors.transparent,
      // ),
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        // text: context.l10n.button__sign_up,
        text: 'Document',
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
        backgroundColor: Colors.white,
        elevation: 100,
        actions: [
          Text(
            'Save',
            style: AppTextStyles.s16w400.text5Color,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              for (int i = 0; i < 10; i++) ...[
                contentWidget(),
                AppSpacing.gapH20,
              ]
            ],
          ),
        ),
      ),
    );
  }
}
