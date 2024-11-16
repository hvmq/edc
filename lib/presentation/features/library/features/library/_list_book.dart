part of 'library_screen.dart';

extension ListBook on LibraryScreen {
  Widget _listBook(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        children: [
          // Header Row
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
                  'Trending books'.tr,
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  List<BookRaw> list = controller.trendingBooks
                      .map((e) => BookRaw.fromBookMostPopular(e))
                      .toList();
                  Get.toNamed(AppRoutes.SeeMore,
                      arguments: {'title': 'Trending books'.tr, 'list': list});
                },
                child: Container(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'See more'.tr,
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 14,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColor.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          // GridView of books
          Obx(() {
            if (controller.trendingBooks.isEmpty) {
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
                final double itemWidth = (constraints.maxWidth - 10) / 2;
                final double itemHeight = itemWidth * 2;
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
                  itemCount: controller.trendingBooks.length,
                  itemBuilder: (context, index) {
                    final book = controller.trendingBooks[index];
                    return bookItem(
                      title: book.title,
                      image: book.imageUrl,
                      author: book.author?.name,
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
