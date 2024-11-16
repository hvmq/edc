part of 'search_detail_screen.dart';

extension ListBook on SearchDetailScreen {
  Widget _listBook(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 2,
                height: 21,
                decoration: BoxDecoration(
                  color: AppColor.greenColor_1,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Image.asset(IconConstants.iconChart),
              ),
              Expanded(
                child: Text(
                  'Search result'.tr,
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Wrap GridView with Obx to listen to changes in listBooks
          Obx(() {
            // Check if listBooks is not empty
            if (controller.listBooks.isEmpty) {
              return Center(
                child: Text(
                  'No books found',
                  style: TextStyle(color: AppColor.textColor),
                ),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final double itemWidth = (constraints.maxWidth - 10) / 2;
                final double itemHeight = itemWidth * 2;

                // Build grid items based on the reactive listBooks
                return GridView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: itemWidth / itemHeight,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: controller.listBooks.length, // Reactive count
                  itemBuilder: (context, index) {
                    final book = controller.listBooks[index];

                    // Safe null checks
                    final categories =
                        book.categories != null && book.categories!.isNotEmpty
                            ? book.categories!.split(',').first
                            : 'Unknown';
                    return bookItem(
                      title: book.title,
                      image: book.imageUrl,
                      author: book.authorName,
                      category: (book.categories != null ||
                              book.categories == '' ||
                              book.categories == 'Unknown')
                          ? book.categories!.split(',').first
                          : null,
                      price: book.price?.toString(),
                      ageAverage:
                          controller.calculateBookAge(book.ageAverage ?? 0),
                      onTap: () {
                        Get.toNamed(AppRoutes.BookDetail,
                            arguments: {'idBook': book.id});
                      },
                    );
                  },
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
