import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/color.dart';
import '../../../features/library/_book_item.dart';
import '../../../features/library/see_more/see_more_controller.dart';

class SeeMoreScreen extends GetView<SeeMoreController> {
  const SeeMoreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<BookRaw> bookRaw;

    // Check if Get.arguments is available
    if (Get.arguments != null) {
      final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
      bookRaw = args['list'];
    } else {
      // Handle case when arguments are missing
      bookRaw = [];
    }

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
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: AppColor.textColor,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Back'.tr,
                        style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Text(
                controller.title.value.tr,
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 20,
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        // controller: _scrollController(), // Attach scroll controller for pagination
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Obx(() {
              return Column(
                children: [
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Calculate the width of each item in the grid
                      final double itemWidth = (constraints.maxWidth - 10) /
                          2; // subtract mainAxisSpacing
                      final double itemHeight =
                          itemWidth * 2; // Height-to-width ratio
                      return GridView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          childAspectRatio: itemWidth / itemHeight,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: bookRaw.length,
                        itemBuilder: (context, index) {
                          final book = bookRaw[index];
                          // return bookItemCart(
                          //     book.title ?? 'No title',
                          //     book.imageUrl ?? '',
                          //     book.authorName ?? '',
                          //     book.category ?? '',
                          //     book.price.toString(),
                          //     controller.calculateBookAge(book.ageAverage), () {
                          //   Get.toNamed(AppRoutes.BookDetail,
                          //       arguments: {'idBook': book.id});
                          // }, 0, () {});
                          return bookItem(
                            title: book.title,
                            image: book.imageUrl,
                            author: book.authorName,
                            category: book.category.isNotEmpty == true
                                ? book.category.split(',').first
                                : null,
                            price: book.price.toString(),
                            ageAverage: controller
                                .calculateBookAge(book.ageAverage ?? 0),
                            onTap: () {
                              Get.toNamed(AppRoutes.BookDetail,
                                  arguments: {'idBook': book.id});
                            },
                          );
                        },
                      );
                    },
                  ),
                  if (controller.isLoading.value)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
