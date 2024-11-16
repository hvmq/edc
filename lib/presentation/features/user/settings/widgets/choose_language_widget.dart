import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../all.dart';

class ChooseLanguageWidget extends StatefulWidget {
  final String languageCode;
  final int idUser;
  final String type;
  final SettingController? settingController;
  final String? email;
  final int? currentId;
  final String? currentLastname;
  final String? currentFirstname;
  final String? currentPhone;
  final String? currentAvatar;
  final String? currentNicknme;
  final String? currentEmail;
  final User? user;
  const ChooseLanguageWidget(
      {required this.languageCode,
      required this.idUser,
      required this.type,
      required this.user,
      this.email,
      this.settingController,
      this.currentId,
      this.currentFirstname,
      this.currentLastname,
      this.currentAvatar,
      this.currentPhone,
      this.currentEmail,
      this.currentNicknme,
      super.key});

  @override
  State<ChooseLanguageWidget> createState() => _ChooseLanguageWidgetState();
}

class _ChooseLanguageWidgetState extends State<ChooseLanguageWidget> {
  late final User currentUser;

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredLanguages = [];

  String langCode = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    filteredLanguages = (widget.type == 'dialog')
        ? languages
        : languages.take(5).toList(); // Khởi tạo danh sách ban đầu
    _searchController
        .addListener(_filterLanguages); // Lắng nghe thay đổi tìm kiếm
  }

  void _filterLanguages() {
    setState(() {
      filteredLanguages = (widget.type == 'dialog')
          ? languages
              .where((language) => language['title']!
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
              .toList()
          : languages
              .take(5)
              .toList()
              .where((language) => language['title']!
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.background10,
            ),
          ),
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Container(
              //     decoration: const BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.all(Radius.circular(30))),
              //     width: 0.2.sw,
              //     height: 5,
              //   ),
              // ),
              Row(
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: AppIcon(icon: AppIcons.arrowLeft)),
                  Center(
                    child: Text(
                      context.l10n.setting__select_language,
                      style: AppTextStyles.s18w600,
                    ),
                  ),
                  // Text(
                  //   context.l10n.setting__done,
                  //   style: AppTextStyles.s16Base,
                  // ).clickable(() async {
                  //   if (widget.type == 'dialog') {
                  //     await _userRepo.updateProfile(
                  //         id: widget.currentId ?? 0,
                  //         firstName: widget.currentFirstname ?? '',
                  //         lastName: widget.currentLastname ?? '',
                  //         phone: widget.currentPhone ?? '',
                  //         avatarPath: widget.currentAvatar ?? '',
                  //         nickname: widget.currentNicknme ?? '',
                  //         email: widget.currentEmail ?? '',
                  //         talkLanguage: languages[currentIndex]['talkCode'],
                  //         birthDay: currentUser.birthDay,
                  //         knowledge: currentUser.knowledge,
                  //         job: currentUser.job,
                  //         hobbies: currentUser.hobbies);
                  //     final userUpdated =
                  //         await _userRepo.getUserById(widget.currentId ?? 0);

                  //     Get.find<AppController>().setLoggedUser(userUpdated);
                  //     Navigator.pop(
                  //         context, languages[currentIndex]['talkCode']);
                  //   } else {
                  //     Get.find<LanguageController>()
                  //         .changeLanguage(languages[currentIndex]['langCode']!);
                  //     Get.back();
                  //   }
                  // })
                ],
              ),
              AppSpacing.gapH20,
              if (widget.type == 'dialog')
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
              AppSpacing.gapH20,
              Text(
                context.l10n.language__choose_your_language,
                style: AppTextStyles.s16Base.subText2Color,
              ),
              // Thêm thanh tìm kiếm

              AppSpacing.gapH16,
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: filteredLanguages.length,
              //     itemBuilder: (context, index) => Row(
              //       children: [
              //         CircleFlag(
              //             size: 30, filteredLanguages[index]['flagCode'] ?? ''),
              //         AppSpacing.gapW12,
              //         Expanded(
              //           child: Text(
              //             filteredLanguages[index]['title'] ?? '',
              //             overflow: TextOverflow
              //                 .ellipsis, // Cắt bớt văn bản nếu quá dài
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLanguages.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      CheckboxListTile(
                        title: Row(
                          children: [
                            CircleFlag(
                                size: 30,
                                filteredLanguages[index]['flagCode'] ?? ''),
                            AppSpacing.gapW12,
                            Expanded(
                              child: Text(
                                filteredLanguages[index]['title'] ?? '',
                                overflow: TextOverflow
                                    .ellipsis, // Cắt bớt văn bản nếu quá dài
                              ),
                            ),
                          ],
                        ),
                        value: filteredLanguages[index]['talkCode'] == langCode,
                        onChanged: (value) async {},
                        side: const BorderSide(color: AppColors.border2),
                        checkColor: AppColors.text2,
                        fillColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(WidgetState.selected)) {
                              return AppColors.button5;
                            }

                            return Colors.transparent;
                          },
                        ),
                      ),
                      const AppDivider()
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
