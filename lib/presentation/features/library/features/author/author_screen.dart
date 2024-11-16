import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../features/author/author_controller.dart';
import '../../features/library/_book_item.dart';

class DetailAuthorScreen extends GetView<DetailAuthorController> {
  const DetailAuthorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Add share functionality here
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(
            () => controller.authorData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  )
                : Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            controller.authorData['avatarUrl'] ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          // Semi-transparent overlay layer
          Container(
            height: 300,
            color: AppColor.greyColor.withOpacity(0.4),
          ),
          Obx(
            () => controller.authorData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColor.textBlackColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        // Author profile picture
                        Obx(
                          () => Container(
                            height: 300,
                            alignment: Alignment.center,
                            child: ClipOval(
                              child: Image.network(
                                controller.authorData['avatarUrl'] ?? '',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.person,
                                  size: 120,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Author Name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Obx(
                            () => Text(
                              controller.authorData['name'] ?? '',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Author Description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Obx(
                            () => Text(
                              controller.authorData['biography'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Books Section
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Books',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        Obx(() {
                          if (controller.authorData['books'] == null ||
                              controller.authorData['books'].length == 0) {
                            return Center(
                              child: Text(
                                'No data available',
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }

                          return LayoutBuilder(
                            builder: (context, constraints) {
                              final double itemWidth =
                                  (constraints.maxWidth - 10) / 2;
                              final double itemHeight = itemWidth * 2;
                              return GridView.builder(
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: itemWidth / itemHeight,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemCount:
                                    controller.authorData['books'] != null
                                        ? controller.authorData['books'].length
                                        : 0,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: bookItem(
                                      title: controller.authorData['books']
                                          [index]['title'],
                                      image: controller.authorData['books']
                                          [index]['imageUrl'],
                                      author: controller.authorData['name'],
                                      category:
                                          controller.authorData['categories'],
                                      price: controller.authorData['books']
                                              [index]['price']
                                          .toString(),
                                      ageAverage: controller.calculateBookAge(
                                        controller.authorData['books'][index]
                                                ['ageAverage'] ??
                                            0,
                                      ),
                                      onTap: () {
                                        Get.toNamed(AppRoutes.BookDetail,
                                            arguments: {
                                              'idBook':
                                                  controller.authorData['books']
                                                      [index]['id']
                                            });
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
