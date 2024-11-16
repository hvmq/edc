import 'package:flutter/material.dart';

import '../../../../../core/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/styles/app_colors.dart';
import '../../../../resource/styles/gaps.dart';
import '../../../../resource/styles/text_styles.dart';
import '../setting_controller.dart';

class DeleteAccountView extends StatefulWidget {
  SettingController controller;
  DeleteAccountView({required this.controller, super.key});

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBar: CommonAppBar(
          titleType: AppBarTitle.none,
          titleWidget: Text(
            context.l10n.setting__delete_account,
            style: AppTextStyles.s16w600,
          ),
          centerTitle: false,
          titleTextStyle: AppTextStyles.s16w600,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: widget.controller.formKey,
            child: Column(
              children: [
                AppTextField(
                  controller: widget.controller.deleteController,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return widget.controller.l10n.field__delete_account_empty;
                    }

                    return null;
                  },
                  fillColor:
                      AppColors.backgroundTextFieldDelete.withOpacity(0.3),
                  hintStyle: AppTextStyles.s14w400
                      .copyWith(color: AppColors.subTextConversationItem),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: context.l10n.delete_account__type_here,
                ),
                const SizedBox(height: Sizes.s24),
                Text.rich(
                  TextSpan(
                      text: '${context.l10n.delete_account__hint_1} "',
                      style: AppTextStyles.s14w400.copyWith(
                        color: AppColors.subText3,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Delete',
                          style: AppTextStyles.s14w400.copyWith(
                            color: AppColors.negative,
                          ),
                        ),
                        TextSpan(
                          text: '" ${context.l10n.delete_account__hint_2}',
                          style: AppTextStyles.s14w400.copyWith(
                            color: AppColors.subText3,
                          ),
                        )
                      ]),
                ),
                const SizedBox(height: Sizes.s24),
                AppButton.secondary(
                  color: AppColors.negative,
                  isAnimation: false,
                  label: widget.controller.l10n.button__delete,
                  textStyleLabel:
                      AppTextStyles.s16w400.copyWith(color: AppColors.text2),
                  width: double.infinity,
                  onPressed: () async {
                    if (!widget.controller.isLoadingBtnDeleteAccount.value) {
                      await widget.controller.deleteAccount();
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
