import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/gen/assets.gen.dart';
import '../../../../resource/styles/styles.dart';
import '../controllers/profile_controller.dart';

class ProfileBusinessView extends BaseView<ProfileController> {
  const ProfileBusinessView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (controller.isUpdateProfileFirstLogin) {
          return Future.value(false);
        }

        return Future.value(true);
      },
      child: CommonScaffold(
        hideKeyboardWhenTouchOutside: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Assets.images.nftVip
                  .image(fit: BoxFit.fitWidth, width: double.infinity),
              // tô màu phần bị thiếu của form
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: 1.sw,
                    height: 0.1.sh,
                    color: AppColors.blue4,
                  )),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacing.gapH20,
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: AppIcon(
                        icon: AppIcons.arrowLeft,
                        color: AppColors.white,
                      ),
                    ).paddingOnly(left: 20),
                    Stack(
                      children: [
                        formUpdateProfileWidget(context),
                        editAvatarWidget().paddingOnly(left: 0.075.sw),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget editAvatarWidget() {
    return Row(
      children: [
        _buildAvatar(),
        AppSpacing.gapW20,
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.button5),
            color: const Color(0xff5b83ae).withOpacity(0.66),
          ),
          child: Text(
            l10n.my_profile__add_profile_picture,
            style: AppTextStyles.s16w500.text2Color,
          ).clickable(() {
            controller.openImageOption();
          }),
        ),
      ],
    );
  }

  Widget builditemSetting(
          Object icon, Color color, String title, Function() onTap) =>
      Row(
        children: [
          AppIcon(
            icon: icon,
            color: color,
          ),
          AppSpacing.gapW12,
          Text(
            title,
            style: AppTextStyles.s16w600.text2Color,
          ),
          const Spacer(),
          AppIcon(
            icon: AppIcons.arrowRight,
            color: AppColors.button5,
          )
        ],
      ).clickable(() {
        onTap();
      });

  Widget buildContainerGroupItem(Widget child) => Container(
      padding: AppSpacing.edgeInsetsH16,
      width: 0.85.sw,
      decoration: BoxDecoration(
        color: AppColors.blue4,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25))
        // ],
      ),
      child: child);

  Widget _buildAvatar() {
    return Obx(
      () => SizedBox(
        width: 120.w,
        height: 120.w,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Container(
              child: controller.isAvatarLocal.value
                  ? Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(
                            File(controller.imagePath.value),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).clickable(() {
                      controller.openImageOption();
                    })
                  : AppCircleAvatar(
                      size: 120.w,
                      url: controller.currentUser.avatarPath ?? '',
                    ),
            ),
            // Positioned(
            //   right: 0,
            //   bottom: -5,
            //   child: Container(
            //     height: 40,
            //     width: 40,
            //     decoration: BoxDecoration(
            //       color: AppColors.button5,
            //       shape: BoxShape.circle,
            //       border: Border.all(
            //         color: Colors.white,
            //         width: 0.5,
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: AppIcon(icon: AppIcons.camera),
            //     ),
            //   ).clickable(() {
            //     openImageOption();
            //   }),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldName(
    TextEditingController controller,
    TextInputAction textInputAction, {
    String? Function(String?)? validator,
    Function(String)? onChanged,
    bool readOnly = false,
    String? hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return AppTextField(
      textInputAction: textInputAction,
      controller: controller,
      style: AppTextStyles.s16w500.text2Color,
      fillColor: Colors.transparent,
      border: InputBorder.none,
      cursorColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      readOnly: readOnly,
      hintText: hintText,
      hintStyle: AppTextStyles.s16w500.copyWith(color: AppColors.white),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }

  Widget _buildButtonComplete() => AppButton.secondary(
        label: Get.context!.l10n.button__save,
        color: AppColors.button5,
        width: double.infinity,
        onPressed: () {
          controller.updateProfile();
        },
      );

  Widget formUpdateProfileWidget(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 40.w),
        padding: EdgeInsets.only(top: 100.w, bottom: 16),
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewInsets.bottom -
            100 -
            40,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: AppColors.blue4,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              buildContainerGroupItem(Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextFieldName(
                          controller.firstNameController,
                          TextInputAction.next,
                          hintText: l10n.my_profile__first_name,
                          onChanged: (value) {
                            controller.setDisableSave();
                          },
                        ),
                      ),
                      AppSpacing.gapW12,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: const LinearGradient(colors: [
                            Color(0xff061F64),
                            Color(0xff124DD6),
                          ]),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'BUSINESS',
                              style: AppTextStyles.s12w600
                                  .copyWith(color: Colors.white, fontSize: 12),
                            ),
                            AppSpacing.gapW4,
                            AppIcon(
                              icon: Assets.images.iconBusiness,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const AppDivider(
                    color: AppColors.white,
                  ),
                  _buildTextFieldName(
                    controller.lastNameController,
                    controller.currentUser.phone != null
                        ? TextInputAction.done
                        : TextInputAction.next,
                    hintText: l10n.my_profile__last_name,
                    onChanged: (value) {
                      controller.setDisableSave();
                    },
                  ),
                  const AppDivider(
                    color: AppColors.white,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextFieldName(
                          controller.usernameController,
                          TextInputAction.next,
                          hintText: l10n.my_profile__username,
                          onChanged: (value) {
                            controller.setFillUsername =
                                controller.usernameController.text.isNotEmpty;

                            controller.setDisableSave();
                          },
                        ),
                      ),
                      Obx(() => controller.isFillUsername.value
                          ? AppSpacing.emptyBox
                          : Text(
                              '@${currentUser.nickname ?? ''}',
                              style: AppTextStyles.s16w500.text2Color,
                            ))
                    ],
                  ),
                ],
              )),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 0.075.sw),
                child: Text(
                  l10n.my_profile__remind,
                  style: AppTextStyles.s14w500.text2Color,
                ),
              ),
              buildContainerGroupItem(
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        l10n.my_profile__date_of_birth,
                        style: AppTextStyles.s16w500
                            .copyWith(color: AppColors.text2),
                      ),
                    ),
                    AppSpacing.gapW12,
                    Expanded(
                      child: Obx(
                        () => Text(
                          controller.birthDay.value != '' &&
                                  controller.birthDay.value != 'null'
                              ? controller.birthDay.value
                              : '---',
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s16w500.text2Color,
                        ),
                      ),
                    ),
                  ],
                ).clickable(() {
                  int selectedDay = DateTime.now().day;
                  int selectedMonth = DateTime.now().month;
                  int selectedYear = DateTime.now().year;

                  final List<int> days =
                      List<int>.generate(31, (index) => index + 1);
                  final List<int> months =
                      List<int>.generate(12, (index) => index + 1);
                  final List<int> years = List<int>.generate(
                      100, (index) => DateTime.now().year - 100 + index);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 0.3.sh,
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                      initialItem: selectedDay - 1),
                                  itemExtent: 32.0,
                                  onSelectedItemChanged: (index) {
                                    selectedDay = days[index];
                                    HapticFeedback.selectionClick();
                                  },
                                  children: days
                                      .map((day) => Center(
                                              child: Text(
                                            day.toString(),
                                            style: AppTextStyles.s18w600,
                                          )))
                                      .toList(),
                                ),
                              ),
                              Expanded(
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                      initialItem: selectedMonth - 1),
                                  itemExtent: 32.0,
                                  onSelectedItemChanged: (index) {
                                    selectedMonth = months[index];
                                    HapticFeedback.selectionClick();
                                  },
                                  children: months
                                      .map((month) => Center(
                                              child: Text(
                                            month.toString(),
                                            style: AppTextStyles.s18w600,
                                          )))
                                      .toList(),
                                ),
                              ),
                              Expanded(
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                      initialItem: selectedYear - years[0]),
                                  itemExtent: 32.0,
                                  onSelectedItemChanged: (index) {
                                    selectedYear = years[index];
                                    HapticFeedback.selectionClick();
                                  },
                                  children: years
                                      .map((year) => Center(
                                              child: Text(
                                            year.toString(),
                                            style: AppTextStyles.s18w600,
                                          )))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: AppSpacing.edgeInsetsAll20,
                          child: AppButton.secondary(
                            label: l10n.my_profile__confirm,
                            width: double.infinity,
                            color: AppColors.button5,
                            onPressed: () {
                              if ('$selectedDay/$selectedMonth/$selectedYear' !=
                                  currentUser.birthDay) {
                                controller.birthDay.value =
                                    '$selectedDay/$selectedMonth/$selectedYear';
                              }
                              controller.setDisableSave();
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 0.075.sw),
                  child: Text(
                    l10n.my_profile__everyone_can_see_your_birthday,
                    style: AppTextStyles.s14w500.text2Color,
                  ),
                ),
              ),
              buildContainerGroupItem(Column(
                children: [
                  _buildTextFieldName(
                    controller.knowledgeController,
                    TextInputAction.next,
                    hintText: l10n.my_profile__your_knowledge,
                    onChanged: (p0) {
                      controller.setDisableSave();
                    },
                  ),
                  const AppDivider(
                    color: AppColors.subText3,
                  ),
                  _buildTextFieldName(
                    controller.jobController,
                    TextInputAction.next,
                    hintText: l10n.my_profile__your_job,
                    onChanged: (p0) {
                      controller.setDisableSave();
                    },
                  ),
                  const AppDivider(
                    color: AppColors.subText3,
                  ),
                  _buildTextFieldName(
                    controller.hobbiesController,
                    TextInputAction.next,
                    hintText: l10n.my_profile__your_hobbies,
                    onChanged: (p0) {
                      controller.setDisableSave();
                    },
                  ),
                ],
              )),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 0.075.sw),
                child: _buildButtonComplete(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
