part of 'search_detail_screen.dart';

extension Content on SearchDetailScreen {
  Widget _content(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search result text
                Obx(() {
                  if (controller.bookSearchText.value.isNotEmpty ||
                      controller.bookSearchText.value.trim().isNotEmpty) {
                    return _buildFilterRow(
                        'Search result for ${controller.searchController.value.text}',
                        () => controller.bookSearchText.value = '');
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                // Sort by text
                Obx(() {
                  if (controller.sortBy.value.isNotEmpty) {
                    return _buildFilterRow(
                      'Sort by: ${controller.sortBy.value}',
                      () =>
                          controller.sortBy.value = '', // Clear sort by filter
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                // Evaluate text
                Obx(() {
                  if (controller.evaluate.value.isNotEmpty) {
                    return _buildFilterRow(
                      'Evaluate: ${controller.evaluate.value}',
                      () => controller.evaluate.value =
                          [], // Clear evaluate filter
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                // Format text
                Obx(() {
                  if (controller.format.value.isNotEmpty) {
                    return _buildFilterRow(
                      'Format: ${controller.format.value}',
                      () => controller.format.value = [], // Clear format filter
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                //From Price text
                Obx(() {
                  if (controller.fromPrice.value != 0.1 &&
                      controller.toPrice.value != 0.1) {
                    return _buildFilterRow(
                      'Price: ${controller.fromPrice.value.toStringAsFixed(0)} LP - ${controller.toPrice.value.toStringAsFixed(0)} LP',
                      () {
                        controller.fromPrice.value = 0.1;
                        controller.toPrice.value = 0.1;
                      }, // Clear price filter
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                // //To Price text
                // Obx(() {
                //   if (controller.toPrice.value != 0.1) {
                //     return _buildFilterRow(
                //       'To Price: ${controller.toPrice.value}',
                //       () =>
                //           controller.toPrice.value = 0.1, // Clear price filter
                //     );
                //   } else {
                //     return const SizedBox.shrink();
                //   }
                // }),

                // Author text
                Obx(() {
                  if (controller.author.value.isNotEmpty) {
                    return _buildFilterRow(
                      'Author: ${controller.author.value}',
                      () => controller.author.value = [], // Clear author filter
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                // State text
                Obx(() {
                  if (controller.state.value.isNotEmpty) {
                    return _buildFilterRow(
                      'State: ${controller.state.value}',
                      () => controller.state.value = '', // Clear state filter
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                // Categories text
                Obx(() {
                  if (controller.categories.value.isNotEmpty) {
                    return _buildFilterRow(
                      'Categories: ${controller.categories.value}',
                      () => controller.categories.value =
                          [], // Clear categories filter
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                // Publishers text
                Obx(() {
                  if (controller.publishers.value.isNotEmpty) {
                    return _buildFilterRow(
                      'Publishers: ${controller.publishers.value}',
                      () => controller.publishers.value =
                          [], // Clear publishers filter
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                // Languages text
                Obx(() {
                  if (controller.languages.value.isNotEmpty) {
                    return _buildFilterRow(
                      'Languages: ${controller.languages.value}',
                      () => controller.languages.value =
                          [], // Clear languages filter
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                // From Publication Year text
                Obx(() {
                  if (controller.fromPublicationYear.value != 1 &&
                      controller.toPublicationYear.value != 1) {
                    return _buildFilterRow(
                      'Publication Year: ${controller.fromPublicationYear.value} - ${controller.toPublicationYear.value}',
                      () {
                        controller.fromPublicationYear.value = 1;
                        controller.toPublicationYear.value = 1;
                      }, // Clear publication year filter
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build a filter row with a clear button
  Widget _buildFilterRow(String text, VoidCallback onClear) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 16,
            ),
            softWrap: true, // Enable wrapping to the next line
          ),
        ),
        const SizedBox(width: 4), // Space between text and button
        IconButton(
          onPressed: () {
            onClear();
            controller.searchController.value.text = '';
            // Call the searchBooks method with updated values
            controller.searchBooks(
              controller.searchController.value.text,
              controller.sortBy.value,
              controller.evaluate.value,
              controller.format.value,
              controller.author.value
                  .map((author) => author.toString())
                  .toList(),
              controller.state.value,
              controller.categories.value
                  .map((category) => category.toString())
                  .toList(),
              controller.fromPrice.value,
              controller.toPrice.value,
              controller.publishers.value,
              controller.languages.value,
              controller.fromPublicationYear.value,
              controller.toPublicationYear.value,
            );
          },
          icon: Icon(
            Icons.clear,
            color: AppColor.textColor,
            size: 16,
          ),
          padding: EdgeInsets.zero, // Make the button small
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
