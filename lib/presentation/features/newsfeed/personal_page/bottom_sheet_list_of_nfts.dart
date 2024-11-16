import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';

class BottomSheetListOfNFTs extends StatefulWidget {
  const BottomSheetListOfNFTs({
    super.key,
  });

  @override
  State<BottomSheetListOfNFTs> createState() => _BottomSheetListOfNFTsState();
}

class _BottomSheetListOfNFTsState extends State<BottomSheetListOfNFTs> {
  TextEditingController searchController = TextEditingController();
  int? currentIndex;
  List<String> phoneNumbers = [];
  bool isLoading = true;
  bool isUpdating = false;

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
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: AppIcon(
              icon: AppIcons.arrowLeft,
              color: AppColors.button5,
            ),
          ),
          Text(
            Get.context!.l10n.personal_page__list_nft,
            style: AppTextStyles.s20w600.text5Color,
          ),
          const SizedBox(
            width: 32,
          ),
        ],
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
              children: [_buildAppbar(), AppSpacing.gapH20, _buildListNumber()],
            ),
          ),
        ],
      ),
      floatingActionButton: AppButton.secondary(
        onPressed: () async {},
        label: context.l10n.choose,
        color: AppColors.button5,
        width: 0.8.sw,
        isDisabled: currentIndex == null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
