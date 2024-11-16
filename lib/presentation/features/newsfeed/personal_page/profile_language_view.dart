import 'dart:developer';

import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../../models/user.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/gen/assets.gen.dart';
import '../../../resource/styles/styles.dart';
import 'personal_page_controller.dart';

class ProfileLanguageView extends StatefulWidget {
  const ProfileLanguageView(
      {required this.personalPageController,
      required this.languageCode,
      required this.idUser,
      required this.type,
      this.email,
      this.currentUser,
      super.key});
  final PersonalPageController personalPageController;
  final String languageCode;
  final int idUser;
  final String type;
  final String? email;
  final User? currentUser;
  @override
  State<ProfileLanguageView> createState() => _ProfileLanguageViewState();
}

class _ProfileLanguageViewState extends State<ProfileLanguageView> {
  bool isEnableJoinMeeting = false;
  bool isEnableCamera = false;
  bool isEnableNoAudio = false;
  bool isEnableRecordMeeting = false;

  int selectedIndex = 0;
  bool isLoading = false;

  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        // text: context.l10n.button__sign_up,
        text: context.l10n.language__language,
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              // optionWidget(),
              // AppSpacing.gapH28,
              chooseLanguageWidget(),
              SizedBox(height: Get.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget optionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Translate Messages',
          style: AppTextStyles.s16w600.copyWith(color: AppColors.text8),
        ),
        AppSpacing.gapH28,
        Container(
          padding: AppSpacing.edgeInsetsAll20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11), color: Colors.white),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Translate entire chats',
                    style: AppTextStyles.s16w500,
                  ),
                  CupertinoSwitch(
                      activeColor: AppColors.button5,
                      trackColor: AppColors.subText3,
                      value: isEnableCamera,
                      onChanged: (value) {
                        setState(() {
                          isEnableCamera = value;
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget chooseLanguageWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.setting__select_language,
          style: AppTextStyles.s18w600.copyWith(color: AppColors.text8),
        ),
        AppSpacing.gapH28,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11), color: Colors.white),
          child: Column(
            children: [
              ...languages.take(5).toList().map((lanItem) {
                final index = languages.indexOf(lanItem);
                return Column(children: [
                  Row(
                    children: [
                      CircleFlag(size: 30, languages[index]['flagCode'] ?? ''),
                      AppSpacing.gapW12,
                      Text(
                        languages.take(5).toList()[index]['title'] ?? '',
                        style: AppTextStyles.s16w500
                            .copyWith(color: AppColors.button5),
                      ),
                      const Spacer(),
                      (index == currentIndex)
                          ? const Icon(Icons.done, color: AppColors.button5)
                          : const SizedBox(),
                    ],
                  ).clickable(() async {
                    if (isLoading == true) return;
                    isLoading = true;

                    setState(() {
                      selectedIndex = index;
                    });
                    try {
                      setState(() {
                        currentIndex = index;
                      });
                    } catch (e) {
                      log(e.toString());
                    } finally {
                      isLoading = false;
                    }
                  }),
                  AppSpacing.gapH16,
                  if (index != languages.length - 1) ...[
                    const AppDivider(height: 1, color: Color(0xff97B9DE)),
                    AppSpacing.gapH16,
                  ],
                ]);
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class LanguageItem {
  String name;
  SvgGenImage icon;

  LanguageItem({required this.name, required this.icon});
}
