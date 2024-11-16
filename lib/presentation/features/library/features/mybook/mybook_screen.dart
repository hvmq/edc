import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resource/styles/styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../features/library/_book_item.dart';
import '../../features/mybook/mybook_controller.dart';

part '_search.dart';
part '_tab.dart';

class MyBookScreen extends GetView<MybookController> {
  const MyBookScreen({super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                        const WidgetSpan(
                            child: SizedBox(
                          width: 12,
                        )),
                        TextSpan(
                          text: 'Back'.tr,
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
              GestureDetector(
                onTap: () {
                  controller.isShow.value = !controller.isShow.value;
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColor.blueColor_1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                      width: 22,
                      height: 22,
                      child: Image.asset(IconConstants.iconamoon)),
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _search(context),
              _tab(context),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(() {
                    // Show CircularProgressIndicator only if booksByAuthor is empty
                    if (controller.booksByAuthor.isEmpty &&
                        controller.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColor.blueColor_3,
                        ),
                      );
                    }

                    // Display filtered results if search is in use
                    if (controller.searchController.value.text.isNotEmpty) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(
                            4), // Optional padding around the grid
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 10, // Spacing between columns
                          mainAxisSpacing: 10, // Spacing between rows
                          childAspectRatio:
                              0.5, // Adjust this to change item aspect ratio
                        ),
                        itemCount: controller.filteredBooks.length,
                        itemBuilder: (context, index) {
                          final book = controller.filteredBooks[index];
                          return Container(
                            child: bookItem(
                              title: book.title,
                              image: book.imageUrl,
                              author: book.authorName,
                              category: '',
                              price: book.price.toString(),
                              ageAverage:
                                  controller.calculateBookAge(book.ageAverage),
                              onTap: () {
                                Get.toNamed(AppRoutes.BookDetail,
                                    arguments: {'idBook': book.id});
                              },
                            ),
                          );
                        },
                      );
                    }

                    // Default display when search is not active
                    return ListView.builder(
                      itemCount: controller.isAuthor.value == true
                          ? controller.booksByAuthor.keys.length
                          : controller.booksByDate.keys.length,
                      itemBuilder: (context, index) {
                        String authorName;
                        List<BookRaw> authorBooks;
                        if (controller.isAuthor.value) {
                          authorName =
                              controller.booksByAuthor.keys.elementAt(index);
                          authorBooks = controller.booksByAuthor[authorName]!;
                        } else {
                          authorName =
                              controller.booksByDate.keys.elementAt(index);
                          authorBooks = controller.booksByDate[authorName]!;
                        }

                        return Container(
                          width: Get.width,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authorName,
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height:
                                    300, // Fixed height for horizontal ListView
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: authorBooks.length,
                                  itemBuilder: (context, bookIndex) {
                                    final book = authorBooks[bookIndex];
                                    return Container(
                                      width: Get.width / 2 - 20,
                                      margin: const EdgeInsets.only(right: 10),
                                      child: bookItem(
                                        title: book.title,
                                        image: book.imageUrl,
                                        author: book.authorName,
                                        category: '',
                                        price: book.price.toString(),
                                        ageAverage: controller
                                            .calculateBookAge(book.ageAverage),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.BookDetail,
                                              arguments: {
                                                'idBook': book.id,
                                                'tabName':
                                                    controller.tabName.value
                                              });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
          Positioned(
            right: 16,
            top: 0,
            child: GestureDetector(
                onTap: () {},
                child: Obx(() => controller.isShow.value == true
                    ? Container(
                        width: Get.width * 0.4,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.grey7,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                controller.isAuthor.value = true;
                                controller.loadBookByAuthors();
                                //close popup
                                controller.isShow.value = false;
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 4),
                                width: Get.width,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'By Author',
                                  style: TextStyle(
                                    color: AppColor.textColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                controller.isAuthor.value = false;
                                controller.loadBookByDate();
                                // if (controller.isAuthor.value == false) {
                                //   // controller.groupBooksByCategory();
                                // }
                                controller.isShow.value = false;
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 4),
                                width: Get.width,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'By Date',
                                  style: TextStyle(
                                    color: AppColor.textColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container())),
          )
        ],
      ),
    );
  }
}
