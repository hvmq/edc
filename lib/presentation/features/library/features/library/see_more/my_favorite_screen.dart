import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/color.dart';
import '../../../features/library/see_more/see_more_controller.dart';
import '../../../features/search/searchDetail/_filter_dialog.dart';
import '../../../features/search/searchDetail/search_detail_screen.dart';

class MyFavoriteScreen extends GetView<SeeMoreController> {
  const MyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: AppColor.textColor),
                  const SizedBox(width: 8),
                  const Icon(Icons.favorite, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    'Your Favorite List',
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                controller.isEdit.value = !controller.isEdit.value;
              },
              child: Icon(Icons.edit, color: AppColor.textColor),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            // Filter Row
            _filter(context),

            const SizedBox(height: 16),

            // Expanded list to avoid layout issues
            Expanded(
              child: Obx(() => controller.books.isEmpty
                  ? Center(
                      child: Text(
                        'No favorites available',
                        style: TextStyle(color: AppColor.textColor),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.books.length,
                      itemBuilder: (context, index) {
                        final book = controller.books[index];
                        return _buildFavoriteItem(
                          book.title ?? 'No Title',
                          book.imageUrl ?? '',
                          book.price,
                          () {
                            Get.toNamed(AppRoutes.BookDetail,
                                arguments: {'idBook': book.id});
                          },
                          () async {
                            controller.isLoading.value = true;
                            await controller.toggleFavourite(bookId: book.id);
                            // controller.fetchMostPopularBooks();
                            await controller.loadFavoriteBooks();
                            controller.isLoading.value = false;
                          },
                        );
                      },
                    )),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Filter Button
  Widget _buildFilterButton(String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Favorite Item
  Widget _buildFavoriteItem(String title, String? image, double priceVal,
      VoidCallback? onTap, VoidCallback? onTapFavorite) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: GestureDetector(
            onTap: onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: image != null && image.isNotEmpty
                      ? Image.network(
                          image,
                          height: 100,
                          width: 80,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/default_image.png', // Your default image
                          height: 100,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 12),
                // Book Title and Price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: GradientText(
                          controller.getFormattedPrice(priceVal ?? 0.0),
                          style: const TextStyle(fontSize: 15.0),
                          gradientType: GradientType.radial,
                          radius: 2.5,
                          colors: const [
                            Color(0xFF0E81FC), // Màu bắt đầu (#0E81FC)
                            Color(0xFF369C09),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return controller.isEdit.value
                      ? SizedBox(
                          height: 80,
                          child: IconButton(
                            onPressed: onTapFavorite,
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : const SizedBox();
                })
              ],
            )));
  }

  Widget _filter(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.filter.length,
        itemBuilder: (context, index) {
          return Obx(() {
            // Determine the displayed text based on the filter type (categories, authors, etc.)
            String displayedText;
            if (index == 0) {
              // Categories filter
              displayedText = controller.categories.isEmpty
                  ? 'Categories'
                  : controller.listCategories
                      .where((e) => controller.categories.contains(e.id))
                      .map((e) => e.name ?? '')
                      .join(', ');
            } else if (index == 1) {
              // Authors filter
              displayedText = controller.authors.isEmpty
                  ? 'Author'
                  : controller.listAuthors
                      .where((e) => controller.authors.contains(e.id))
                      .map((e) => e.name ?? '')
                      .join(', ');
            } else {
              // Default case (could be for other filters like State, etc.)
              displayedText = controller.filter.isNotEmpty
                  ? controller.filter[index]
                  : 'Filter';
            }

            return GestureDetector(
              onTap: () {
                _showSelectionDialog(context, index);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColor.textBlackColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColor.blueColor_1,
                    width: 2.0,
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    text: displayedText,
                    style: TextStyle(color: AppColor.textWhileColor),
                    children: [
                      const WidgetSpan(child: SizedBox(width: 4)),
                      WidgetSpan(
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: AppColor.textWhileColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  void _showSelectionDialog(BuildContext context, int index) {
    final RxList<String> selectedOptions = <String>[].obs;
    List<String> options;
    const bool isSingleSelection = false;

    switch (index) {
      case 0:
        options = controller.listCategories
            .map((e) => e.name!)
            .toList(); // Categories options
        break;
      case 1:
        options = controller.listAuthors
            .map((e) => e.name!)
            .toList(); // Authors options
        break;
      // case 2:
      //   options = ['New', 'Old']; // State options
      //   isSingleSelection = true;
      //   selectedOptions.value = [controller.state.value];
      //   break;
      default:
        options = [];
    }

    Navigator.of(context).push(SlideRightDialogRoute(
      page: FilterDialog(
        (index, selectedOptions) =>
            _onMultipleOptionsSelected(index, selectedOptions),
        index: index,
        title: controller.filter[index],
        options: options,
        selectedOptions: selectedOptions,
      ),
    ));
  }

  void _onMultipleOptionsSelected(int index, RxList<String> selectedOptions) {
    // Update the corresponding observable variable based on the selected options
    switch (index) {
      case 0: // Categories
        controller.categories.value = controller.listCategories
            .where((category) => selectedOptions.contains(category.name))
            .map((category) => category.id!) // Store only the IDs
            .toList();
        break;
      case 1: // Authors
        controller.authors.value = controller.listAuthors
            .where((author) => selectedOptions.contains(author.name))
            .map((author) => author.id!) // Store only the IDs
            .toList();
        break;
      // case 2: // State filter (if applicable)
      //   controller.state.value = selectedOptions.isNotEmpty ? selectedOptions[0] : '';
      //   break;
    }
    controller.loadFavoriteBooks(); // Load the updated filtered list
  }
}
