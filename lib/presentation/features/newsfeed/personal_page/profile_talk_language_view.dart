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

class ProfileTalkLanguageView extends StatefulWidget {
  const ProfileTalkLanguageView(
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
  State<ProfileTalkLanguageView> createState() =>
      _ProfileTalkLanguageViewState();
}

class _ProfileTalkLanguageViewState extends State<ProfileTalkLanguageView> {
  bool isEnableJoinMeeting = false;
  bool isEnableCamera = false;
  bool isEnableNoAudio = false;
  bool isEnableRecordMeeting = false;

  int selectedIndex = 0;
  bool isLoading = false;

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredLanguages = [];

  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    filteredLanguages = languages; // Khởi tạo danh sách ban đầu
    _searchController
        .addListener(_filterLanguages); // Lắng nghe thay đổi tìm kiếm
  }

  void _filterLanguages() {
    setState(() {
      filteredLanguages = languages
          .where((language) => language['title']!
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // Giải phóng bộ nhớ khi không sử dụng nữa
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        // text: context.l10n.button__sign_up,
        text: context.l10n.personal_page__talk_language,
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              // Thêm thanh tìm kiếm
              AppTextField(
                controller: _searchController,
                hintText: context.l10n.global__search,
                fillColor: const Color(0xffebf1f3),
                hintStyle: AppTextStyles.s16w400.subText2Color.italic,
                prefixIcon: AppIcon(
                  icon: AppIcons.search,
                  color: AppColors.subText2,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              // optionWidget(),
              AppSpacing.gapH28,
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
              ...filteredLanguages.map((lanItem) {
                final index = filteredLanguages.indexOf(lanItem);
                return Column(children: [
                  Obx(() {
                    var currentLanguageIndex = 0;

                    currentLanguageIndex = filteredLanguages
                        .indexWhere((map) => map['talkCode'] == talkLanguage);

                    return Row(
                      children: [
                        CircleFlag(
                            size: 30,
                            filteredLanguages[index]['flagCode'] ?? ''),
                        AppSpacing.gapW12,
                        Text(
                          filteredLanguages[index]['title'] ?? '',
                          style: AppTextStyles.s16w500
                              .copyWith(color: AppColors.button5),
                        ),
                        const Spacer(),
                        (index == currentLanguageIndex)
                            ? const Icon(Icons.done, color: AppColors.button5)
                            : const SizedBox(),
                      ],
                    );
                  }),
                  AppSpacing.gapH16,
                  if (index != filteredLanguages.length - 1) ...[
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

// var _languages = [
//   LanguageItem(name: 'Vietnamese', icon: Assets.icons.vietnam),
//   LanguageItem(name: 'English', icon: Assets.icons.english),
//   LanguageItem(name: 'French', icon: Assets.icons.french),
//   LanguageItem(name: 'Japanese', icon: Assets.icons.japan),
//   LanguageItem(name: 'Korean', icon: Assets.icons.korean),

//   // thieu 1 nuoc
//   // LanguageItem(name: 'Chinese', icon: Assets.icons.china),

//   // LanguageItem(name: 'Argentinean', icon: Assets.icons.argentinean),
//   // LanguageItem(name: 'Canadian', icon: Assets.icons.canadian),
//   // LanguageItem(name: 'Spanish', icon: Assets.icons.spanish),
//   // LanguageItem(name: 'Brazilian', icon: Assets.icons.brazilian),
//   // LanguageItem(name: 'German', icon: Assets.icons.german),
// ];
