import 'package:flutter/widgets.dart';

import '../../../base/base_view.dart';
import '../../../resource/resource.dart';
import 'certificate_controller.dart';

class CertificateView extends BaseView<CertificateController> {
  const CertificateView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppSpacing.edgeInsetsAll20,
        child: Column(
          children: [
            for (int i = 0; i < 3; i++) ...[
              Assets.images.cerificateSample.image(),
              AppSpacing.gapH24,
            ],
          ],
        ),
      ),
    );
  }
}
