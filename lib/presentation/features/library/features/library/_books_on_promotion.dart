part of 'library_screen.dart';

extension BooksOnPromotion on LibraryScreen {
  Widget _booksOnPromotion(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Image.asset(IconConstants.iconDis),
              ),
              Expanded(
                  child: Text(
                'Books on promotion'.tr,
                style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )),
              GestureDetector(
                onTap: () {
                  List<BookRaw> list = controller.booksOnPromotion
                      .map((e) => BookRaw.fromDiscountedBook(e))
                      .toList();
                  Get.toNamed(AppRoutes.SeeMore, arguments: {
                    'title': 'Books on promotion'.tr,
                    'list': list,
                  });
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
            if (controller.booksOnPromotion.isEmpty) {
              return Center(
                child: Text(
                  'No available books'.tr,
                  style: TextStyle(color: AppColor.textColor, fontSize: 16),
                ),
              ); // Show a message when no books are available
            }
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: 300, // Height of the ListView for horizontal scroll
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal, // Horizontal scroll
                      itemCount: controller.booksOnPromotion.length,
                      itemBuilder: (context, index) {
                        final book = controller.booksOnPromotion[index];
                        return bookItem(
                          title: book.title,
                          image: book.imageUrl,
                          author: book.author?.name,
                          category: (book.categories != null &&
                                  book.categories!.isNotEmpty &&
                                  book.categories != 'Unknown')
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
                    ),
                  );
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
