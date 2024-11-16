import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';
import '../../../../../routing/routing.dart';
import '../../../../all.dart';

class BottomSheetChooseNumber extends StatefulWidget {
  final RegisterController controller;
  final String type;
  final int currentId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? nickname;
  final String? avatarPath;

  const BottomSheetChooseNumber({
    required this.controller,
    required this.type,
    required this.currentId,
    this.firstName,
    this.lastName,
    this.nickname,
    this.avatarPath,
    this.email,
    super.key,
  });

  @override
  State<BottomSheetChooseNumber> createState() =>
      _BottomSheetChooseNumberState();
}

class _BottomSheetChooseNumberState extends State<BottomSheetChooseNumber> {
  TextEditingController searchController = TextEditingController();
  int? currentIndex;
  List<String> phoneNumbers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getListPhoneNumber();
  }

  Future getListPhoneNumber() async {}

  Widget _buildBackground() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.background10,
          ),
        ),
      );

  Widget _buildAppbar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.type == 'number'
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: AppIcon(
                    icon: AppIcons.arrowLeft,
                    color: AppColors.button5,
                  ),
                )
              : const SizedBox(),
          Text(
            Get.context!.l10n.text_choose_number,
            style: AppTextStyles.s20w600.text5Color,
          ),
          const SizedBox(
            width: 32,
          ),
        ],
      );

  Widget _buildSearch() => Container(
        padding: const EdgeInsets.only(left: Sizes.s16),
        margin: const EdgeInsets.all(Sizes.s8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: AppColors.border3,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            AppIcon(
              icon: AppIcons.searchLg,
              color: AppColors.border3,
            ),
            AppSpacing.gapW8,
            Expanded(
              child: TextField(
                controller: searchController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: AppColors.border2),
                  border: InputBorder.none,
                  hintText: Get.context!.l10n.global__search,
                ),
                cursorColor: AppColors.border3,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            AppIcon(icon: AppIcons.refresh).clickable(() {
              getListPhoneNumber();
            }),
            IconButton(
              icon: AppIcon(icon: AppIcons.close),
              onPressed: () {
                setState(() {
                  searchController.clear();
                });
              },
            ),
          ],
        ),
      );

  Widget _buildListNumber() => Expanded(
        child: isLoading
            ? const Center(
                child: AppDefaultLoading(
                  color: AppColors.button5,
                ),
              )
            : Padding(
                padding: AppSpacing.edgeInsetsH12,
                child: ListView.separated(
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 12, right: 30),
                    child: AppDivider(
                      color: AppColors.border3,
                      height: 1,
                    ),
                  ),
                  itemCount: phoneNumbers.length,
                  itemBuilder: (context, index) {
                    return searchController.text == '' ||
                            phoneNumbers[index].contains(searchController.text)
                        ? Row(
                            children: [
                              AppSpacing.gapW12,
                              Text(
                                phoneNumbers[index],
                                style: AppTextStyles.s16Base,
                              ),
                              const Spacer(),
                              AppCheckBox(
                                value: currentIndex == index,
                                onChanged: (value) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                              ),
                            ],
                          )
                        : Container();
                  },
                ),
              ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Padding(
            padding: const EdgeInsets.all(Sizes.s8),
            child: Column(
              children: [_buildAppbar(), _buildSearch(), _buildListNumber()],
            ),
          ),
        ],
      ),
      floatingActionButton: AppButton.secondary(
        onPressed: () {
          Get.offNamed(Routes.resetPassword, arguments: {
            'phone': '111111111',
            'flowFrom': 'register',
          });
        },
        label: context.l10n.choose,
        color: AppColors.button5,
        width: 0.8.sw,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
