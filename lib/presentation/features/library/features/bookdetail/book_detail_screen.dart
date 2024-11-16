import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../resource/resource.dart';
import '../../api/repos/impl/review_book_api.swagger.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../core/utils/common/commonWidget.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../core/utils/resource/assets_constant/image_constant.dart';
import '../../core/utils/show_noti.dart';
import '../../features/cart/cart_controller.dart';
import '../../features/library/_book_item.dart';
import 'book_detail_controller.dart';

part '_infor_bookdetail.dart';
part '_list_rate.dart';
part '_show_bookdetail_carouse.dart';

class BookDetailScreen extends GetView<BookDetailController> {
  BookDetailScreen({super.key});
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: appBarWidget1(
        title: '',
        onTap1: () {
          _showMore(context);
        },
        onTap2: () => Get.toNamed(AppRoutes.Cart),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.blue));
        }
        return _buildContent(context);
      }),
    );
  }

  Widget _buildContent(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _showBookDetailCarouse(context),
            _inforBookDetail(context, scrollController),
            if (controller.isShowRating.value) _listRate(context),
            if (controller.isShowListBook.value) _buildAuthorBookList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorBookList(BuildContext context) {
    return Obx(() {
      if (controller.authorData['books'] == null ||
          controller.authorData['books'].isEmpty) {
        return Center(
            child: Text('No data available',
                style: TextStyle(color: AppColor.textColor)));
      }

      return SizedBox(
        height: 360,
        child: GridView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2.1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: controller.authorData['books']?.length ?? 0,
          itemBuilder: (context, index) {
            final book = controller.authorData['books'][index];
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: bookItem(
                title: book['title'] ?? 'No title',
                image: book['imageUrl'],
                author: controller.authorData['name'],
                category: book['categories'] != null
                    ? book['categories'].split(',').first
                    : '',
                price: book['price'].toString(),
                ageAverage:
                    controller.calculateBookAge(book['ageAverage'] ?? '0'),
                onTap: () async {
                  Get.toNamed(AppRoutes.BookDetail,
                      arguments: {'idBook': book['id']});
                  controller.isShowListBook.value = false;
                  await controller.init(book['id']);
                },
              ),
            );
          },
        ),
      );
    });
  }

  void _showMore(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.textOppositeColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: Get.height * 0.24,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 80,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColor.textColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              _buildShareButton(),
              _buildReportButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShareButton() {
    return GestureDetector(
      onTap: () {
        Share.share('Check out this awesome link: https://flutter.dev',
            subject: 'Awesome Flutter Link');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Share',
                style: TextStyle(color: AppColor.textColor, fontSize: 16)),
            Icon(Icons.share, color: AppColor.textColor, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildReportButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showReportBottomSheet(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Report',
                style: TextStyle(color: AppColor.textColor, fontSize: 16)),
            Icon(Icons.report, color: AppColor.textColor, size: 24),
          ],
        ),
      ),
    );
  }

  void _showReportBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.textWhileColor,
      isScrollControlled:
          true, // Giúp BottomSheet có thể mở toàn màn hình khi cần
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: Get.height * 0.8, // Sử dụng 80% chiều cao màn hình
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header của BottomSheet
                Center(
                  child: Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColor.textColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Report',
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return ListView.builder(
                            shrinkWrap:
                                true, // To ensure it takes only the space it needs
                            physics:
                                const NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
                            itemCount: controller.reportOptions.length,
                            itemBuilder: (context, index) {
                              return _buildReportOption(
                                  context, controller.reportOptions[index]);
                            },
                          );
                        }),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    // Xử lý khi nhấn Report
                    final String susscess = await controller.postReport(
                        bookId: controller.bookDetail.value.id ?? 0,
                        comments: controller.selectedReportOption.value);
                    Navigator.pop(context);
                    _showReportSuccessBottomSheet(context, susscess);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.blueColor_3,
                    ),
                    child: Text(
                      'Report',
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReportOption(BuildContext context, String title) {
    return Obx(() => ListTile(
          title: Text(
            title,
            style: TextStyle(color: AppColor.textColor, fontSize: 16),
          ),
          leading: Radio<String>(
            value: title,
            groupValue: controller
                .selectedReportOption.value, // Theo dõi giá trị được chọn
            onChanged: (value) {
              controller.selectReportOption(value!);
              print(value);
            },
            activeColor: AppColor.blueColor_3,
          ),
        ));
  }

  void _showReportSuccessBottomSheet(BuildContext context, String susscess) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.textWhileColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColor.textColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Thanks for your report',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Problem',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Text(
                    controller.selectedReportOption.value,
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(height: 16),
              Text(
                'If we find this content to be in violation, we will remove it from Educhain.',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.blueColor_3,
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(color: AppColor.textColor, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
