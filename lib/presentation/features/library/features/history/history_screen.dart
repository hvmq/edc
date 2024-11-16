import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../core/utils/show_noti.dart';
import '../../features/history/history_controller.dart';
import '../../features/history/payment_history_widget.dart';
import '../../features/history/public_book_history_widget.dart';
import '../../features/history/reading_history_widget.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColor.textColor,
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                        const WidgetSpan(child: SizedBox(width: 12)),
                        TextSpan(
                          text: 'History'.tr,
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildCategoryTabs(),
                    const SizedBox(height: 16),
                    _buildFilterOrSortOptions(
                        context), // Updated to dynamically display filter or sort
                    SizedBox(
                      height: 500,
                      child: _buildTabContent(),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildCategoryTab(
                'Public history', IconConstants.iconPublicBook, 0),
            const SizedBox(width: 16),
            _buildCategoryTab('Reading history', IconConstants.iconReading, 1),
            const SizedBox(width: 16),
            _buildCategoryTab('Payment history', IconConstants.iconPayment, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String title, String icon, int index) {
    return GestureDetector(
      onTap: () {
        controller.setTabIndex(index); // Updated with method to show loading
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: controller.tabIndex.value == index
                ? AppColor.blueColor_2.withOpacity(0.3)
                : AppColor.button_5.withOpacity(0.2),
            radius: 40,
            child: Opacity(
              opacity: controller.tabIndex.value == index ? 1.0 : 0.5,
              child: Image.asset(
                icon,
                height: 40,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: controller.tabIndex.value == index
                  ? AppColor.textColor
                  : AppColor.greyColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Method to display filter or sort options
  Widget _buildFilterOrSortOptions(context) {
    final isPublicHistoryTab = controller.tabIndex.value == 0;
    final items =
        isPublicHistoryTab ? controller.statusList : controller.sortTypeList;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // Handle "All" action
            },
            child: Text(
              isPublicHistoryTab
                  ? (controller.selectedStatus.isEmpty
                      ? 'All'.tr
                      : controller.selectedStatus.value)
                  : (controller.selectedSortType.isEmpty
                      ? 'All'.tr
                      : controller.selectedSortType.value),
              style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          GestureDetector(
            onTap: () => _openFilterOrSortDialog(context, isPublicHistoryTab),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: isPublicHistoryTab ? 'Filter' : 'Sort',
                    style: TextStyle(
                      color: AppColor.textColor.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  ),
                  WidgetSpan(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Image.asset(
                        IconConstants.iconSort,
                        height: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Display dialog for filter/sort selection
  void _openFilterOrSortDialog(context, bool isFilter) {
    showFilterOrSortDialog(
      context: context,
      isFilter: isFilter,
      items: isFilter ? controller.statusList : controller.sortTypeList,
      onItemSelected: (selectedItem) {
        if (isFilter) {
          controller.selectedStatus.value = selectedItem;
          controller.applyFilter(selectedItem);
        } else {
          controller.selectedSortType.value = selectedItem;
          controller.applySort(selectedItem);
        }
      },
    );
  }

  Widget _buildTabContent() {
    return Obx(() {
      if (controller.tabIndex.value == 0) {
        return PublicBookHistory(historyItems: controller.approvedBooks.value);
      } else if (controller.tabIndex.value == 1) {
        return ReadingHistoryWidget(
            readingHistoryItems: controller.bookReadingResponse.value);
      } else {
        return PaymentHistoryWidget(
            paymentHistoryItems: controller.paymentHistoryItems.value);
      }
    });
  }
}
