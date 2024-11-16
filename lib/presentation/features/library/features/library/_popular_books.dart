part of 'library_screen.dart';

extension PopularBooks on LibraryScreen {
  Widget _popular_books(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
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
                  child: Image.asset(IconConstants.popular),
                ),
                Expanded(
                    child: Text(
                  'Popular books'.tr,
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )),
                GestureDetector(
                  onTap: () {
                    List<BookRaw> list = controller.trendingBooks
                        .map((e) => BookRaw.fromBookMostPopular(e))
                        .toList();
                    Get.toNamed(AppRoutes.SeeMore,
                        arguments: {'title': 'Popular books'.tr, 'list': list});
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
            Obx(() {
              if (controller.trendingBooks.isEmpty) {
                return SizedBox(); // Return an empty SizedBox to avoid gaps
              }
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      height:
                          300, // Chiều cao của ListView để cuốn sách vừa hiển thị theo chiều ngang
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        scrollDirection:
                            Axis.horizontal, // Cuộn theo chiều ngang
                        itemCount: controller
                            .trendingBooks.length, // Số lượng sách hiển thị
                        itemBuilder: (context, index) {
                          final book = controller.trendingBooks[index];
                          return Container(
                            width: Get.width / 2 - 20,
                            margin: const EdgeInsets.only(right: 10),
                            child: bookItem(
                              title: book.title,
                              image: book.imageUrl,
                              author: book.author?.name,
                              category: (book.categories != null ||
                                      book.categories == '' ||
                                      book.categories == 'Unknown')
                                  ? book.categories!.split(',').first
                                  : null,
                              price: book.price?.toString(),
                              ageAverage: controller
                                  .calculateBookAge(book.ageAverage ?? 0),
                              onTap: () {
                                Get.toNamed(AppRoutes.BookDetail,
                                    arguments: {'idBook': book.id});
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            })
          ],
        ));
  }
}
